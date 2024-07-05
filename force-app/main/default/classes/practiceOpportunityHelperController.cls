public with sharing class practiceOpportunityHelperController {
    public static void validateOpp(List<Opportunity> opportunitiesNewRecord) {
        
        Set<Id> AccountIdes = new Set<Id>();
        Map<Id,Integer> accountOppCount = new Map<Id,Integer>();

        for (Opportunity opp : opportunitiesNewRecord) {
            if (opp.AccountId != null) {
                AccountIdes.add(opp.AccountId);
            }
        } 
        List<Opportunity> fetchedOpportunities = [SELECT Id,Name,StageName,AccountId FROM Opportunity WHERE AccountId IN :AccountIdes AND StageName != 'Closed Won' AND StageName != 'Closed Lost'];

        for(Opportunity opp : fetchedOpportunities) {
            if (accountOppCount.containsKey(opp.AccountId)) {
                Integer count = accountOppCount.get(opp.AccountId);
                accountOppCount.put(opp.AccountId , count+1);
            } else {
                accountOppCount.put(opp.AccountId , 1);
            }
        }

        for(Opportunity opp : opportunitiesNewRecord) {    
            if (opp.AccountId != null) {    
                if (accountOppCount.containsKey(opp.AccountId)) {
                    Integer count = accountOppCount.get(opp.AccountId);
                    if (count <= 5) {
                        accountOppCount.put(opp.AccountId , count+1);
                    } else {
                        opp.addError('Can not create new Opportunity as it associated account alredy have 5 or more open Opportunity');
                    }
                } else {
                    accountOppCount.put(opp.AccountId , 1);
                }
            }      
        }

    }
}