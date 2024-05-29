public class mailHeaderAndChain {
    @AuraEnabled
    public static List<Mail_Header__c> fetchMailHeader(){
        try 
        {
            List<Mail_Header__c> mH = [select Name,Email_Category__c,Email_Subject__c,Priority__c,Assigned_To__c,Date_Recived__c,Tentative_Completion_Date__c from Mail_Header__c];
            System.debug(mH);
            return mH;
        } catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //related Mail chain Records
    @AuraEnabled
    public static List<Mail_Chain__c> fetchMailChain(String i){
        try 
        {
            List<Mail_Chain__c> mC = [select Name,Id,CC__c,BCC__c,From__c,Email_Body__c,Mail_Header__c,Subject__c,To__c from Mail_Chain__c where Mail_Header__c =:i];     
            System.debug('mC data is : '+mC);
            return mC;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    //delete record and related mail chain
    @AuraEnabled
    public static void fetchAllRelatedRec(String i)
    {
        try 
        {
            List<Mail_Chain__c> mCRec = [select Name from Mail_Chain__c where Mail_Header__c =:i];
            List<Mail_Header__c> mH = [select Name from Mail_Header__c where Id=:i];

            System.debug('All related rec is '+mCRec);
            System.debug('Mail Header rec is '+mH);
            delete mCRec;
            delete mH;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    // to Search Records of email
    @AuraEnabled
    public static List<Mail_Chain__c> allRecordOnSearch(String em)
    {
        try 
        {
            List<Mail_Chain__c> mC = [select Name,CC__c,BCC__c	,Id,From__c,Email_Body__c,Mail_Header__c,Subject__c,To__c from Mail_Chain__c where To__c=:em OR From__c=:em OR CC__c=:em OR BCC__c=:em ];
            System.debug('records containing email are : '+mC);
            return mC ;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


}