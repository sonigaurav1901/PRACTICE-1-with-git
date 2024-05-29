trigger eventTriggerForTest on Test_Platform_Event__e (after insert) {
    System.debug('inside trigger');
	/*for(Test_Platform_Event__e tpe: Trigger.new)
    {
        System.debug('inside loop');
        String body = tpe.Description__c;
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        List<String> sendTo = new List<String>();
        sendTo.add('gauravsoni@cyntexa.com');
        System.debug('mail send to');
        email.setToAddresses(sendTo);
        email.setSubject('Test Email');
        email.setHtmlBody(body);
        mails.add(email);
        Messaging.sendEmail(mails);
        System.debug('mail send');
    }*/
    
}