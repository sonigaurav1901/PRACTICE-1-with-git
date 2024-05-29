public class helper {
	public Static Schema.SObjectField getField(String field){
        Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Account.fields.getMap();
        //set<string> fieldToSync = new Set<string>{'Id','Name','Test__order__c','Test__Name__c','Test__status__c'};
         System.debug(fieldMap.get(field));
         	/*
            for (String fieldName : fieldMap.keyset()) {
               System.debug(fieldMap.get(field));
                
            }
			*/
        	return fieldMap.get(field);
        }
    
    
}