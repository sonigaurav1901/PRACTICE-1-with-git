public class fetchAccounts {
    @AuraEnabled
    public static List<Account> main()
    {
        List<Account> accList = [Select name from Account ];
        return accList;
    }
    
    @AuraEnabled
    public static void insRecords(List<String> acc)
    {
        System.debug(acc);
        List<currentAccount1__c> insertingRec = new List<currentAccount1__c>();
        List<currentAccount1__c> cAcc = [Select Id__c from currentAccount1__c];
        delete cAcc;
        // integer i = 0;
        for(String ides:acc)
        {
            // ides=(String)ides;
            currentAccount1__c c = new currentAccount1__c(Id__c = ides , Name=ides );
            insertingRec.add(c);
            // i++;
        }
        
        insert insertingRec;

        System.debug('Record inserted Sucessfully  '+insertingRec);
    }
    

    @AuraEnabled
    public static List<Account> fechSelectedRec()      
    {
        List<currentAccount1__c> local = [Select Id__c from currentAccount1__c];
        System.debug(local);

        List<Id> ids=new List<id>();
        for(currentAccount1__c ca:local)
        {
            ids.add(ca.Id__c);
        }
        
        List<Account> accLi = [Select name,Id from Account where Id In :ids];
        System.debug(accLi);
        return accLi;
    }
    
    
    @AuraEnabled
    public static List<Account> onSearch(String val)
    {
        String a = '%'+val+'%';
        List<Account> accList = [Select Name from Account where Name like :a];
        return accList;
    }
}