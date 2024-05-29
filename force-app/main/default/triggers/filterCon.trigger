trigger filterCon on Contact (before update) 
{
  /*  Map<String ,currentContacts__c> allrec = currentContacts__c.getAll();
    
    System.debug('Map');
    System.debug(allrec);
    
    Boolean flag;
    if(trigger.isBefore)
    {
        if(trigger.isUpdate)
        {
            for(Contact a: trigger.new)
            {
                if(allrec.containsKey(a.Id))
                {
                    a.Amount__c=10000;
                }
                else
                {   
                    a.addError('You not having permission to update ');
                }
            }            
        }
    }*/
}