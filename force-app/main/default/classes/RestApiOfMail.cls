@RestResource(urlMapping='/Email_task/')
global class RestApiOfMail {
	@HttpPost
    global static List<String> createRec()
    {
        //Variables of Mail Header
        String name , Email_Catogory , Email_Subject , Priority , Assigned_To ;
        String Date_Recived , Tentative_Completion_Date ;
        
        //Variables of Mail Chain
        String Date_and_Time_of_Email , fr , to , cc , bcc , subject , Email_Body , mailHeader ; 
        
        Date d,d1,d2 ;
        
        String fieldName , fieldValue ;
        
        RestRequest req = RestContext.request ;
        RestResponse res = RestContext.response ;
        
		String jsonBody = req.requestBody.toString();
        System.debug(jsonBody);
        
        JSONParser parser = JSON.createParser(jsonBody);
        while(parser.nextToken() != null)
        {
            //For Mail Header and Mail chain
            if(parser.getCurrentToken() != JSONToken.END_OBJECT)
            {
                
                fieldName = parser.getCurrentName();
                fieldValue = parser.getText();
 
                if(fieldName == 'Name')
                {
                    name = fieldValue ; 
                }
                else if(fieldName == 'Email_Category__c')
                {
                    Email_Catogory = fieldValue ; 
                }
                else if(fieldName == 'Email_Subject__c')
                {
                    Email_Subject = fieldValue ; 
                }
                else if(fieldName == 'Mail_Header__c')
                {
                    mailHeader = fieldValue ; 
                }
                else if(fieldName == 'Priority__c')
                {
                    System.debug('in Priority__c fieldName -'+parser.getCurrentName());
                System.debug('in Priority__c fieldValue -'+parser.getText());
                    Priority = fieldValue ; 
                }
                else if(fieldName == 'Assigned_To__c')
                {
                    Assigned_To = fieldValue ; 
                }
                else if(fieldName == 'Date_Recived__c')
                {
                    Date_Recived = fieldValue ; 
                    List<String> str1 = Date_Recived.split('-');
                    d1 = Date.newInstance(integer.ValueOf(str1[0]),integer.ValueOf(str1[1]),integer.ValueOf(str1[2]));
                    System.debug('Date of Date Recived is :-->'+d1);
                }
                else if(fieldName == 'Tentative_Completion_Date__c')
                {
                    Tentative_Completion_Date = fieldValue ; 
                    List<String> str2 = Tentative_Completion_Date.split('-');
                    d2 = Date.newInstance(integer.ValueOf(str2[0]),integer.ValueOf(str2[1]),integer.ValueOf(str2[2]));
                    System.debug('Date-->'+d2);
                }
            
                else if(fieldName == 'Date_and_Time_of_Email__c')
                {
                    System.debug('fieldName -'+parser.getCurrentName());
                	System.debug('fieldValue -'+parser.getText());
					Date_and_Time_of_Email = fieldValue;
                    List<String> str = Date_and_Time_of_Email.split('-');
                    d = Date.newInstance(integer.ValueOf(str[0]),integer.ValueOf(str[1]),integer.ValueOf(str[2]));
                    System.debug('Date-->'+d);
                }
                else if(fieldName == 'From__c')
                {
                    fr = fieldValue;
                }
                else if(fieldName == 'To__c')
                {
                    to = fieldValue;
                }
                else if(fieldName == 'CC__c')
                {
                    cc = fieldValue;
                }
                else if(fieldName == 'BCC__c')
                {
                    bcc = fieldValue;
                }
                else if(fieldName == 'Subject__c')
                {
                    subject = fieldValue;
                }
                else if(fieldName == 'Email_Body__c')
                {
                    Email_Body = fieldValue;
                }
            }
            parser.nextToken();

        }
        List<String> ides = new List<String>();
        if(name != null && (Email_Catogory != null || Email_Subject != null || Priority != null || Assigned_To != null || Date_Recived != null ))
        {
            Mail_Header__c mH = new Mail_Header__c(Name = name , Email_Category__c = Email_Catogory , Email_Subject__c = Email_Subject , Priority__c = Priority , Assigned_To__c = Assigned_To , Date_Recived__c = d1 , Tentative_Completion_Date__c = d2);
            insert mH ;    
            System.debug('Mail Header Calll');
            
            ides.add(mH.id);
        }
        
        if(name != null && (Date_and_Time_of_Email != null || fr != null || to != null || cc != null || bcc != null || subject != null || Email_Body != null || mailHeader != '' ))
        {
            Mail_Chain__c mC = new Mail_Chain__c( Date_and_Time_of_Email__c = d , Name = name , From__c = fr , To__c = to , CC__C = cc , BCC__c = bcc , Subject__c = subject , Email_Body__c = Email_Body , Mail_Header__c = mailHeader );
            insert mC;
            System.debug('Mail chain Calll');
            ides.add(mC.id) ; 
        }
        
        
		return ides;
       
        
    }
}