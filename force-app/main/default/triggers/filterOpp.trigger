trigger filterOpp on Opportunity (before update) 
{
    // Map<String ,currentOpportunity__c> allrec = currentOpportunity__c.getAll();
    // System.debug('Map');
    // System.debug(allrec);

    // if(trigger.isBefore)
    // {
    //     if(trigger.isUpdate)
    //     {
    //         for(Opportunity opp: trigger.new)
    //         {
    //             if(allrec.containsKey(opp.Id))
    //             {
    //                 opp.Amount=10000;
    //             }
    //             else
    //             {   
    //                 opp.addError('You not having permission to update ');
    //             }
    //         }            
    //     }
    // }
}