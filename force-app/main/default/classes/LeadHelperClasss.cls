public class LeadHelperClasss 
{
    public static void fetchRatio1(List<Lead> leadees)
    {
        List<Lead> duplicateLeads = leadees.clone() ;
        List<usersTask__c> users = [select Name , Id , ratio__c From usersTask__c Order By CreatedDate];
        Map<Id,List<String>> m1 = new Map<Id,List<String>>();
        Set<Id> userIds = new Set<Id>();
        for( usersTask__c user : [select Name , Id , ratio__c From usersTask__c Order By CreatedDate] ){
            userIds.add( user.Id );
        }
        List<lead> assignedLeads = [select Name,usersTask__c,Email, LastName from Lead where usersTask__c IN :userIds];
		
        for(lead l:assignedLeads)
        {
            //System.debug('Assigned Leads are : '+l.Name+'----'+l.usersTask__c);
            List<String> l1 = new List<String>();
            Lead tempLead = new Lead(LastName = l.Name , Email = l.Email , usersTask__c = l.usersTask__c);
            l1.add(tempLead.LastName);
            //String na = l.Name ;
            //System.debug('Map userTask is ..'+l.usersTask__c);
            //System.debug('templead name is : '+tempLead.LastName);
            
            if(m1.containsKey(l.usersTask__c))
            {
                List<String> lea = m1.get(l.usersTask__c);
                lea.add(l.LastName);
                m1.put(l.usersTask__c , lea);
            }
            else
            {
            	m1.put(l.usersTask__c , l1 );
            }
            
            /*if(!m1.containsKey(l.usersTask__c)){
                m1.put( l.usersTask__c, new List<String>() );
				m1.get( l.usersTask__c ).add( l.LastName );
            }*/
            
        }
        System.debug('Map is --> '+m1);
        
        integer currentUser = 0 ;
        integer count = 0 ;
        for(integer i=0 ; i < duplicateLeads.size() ; i++)
        {
            count++;
            List<String> listLead = m1.get(users[currentUser].id);
            //duplicate Lead found
            System.debug('ListLead---> '+listLead);
            System.debug('=============');
            System.debug('Serching name is : '+duplicateLeads[i].LastName);
            System.debug('is it true -'+listLead.contains(duplicateLeads[i].LastName));
            //integer num = currentUser ;
            //integer count1 = count ;
            boolean dup = false; 
            String lName = duplicateLeads[i].LastName;
            if(listLead.contains(duplicateLeads[i].LastName))
            {
                currentUser = checkDup( users, currentUser, lName, m1 );
                //1
            }
            System.debug('CU:'+currentUser);
            System.debug('usrs:'+users);
            duplicateLeads[i].usersTask__c = users[currentUser].id ;    
            //System.debug(i +' th Lead ------ '+currentUser+' currentUser');
            
            if(users[currentUser].ratio__c == count)
            {
                System.debug('Inside if of duplicate found');
            	currentUser++;   
                count = 0 ;
            }
            if(currentUser == users.size() )
            {
                currentUser = 0 ;
                count = 0 ;
            }
        }
    }
    
    static Integer checkDup( List<usersTask__c> users, Integer currentUser, String lName, Map<Id,List<String>> m1  )
    {
        List<String> listLead = m1.get(users[currentUser].id);
        System.debug(currentUser);
        if(listLead.contains(lName))
        {
            System.debug('Duplicate user:'+users[currentUser]);
            if(currentUser == users.size()-1)
            {
                return currentUser;
            }
            currentUser = checkDup(users, currentUser+1, lName, m1);
        }
        else
        {
            System.debug('CurentUser -->:'+currentUser);
            return currentUser;
        }
        return currentUser;
    }
}

//1
				/*System.debug('Dup'+listLead);
                dup = true;
                System.debug('insede while loop...');
                if(currentUser == users.size()-1)
                {
                    currentUser=0;
                    count=0;
                    system.debug('num===== 0 ');
                }
                else
                {
                    currentUser++;
                	count=0;
                    system.debug('num===== ++ ');
                }*/