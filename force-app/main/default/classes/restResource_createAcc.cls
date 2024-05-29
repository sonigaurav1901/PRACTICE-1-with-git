@RestResource(urlMapping='/createAccount')
global class restResource_createAcc {
    
    @HttpPost
    global static String doPost() {
        
       	RestRequest req = RestContext.request;
        Object test = req.requestBody;
        System.debug('request is '+JSON.deserializeUntyped(test.toString()));
        System.debug('name is '+JSON.deserializeUntyped(test.toString()));
        Map<String,String> nameAndExternalId = new Map<String,String>();
        List<Account> accList = new List<Account>();
        List<String> externalIdes = new List<String>(); 
        
        for(Object obj: (List<Object>)JSON.deserializeUntyped(test.toString())) {
            Map<String,Object> objDataMap = (Map<String,Object>) obj;
            if(objDataMap.containsKey('name')) {
                
                accList.add(new Account(Name= String.valueOf(objDataMap.get('name'))));
            		
                if(objDataMap.containsKey('externalId')) {
                    nameAndExternalId.put( String.valueOf(objDataMap.get('name')) , String.valueOf(objDataMap.get('externalId')) );
                } else {
                    nameAndExternalId.put( String.valueOf(objDataMap.get('name')) , null );
                }
            }
        }
        
        List<Account> backendAccRecord = [Select Id,External_Id__c  from Account where External_Id__c IN :nameAndExternalId.values() AND External_Id__c != null ];
        
        
        if(accList.size() > 0 ) {
            INSERT accList;
        }
        /*Account account = new Account();
        account.Name = name;
        insert account;
        return account.id;
		*/
        return  String.valueOf(JSON.deserializeUntyped(test.toString()));
	}

}