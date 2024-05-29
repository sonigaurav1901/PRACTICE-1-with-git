public with sharing class fetchDataOfFile
 {
    @AuraEnabled
    public static List<Object> csvFileRead(Id contentDocumentId)
    {
        list<Account> accountInsertList = new list<Account>();
     
            ContentVersion contentVersionObj = [SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId =:contentDocumentId];
            list<String> csvRecordsList = contentVersionObj.VersionData.toString().split('\n');
            system.debug(csvRecordsList);

            List<String> keyss = csvRecordsList[0].split(',');
            csvRecordsList.remove(0);

            List<Object> actualData = new List<Object>();
            
            List<Map<String,String>> data = new List<Map<String,String>>();

            for(String na : csvRecordsList) 
            {
                Map<String,String> m = new Map<String,String>();

                Integer i = 0 ;
                String [] coloumns = na.split(',') ;
                System.debug('coloumns are : '+coloumns);
                String x='' ;
                for(String c : coloumns) 
                {
                    //x = x + keyss[i]+':'+c+' , ' ;
                    m.put( keyss[i], c);
                    // c = keyss[i]+':'+c ; 
                    // System.debug('c is : '+c+' -- and i : '+i);
                    i++ ; 
                }
                data.add( m );
            }
            System.debug('data is : '+data);

            actualData.add(keyss);
            actualData.add(data);

            return actualData;
    }



    @AuraEnabled
    public static List<String> fetchFieldsOfAcc()
    {
        try 
        {
            List<FieldDefinition> fields = [SELECT QualifiedApiName FROM FieldDefinition WHERE EntityDefinition.QualifiedApiName IN ('Account')];
            List<String> l1 = new List<String>();

            for (FieldDefinition fd : fields) {
                String f = ''+fd+'';
                l1.add(f);
            }
            
            System.debug('Account fields are : '+l1);

            return l1 ;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

 
    @AuraEnabled
    public static void callBatchClass(String data , String fdata){
        try 
        {
            System.debug('List of Data is --> '+data);
            System.debug('List of Final Data is --> '+fdata);
            Database.executeBatch(new batchClassForFileUpload(data,fdata));
            
         }catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
   
           
}