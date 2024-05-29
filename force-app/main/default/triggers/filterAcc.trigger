trigger filterAcc on Account (after update) 
{
    System.debug('account trigger');
    Test_Platform_Event__e tpe = new Test_Platform_Event__e();
    tpe.Description__c = 'message kya liku samaj nahi araha he...';
    insert tpe;
    EventBus.publish(tpe);    
    
    /*  
        String jsonString = json.serialize(Trigger.NEW);
        System.debug('Json String is : '+jsonString);
        quickBook.accesToken(jsonString);
    */
    /*    Map<String ,currentAccount1__c> allrec = currentAccount1__c.getAll();
    
    System.debug('Map');
    System.debug(allrec);
    
    Boolean flag;
    if(trigger.isBefore)
    {
        if(trigger.isUpdate)
        {
            for(Account a: trigger.new)
            {
                if(allrec.containsKey(a.Id))
                {
                    a.AnnualRevenue=10000;
                }
                else
                {   
                    a.addError('You not having permission to update ');
                }
            }            
        }
    
    }*/
}