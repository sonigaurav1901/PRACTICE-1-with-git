global class batchClass_Q3 implements Database.Batchable <sObject>,schedulable {
    
    global Database.QueryLocator Start(Database.BatchableContext bc){
       
       
        return Database.getQueryLocator([Select Name, Email , Status , LeadSource from Lead where LeadSource = 'Phone Inquiry' And Status!='Closed - Converted']);
        
    }
    
    List<String> arr ;
    
    global void Execute(Database.BatchableContext bc, list<Lead> leadList){
        
        for(Lead l: leadList){
            Database.LeadConvert listCon = new Database.leadconvert();
            listCon.setLeadId(l.id);
            listCon.convertedstatus = 'Closed - Converted';
            listCon.ownerid = '00Q5i000004HvtjEAC';
            Database.LeadConvertResult lcr = Database.convertLead(listCon);
            arr.add(l.Email);
        }
        update leadList;
        
    }
    
    
    global void Finish(Database.BatchableContext bc){
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String[] toAddress = arr ;
            
        mail.setToAddresses(toAddress);
        
        mail.setSubject('Batch Job Completed');
        
        mail.setPlainTextBody('Hey The Batch job you started is successfully completed');
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        
    }
    
    
    global void execute(SchedulableContext Sc)
    {
        
        batchClass_Q3 ba=new batchClass_Q3();
        Database.executeBatch(ba);
        
    }
    
}


//to execute -
//BatchApex ba = new BatchApex();
//Database.executeBatch(ba,200);


//System.schedule('Q3', '0 0 0/12 * * ? *', new batchClass_Q3());