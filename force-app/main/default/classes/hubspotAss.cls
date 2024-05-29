global class hubspotAss implements Schedulable
{
    //public String url{get;set;}
    public static PageReference mymeth()
    {
        PageReference pref = new PageReference('https://app.hubspot.com/oauth/authorize?client_id=f88d1adf-8a86-4646-a821-51e728f5ca72&https://app.hubspot.com/oauth/authorize?client_id=f88d1adf-8a86-4646-a821-51e728f5ca72&https://app.hubspot.com/oauth/authorize?client_id=f88d1adf-8a86-4646-a821-51e728f5ca72&redirect_uri=https://cyntexa92-dev-ed--c.visualforce.com/apex/hubspotPage&scope=crm.objects.contacts.read%20crm.objects.contacts.write%20crm.objects.companies.write%20crm.objects.companies.read');
        pref.setRedirect(true);
        System.debug('pref is ---> '+pref);
        return pref;
    }
    public void getcode() 
    {
        System.debug('Get Code is running -- . ');
        String code = ApexPages.currentPage().getparameters().get('code');
        System.debug('code is ---> '+code);
        String clientId = 'f88d1adf-8a86-4646-a821-51e728f5ca72';
        String clientSecret = 'd06db6d8-d609-448f-8ce3-b60eadc718e2';
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.hubapi.com/oauth/v1/token');
        request.setHeader('Content-Type','application/x-www-form-urlencoded');
        request.setMethod('POST');
        String body =  'grant_type=authorization_code&client_id='+EncodingUtil.urlEncode(clientId,'UTF-8')+'&client_secret='+EncodingUtil.urlEncode(clientSecret,'UTF-8')+'&code='+code+'&redirect_uri=https://cyntexa92-dev-ed--c.visualforce.com/apex/hubspotPage';
        request.setBody(body);   
        
        HttpResponse response = h.send(request);
        System.debug('Response in getRefreshToken:'+response);
        
        Map<string,Object> pro=(Map<string,object>)JSON.deserializeUntyped(response.getBody());
        system.debug(pro);
        String refreshToken=(String)pro.get('refresh_token');
        system.debug('refresh token --> '+refreshToken);
        
        if(refreshToken != null)
        {
            List<hubspotRefToken__c> dataofHubspotObj = [select Name from hubspotRefToken__c];
            delete dataofHubspotObj ;
            hubspotRefToken__c ref = new hubspotRefToken__c(Name = 'Hubspot Refresh Token' , refToken__c = refreshToken );
            insert ref;
        }
    }
    
    public static void acessToken()
    {
        String clientId = 'f88d1adf-8a86-4646-a821-51e728f5ca72';
        String clientSecret = 'd06db6d8-d609-448f-8ce3-b60eadc718e2';
        hubspotRefToken__c refToken = [select refToken__c from hubspotRefToken__c order by createdDate limit 1];
        System.debug('ref token is -- > '+refToken.refToken__c);
        string rToken = refToken.refToken__c ;
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.hubapi.com/oauth/v1/token?grant_type=refresh_token&client_id='+EncodingUtil.urlEncode(clientId,'UTF-8')+'&client_secret='+EncodingUtil.urlEncode(clientSecret,'UTF-8')+'&refresh_token='+rToken);
        request.setHeader('Content-Type','application/x-www-form-urlencoded');
        request.setMethod('POST');
       
        HttpResponse response = h.send(request);
        Map<string,Object> acessToken=(Map<string,object>)JSON.deserializeUntyped(response.getBody());
        system.debug(acessToken);
        String accToken = (String)acessToken.get('access_token');
		        
        httprequest hreq2 = new httprequest();
        httpresponse hres2 = new httpresponse();
        hreq2.setEndpoint('https://api.hubapi.com/crm/v3/objects/contacts?limit=100&archived=false');
        hreq2.setHeader('Authorization', 'Bearer '+accToken);
        hreq2.setHeader('Content-Type', 'application/json');
        hreq2.setMethod('GET');
        hres2 = h.send(hreq2);
        System.debug('response of h2 is --> '+hres2.getBody());
       
        wrapperClassOfHubspotAss res = (wrapperClassOfHubspotAss)Json.deserialize( hres2.getBody() , wrapperClassOfHubspotAss.class);
        System.debug(res.results[0].properties);
        List<object> obj1 = res.results ;
        System.debug('ibj1 is : '+obj1);
        List<contact> conList = [select Email,Id from contact where email !=null];
        System.debug('con---> '+conList);
        
        //Map to store email and id...
        Map<String,String> updateCon = new Map<String,String>();
        for(contact c:conList)
        {
            updateCon.put(c.Email , c.Id);
        }
        
        System.debug('updateCon--==> '+ updateCon);
        
        //updatedList..
        List<contact> updatedList = new List<contact>();
        //new data List
		List<contact> insertList = new List<contact>();
        
        for(wrapperClassOfHubspotAss.cls_results data: res.results)
        {
            integer count = 0 ;
            //System.debug('data : --> '+data.properties.firstname+' === email is : '+data.properties.email);
            String em = data.properties.email ; 
			//System.debug('em is => '+em);
            for(contact c:conList)
            {
             	if(c.Email== em )
                {
                    count++ ; 
                }
            }
            if(count > 0)
            {
                String idee = updateCon.get(em);
                System.debug('idee ===> '+idee);
                contact c = new contact(LastName = data.properties.firstname , Email = em , Id = idee);
                updatedList.add(c);
            }
            else if(count == 0)
            {
                contact c = new contact(LastName = data.properties.firstname , Email = em);
                insertList.add(c);
            }
        }
        System.debug('updated Map is :-> '+updatedList);
        System.debug('inserted Map is :-> '+insertList);
        
        insert insertList ;
        update updatedList ;
        
    }
    
    global void execute(SchedulableContext ctx)
    {
        hubspotAss.acessToken();
    }
}