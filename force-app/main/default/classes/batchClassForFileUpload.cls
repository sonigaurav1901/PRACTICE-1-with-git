global class batchClassForFileUpload implements Database.Batchable<sObject>,Database.Stateful  {
    
    public List<object> dataFromJs ;
    public Map<String,object> finalDataFromJs ; 
	integer countOfSucessfullRec = 0;
    integer countOfUnSucessfullRec = 0 ;
    
    global Static Schema.SObjectField getField(String field){
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
    
    global batchClassForFileUpload(String data ,String fdata)
    {
        this.dataFromJs=(List<Object>)JSON.deserializeUntyped(data) ; 
        this.finalDataFromJs= (Map<String,object>)JSON.deserializeUntyped(fdata) ; 
    }
    global Iterable<sObject> Start(Database.BatchableContext bc)
    {
        return (System.Iterable<sObject>)this.dataFromJs; 
    }
    
    global void execute(Database.BatchableContext bc,List<Object> scope)
    {
        System.debug('all data in batch execute method is : '+scope);
        Map<String,object> finalDataFromJs2=new Map<String,object> ();
        for(String fields : this.finalDataFromJs.keySet()) 
        {
                finalDataFromJs2.put(fields.replaceAll('"', ''), this.finalDataFromJs.get(fields));
        }
        this.finalDataFromJs = finalDataFromJs2;
    	List<sObject> accList = new List<sObject>();
        for (Object da : scope) 
        {
            String dat = JSON.serialize(da);
            Map<String,Object> test = (Map<String,Object>)JSON.deserializeUntyped(dat);    
    		Account a = new Account() ;	

            Map<String,object> m1 = new Map<String,object>();
            
            for(String key : test.keySet())
            {
                String te = (String)test.get(key);
                te.replace('\r', '');
                m1.put(key,(object)te);
                    
            }
            
            System.debug('m1 mao is ==> '+m1);
            
            
            for(String fields : this.finalDataFromJs.keySet()) 
            {    
                
                String temp = fields.replace('"','');
                system.debug(temp);
                System.debug('Final mappp '+this.finalDataFromJs);
                System.debug('temp is --> '+fields+' value of field is --> '+this.finalDataFromJs.get(fields));
                system.debug('basjkdlkl skdhalfh dkah=== ?'+test);
                
                System.debug('Phone Data :- '+test.get('NumberOfEmployees'));
                Schema.SObjectField field1 = getField(fields);
                
                Map<String,Object> mp = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(a));
                System.debug(mp.get(fields));
            
                System.debug(fields);
                System.debug((String)test.get((String)this.finalDataFromJs.get(fields)));
                //fields = fields.replaceAll('"','');
                // insertinf data in a

                Schema.DescribeFieldResult fldLabel =  Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap().get(fields).getDescribe();
                Schema.DisplayType dataType = fldLabel.getType();
                string fieldType = String.ValueOf(dataType);
                system.debug('******'+fieldType);
                if(fieldType == 'STRING')
                {
                    a.put( fields, (String)test.get((String)this.finalDataFromJs.get(fields)) );
                     System.debug((String)test.get((String)this.finalDataFromJs.get(fields)));
                }
                else
                {
                    a.put( fields, (Object)test.get((String)this.finalDataFromJs.get(fields)) );   
                     System.debug((Object)test.get((String)this.finalDataFromJs.get(fields)));
                }
			}
            System.debug(a);
            System.debug('==========');
            sObject acc = new Account();
            accList.add(acc);

            System.debug('acc list is '+accList);
		}
        Database.SaveResult[] results = Database.insert(accList, false);
        
        for (Database.SaveResult result : results) {
            if (result.isSuccess()) {
                //Successfully inserted
                //Handle insertion
                System.debug('Account Successfully inserted, Account Id is: ' + result.getId());
                this.countOfSucessfullRec = this.countOfSucessfullRec + 1 ;
            }
            else {
                //Error ecountered              
                this.countOfUnSucessfullRec = this.countOfUnSucessfullRec + 1;
            }
        }
    }
    
    global void Finish(Database.BatchableContext bc){
        
       /* Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        //get email addresses for specific disease
        List<String> toAddresses = new List <String>();
        
        //set addresses for email to be sent
        mail.setToAddresses(toAddresses);
        
        //set up remaining email
        mail.setReplyTo('gauravs1901@gmail.com');
        mail.setSenderDisplayName('Gaurav');
        mail.setSubject('Records Inserted Sucessfully');
        mail.setPlainTextBody('Your Record Get Insert where sucessfull inserted records is : '+this.countOfSucessfullRec+' and Count of unsucessfull record is : '+this.countOfUnSucessfullRec);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });*/
    }
    
}