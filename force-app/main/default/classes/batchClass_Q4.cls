global class batchClass_Q4 implements Database.Batchable <sObject>,schedulable {
    
    global Database.QueryLocator Start(Database.BatchableContext bc){
        
        DateTime d = DateTime.now();
        Integer offset = UserInfo.getTimezone().getOffset(d);
        Datetime local = d.addSeconds(offset/1000);
        DateTime earlier = local.addHours(-23);
        earlier = earlier.addMinutes(-30);
        earlier = earlier.addSeconds(-25);
        System.debug(local);
        system.debug(earlier);
        
        return Database.getQueryLocator([Select name, stageName from Opportunity where createdDate<:earlier]);
        
    }
    
    global void Execute(Database.BatchableContext bc, list<Opportunity> oList){
        
        for(Opportunity o: oList){
            o.stageName = 'Closed Won';
        }
        
        update oList;
        
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
        
        batchClass_Q4 ba=new batchClass_Q4();
        Database.executeBatch(ba);
        
    }
    
}


//to execute -
//BatchApex ba = new BatchApex();
//Database.executeBatch(ba,200);
//
//
//System.schedule('Kuch nii', '0 30 */6 ? * *', new batchClass_Q4());
//System.schedule('Kuch bhi', s, new BatchApex());