global class batchClass_Q5 implements Database.Batchable <sObject>,schedulable {
    
    global Database.QueryLocator Start(Database.BatchableContext bc){
        
        return Database.getQueryLocator([Select ContactId , Status from Case]);
        
    }
    
    global void Execute(Database.BatchableContext bc, list<Case> caseList){
        
        for(Case c: caseList){
            c.Status = 'Escalated';
        }
        
        update caseList;
        
    }
    
    
    global void Finish(Database.BatchableContext bc){
        
       /* Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String[] toAddress = new String[]{'karan.ks7500@gmail.com'};
            
        mail.setToAddresses(toAddress);
        
        mail.setSubject('Batch Job Completed');
        
        mail.setPlainTextBody('Hey The Batch job you started is successfully completed');
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});*/
        
    }
    
    
    global void execute(SchedulableContext Sc)
    {
        
        batchClass_Q5 ba=new batchClass_Q5();
        Database.executeBatch(ba);
        
    }
    
}


//to execute -
//BatchApex ba = new BatchApex();
//Database.executeBatch(ba,200);


//System.schedule('Q5', '0 0 0/24 * * ? *', new batchClass_Q5());