global class batchClassOnLead implements Database.Batchable <sObject>, Database.Stateful {
    
	Public List<Lead> globalLeadList= new List<Lead>();

    global batchClassOnLead(List<Lead> leads)
    {
        System.debug('First => '+leads);
		this.globalLeadList = leads;
    }
    
    global Database.QueryLocator Start(Database.BatchableContext bc){
        
        String query = 'Select Name,Email,Industry,Status,MobilePhone,External_id__c from Lead ';
        System.debug('Query is : '+query);
        return Database.getQueryLocator(query) ;
        
    }
    
    global void Execute(Database.BatchableContext bc, list<sObject> ListName)
    {    
        System.debug('global list is : '+this.globalLeadList);
        
        List<Lead> exsistingRec = [select Lastname,Email,Industry,Status,Phone,External_id__c,SICCode__c,findDuplicacy__c from Lead ];
        System.debug('Exsisting record are => '+exsistingRec);
        Map<String,object> m1 = new Map<String,object>();
        
        List<Lead> updatedRec = new List<Lead>();
        List<Lead> insertedRec = new List<Lead>();
        
        for(Lead l : this.globalLeadList)
        {
            String ke = l.LastName+'_'+l.findDuplicacy__c ;
            m1.put(ke, l);
        } 
        
        System.debug('Exsisting data in map is ==> '+m1);
        
        for(Lead exl : globalLeadList)
        {
            String strKey = exl.LastName+'_'+exl.findDuplicacy__c ;
            System.debug('Searhing key is :- '+strKey);
            if(m1.containsKey(strKey))
            {
                System.debug('inside iff');
                
                object currentLead = m1.get(strKey) ;
                System.debug('m1.get(strKey) == > '+currentLead);
                
            }
            else
            {
                
            }
            
            /*
            if(l.findDuplicacy__c == exl.findDuplicacy__c && l.Lastname == exl.Lastname )
            {
                System.debug('Same name , email , phone , siccode ');
                x = true ;
            }
			*/
        }
        
        
    }
            /*
            Boolean x = false ;
            
            if(x)
            {
                System.debug('Record in update form');
             	updatedRec.add( l );    
            }
            else
            {
                System.debug('Rocord in insert form');
             	insertedRec.add( l );   
            }
        } 
        System.debug('inserted List '+insertedRec);
        System.debug('updatesd List '+updatedRec);
	*/
    

    global void Finish(Database.BatchableContext bc)
    {    
    	System.debug('finish method');
    }
}