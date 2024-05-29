public class fetchOpportunity {
    @AuraEnabled
    public static List<Opportunity> fetchOpp()
    {
        List<Opportunity> oppList = [Select Name from Opportunity ];
        return oppList;
    }

    @AuraEnabled
    public static void insOppRecords(List<String> opp)
    {
        System.debug(opp);
        List<currentOpportunity__c> insertingRec = new List<currentOpportunity__c>();
        List<currentOpportunity__c> oppLi = [Select Id__c from currentOpportunity__c];
        delete oppLi;
        // integer i = 0;
        for(String ides:opp)
        {
            // ides=(String)ides;
            currentOpportunity__c c = new currentOpportunity__c(Id__c = ides , Name=ides );
            insertingRec.add(c);
            // i++;
        }
        
        insert insertingRec;

        System.debug('Record inserted Sucessfully  '+insertingRec);
    }

    @AuraEnabled
    public static List<Opportunity> fechSelectedConRec()      
    {
        List<currentOpportunity__c> local = [Select Id__c from currentOpportunity__c];
        System.debug(local);

        List<Id> ids=new List<id>();
        for(currentOpportunity__c ca:local)
        {
            ids.add(ca.Id__c);
        }
        
        List<Opportunity> oppLi = [Select Name,Id from Opportunity where Id In :ids];
        System.debug(oppLi);
        return oppLi;
    }

    @AuraEnabled
    public static List<Opportunity> onSearchOpp(String val)
    {
        String a = '%'+val+'%';
        List<Opportunity> oppList = [Select Name from Opportunity where Name like :a];
        return oppList;
    }


}