@RestResource(urlMapping='/sfccRestResourceCreateAccount')
global class sfccRestResource {
    
    
    @HttpPost
    global static void createAccount()
    {
    	RestRequest req = RestContext.request;
    	String name = req.params.get('name').trim();
        Account acc = new Account();
        acc.Name = name;
        insert acc;
    }
	
}