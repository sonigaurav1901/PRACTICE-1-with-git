public class fetchContacts {
    @AuraEnabled
    public static List<Contact> main()
    {
        List<Contact> conList = [Select Lastname from Contact ];
        return conList;
    }

    @AuraEnabled
    public static void insConRecords(List<String> con)
    {
        System.debug(con);
        List<currentContacts__c> insertingRec = new List<currentContacts__c>();
        List<currentContacts__c> conLi = [Select Id__c from currentContacts__c];
        delete conLi;
        // integer i = 0;
        for(String ides:con)
        {
            // ides=(String)ides;
            currentContacts__c c = new currentContacts__c(Id__c = ides , Name=ides );
            insertingRec.add(c);
            // i++;
        }
        
        insert insertingRec;

        System.debug('Record inserted Sucessfully  '+insertingRec);
    }

    @AuraEnabled
    public static List<Contact> fechSelectedConRec()      
    {
        List<currentContacts__c> local = [Select Id__c from currentContacts__c];
        System.debug(local);

        List<Id> ids=new List<id>();
        for(currentContacts__c ca:local)
        {
            ids.add(ca.Id__c);
        }
        
        List<Contact> conLi = [Select Name,Id from contact where Id In :ids];
        System.debug(conLi);
        return conLi;
    }

    @AuraEnabled
    public static List<Contact> onSearchCon(String val)
    {
        System.debug(val);
        String a = '%'+val+'%';
        System.debug(a);
        List<Contact> conList = [Select LastName from Contact where LastName like :a];

        return conList;
    }


}