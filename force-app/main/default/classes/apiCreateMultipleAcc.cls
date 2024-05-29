@RestResource(urlMapping = '/apiMultiRec/*')
Global class apiCreateMultipleAcc {
    
    @HttpPost
    Global static String myMethod()
    {
        RestRequest req = RestContext.request;
        System.debug(req);
        
        String str = req.requestBody.toString();
        //System.debug(str);
        
        Map<String,object> m1 = (Map<String , object>) JSON.deserializeUntyped(str) ; 
        
        String accName = (String)m1.get('AccountName');
        //System.debug(accName);
        Account a = new Account(Name=accName);
        insert a ;
        
        //-----------Inserting Contacts -----------
        Map<String,object> con = (Map<String,Object>)m1.get('Detail');
        List<object> conList= (List<object>)con.get('ContactName'); 
        
        List<Contact>contactList = new List<Contact>();
        for(object o:conList)
        {
            //System.debug(o);
            Contact c = new Contact(LastName = (String)o,AccountId = a.Id);
            contactList.add(c);
        }
        System.debug(contactList);
        insert contactList ;
        
        
        //------------Inserting opportunity -------------
        Map<String,object> opp = (Map<String,Object>)m1.get('Detail');
        List<object> oppList= (List<object>)opp.get('OpportunityName');
        
        List<opportunity> opportunityList = new List<opportunity>();
        for(object o1:oppList)
        {
            opportunity op = new opportunity(StageName='Needs Analysis' , CloseDate=(Date.today()).addDays(30) , Name = (String)o1 , AccountId=a.Id);
            opportunityList.add(op);
            system.debug(op);
        }
        insert opportunityList;
        
        
        return 'Test';
    }

}