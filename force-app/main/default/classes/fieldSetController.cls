public class fieldSetController {
	@AuraEnabled
    // Create Map of Label and fieldName to use this map in columns of datatable
    public static string getFieldLableAndFieldAPI(){
        List<Map<String ,String>> listOfFieldSet  = new  List<Map<String ,String>>();
        try {
            for(Schema.FieldSetMember fieldset : SObjectType.Account.FieldSets.test_Account_Field_Set.getFields()) {
                Map<String ,String> lableAPIMap = new Map<String ,String>();
                lableAPIMap.put(fieldset.getLabel(),fieldset.getFieldPath());
                listOfFieldSet.add(lableAPIMap);
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return JSON.serialize(listOfFieldSet);
    }
    
    @AuraEnabled
    public static Account showAccount(Id recID , String fields , String ObjectName){
        String Query = 'SELECT '+fields+' FROM '+ObjectName+' where Id = \''+recID+'\'';
        System.debug('Query is : '+Query);
        List<Account> acc = Database.query(Query);
        
        System.debug('acc is :- '+acc);
        if(acc.size() > 0) {
            return acc[0];
        }
        return null;
    }
}