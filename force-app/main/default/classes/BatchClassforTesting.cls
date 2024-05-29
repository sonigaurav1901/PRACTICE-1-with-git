global class BatchClassforTesting implements Database.Batchable <sObject>, Database.Stateful {
    
    private List<Account> successfulAccounts = new List<Account>();
	private List<Account> unsuccessfulAccounts = new List<Account>();
    global List<Account> accresult = new List<Account>();
    
    global Database.QueryLocator Start(Database.BatchableContext bc){
        
        //List<Account> addAccountForTest = new List<Account>();
        /*for(integer i=0;i<100000;i++)
        {
            Account acc = new Account(Name='account for batch');
            accresult.add(acc);
            
        }*/
        String query = 'Select Id,Name from Account where Name=\'Dummy Account\'';
        return Database.getQueryLocator(query);
        
        //return [select Name from Account where Name='account for batch'];
    }
    
    global void Execute(Database.BatchableContext bc, list<Account> accList){
        
        for (Account account : accList) {
            try {
                Database.delete(account,false);
                successfulAccounts.add(account);
            } catch (Exception e) {
                unsuccessfulAccounts.add(account);
            }
    	}
        //insert accList;
    }
    
    
    global void Finish(Database.BatchableContext bc){
        integer successfull = successfulAccounts.size();
        integer unSuccessfull = unsuccessfulAccounts.size();
        
        System.debug('successfull - '+successfull);
        System.debug('unSuccessfull - '+unSuccessfull);
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String[] toAddress = new String[]{'gauravsoni@cyntexa.com'};
            
        mail.setToAddresses(toAddress);
        
        mail.setSubject('Batch Job Completed');
        
        mail.setPlainTextBody('record sucessfully deleted are :- '+successfull+'\nrecord unSucessfully undeleted are :- '+unSuccessfull);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        
    }
    
    
   /* global void execute(SchedulableContext Sc)
    {
        
        batchClass_Q5 ba=new batchClass_Q5();
        Database.executeBatch(ba);
        
    }*/
    
}


//to execute -
//BatchApex ba = new BatchApex();
//Database.executeBatch(ba,200);


//System.schedule('Q5', '0 0 0/24 * * ? *', new batchClass_Q5());