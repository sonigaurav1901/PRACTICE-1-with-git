Public class SalaryHelperClass 
{
	public static void afterInsert(List<Salary__c> sal)
    {
        Double totalAmt = 0;
        System.debug('inside insert method');
        Map<String,Double> AccTotalAmount = new Map<String,Double>();
        for(Integer i = 0 ; i < sal.size() ; i++)
        {
        	System.debug('sal details => '+sal[i]);
            System.debug('sal account => '+sal[i].Account__c);
            System.debug('sal amount => '+sal[i].Amount__c);
            
            if(!AccTotalAmount.containsKey(sal[i].Account__c))
            {
                AccTotalAmount.put( sal[i].Account__c , sal[i].Amount__c );
            }
            else
            {
                Double amt = AccTotalAmount.get( sal[i].Account__c );
                amt = amt + sal[i].Amount__c ; 
                AccTotalAmount.put( sal[i].Account__c , amt );
            }
        }
        List<Account> accList = new List<Account>();
        List<Account> queryAcc = [select Name , Total_Amount__c from Account where Id In :AccTotalAmount.keySet()];
        System.debug('query Acc is => '+queryAcc);
        for(Account a: queryAcc)
        {
            if(a.Total_Amount__c != null)
            {
            	a.Total_Amount__c = a.Total_Amount__c + AccTotalAmount.get(a.Id);
         		accList.add(a);    
            }
            else
            {
                a.Total_Amount__c = AccTotalAmount.get(a.Id);
         		accList.add(a);    
            }
               
        }
        
        update accList;
    }
    
    public static void afterUpdate(Map<Id,Salary__c> oldSal ,Map<Id,Salary__c> newSal)
    {
        set<Id> salIdes = oldSal.keySet();
        
        set<Id> accIdes = new set<Id>();
		
        List<Salary__c> sal = [select Name , Account__c from Salary__c where Account__c != null AND Id IN :oldSal.keySet()] ;
        for(Salary__c s:sal)
        {
            accIdes.add(s.Account__c);
        }
        
        Map<Id,Double> amtdiff = new Map<Id,Double>();
        for(Salary__c idea:newSal.values())
        {
            Id ide=idea.Account__c ;
            System.debug('acc ==> '+ide+' === '+oldSal.get(idea.Id));
            if(oldSal.get(idea.Id).Amount__c != null)
            {	
                
                Double oldAmt = oldSal.get(idea.Id).Amount__c;
                Double newAmt = newSal.get(idea.Id).Amount__c;
                Double difference = newAmt - oldAmt;
                if(!amtdiff.containsKey(ide))
                {
                    amtdiff.put( ide , difference );
                }
                else
                {
                    Double amt = amtdiff.get( ide );
                    amt = amt + difference ; 
                    amtdiff.put( ide , amt );
                }        
            }  
        }
        
        List<Account> accList = new List<Account>();
        List<Account> queryAcc = [select Name , Total_Amount__c from Account where Id In :amtdiff.keySet()];
        System.debug('query Salary is => '+queryAcc);
        
        for(Account a:queryAcc)
        {
            if(amtdiff.containsKey(a.Id))
            {
                a.Total_Amount__c = a.Total_Amount__c + amtdiff.get(a.Id);
                accList.add(a);
            }
        }
        
        update accList;
    }
}