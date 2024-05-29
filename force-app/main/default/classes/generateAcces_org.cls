public class generateAcces_org {
   
     public static void generateCode()
     {
         Http h = new Http();
         HttpRequest req = new HttpRequest();
         HttpResponse res = new HttpResponse();
         
         req.setMethod('GET');
         req.setEndpoint('https://cyntexa92-dev-ed.lightning.force.com/services/oauth2/authorize?client_id=3MVG9wt4IL4O5wvJJYDy.rz814X38fJMI9jvjkH6H5OB7wMlmOFjVOmU2EkQkfCbmN3FjLJ744vGkNHfOakyg&redirect_uri=https://cyntexa92-dev-ed--c.visualforce.com/apex/genrateAccessToken?core.apexpages.request.devconsole=1&response_type=code');
              
         res = h.send(req);
         system.debug(res.getBody());
         
     }
		public PageReference pg()
    {
        PageReference page=new PageReference('https://cyntexa92-dev-ed.lightning.force.com/services/oauth2/authorize?client_id=3MVG9wt4IL4O5wvJJYDy.rz814X38fJMI9jvjkH6H5OB7wMlmOFjVOmU2EkQkfCbmN3FjLJ744vGkNHfOakyg&redirect_uri=https://cyntexa92-dev-ed--c.visualforce.com/apex/genrateAccessToken?core.apexpages.request.devconsole=1&response_type=code');
        //PageReference page = new PageReference('https://www.google.com');
        page.setRedirect(true);
        return page;
    }
    @future(callout=true)
     public static void generateAccessToken()
     {
         String code = ApexPages.currentPage().getparameters().get('code');
         //System.debug(code);
         Http h = new Http();
         HttpRequest req = new HttpRequest();
         HttpResponse res = new HttpResponse();
         
         req.setMethod('POST');
         req.setEndpoint('https://cyntexa92-dev-ed.my.salesforce.com/services/oauth2/token?grant_type=authorization_code&code='+code+'&client_id=3MVG9wt4IL4O5wvJJYDy.rz814X38fJMI9jvjkH6H5OB7wMlmOFjVOmU2EkQkfCbmN3FjLJ744vGkNHfOakyg&client_secret=044248C5CDBC82150F6947FAFB78F40C1C27CD6C15D137F3C49772E197E060C5&redirect_uri=https://cyntexa92-dev-ed--c.visualforce.com/apex/genrateAccessToken?core.apexpages.request.devconsole=1');
         req.setHeader( 'Content-type' , 'application/x-www-form-urlencoded' );
         res = h.send(req);
         system.debug(res.getBody());
         
         Map<String , object> m1 = (Map<String , object>) JSON.deserializeUntyped(res.getBody());
         
         System.debug((String)m1.get('id_token'));
         
         
         String len = (String) m1.get('id_token');
         
         if(len != NULL)
         {
             System.debug(len.length());
             len = len.substring(0, 250);
             accessToken_Store__c acc = new accessToken_Store__c(accToken__c= len, SetupOwnerId = userinfo.getUserId());
             insert acc;
             
             System.debug('After truncate ----     '+len);
         }
         
		 //insert acc;
     }
}