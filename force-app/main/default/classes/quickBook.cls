public class quickBook {

    public String code{get ; set ;}

    public Pagereference main()
    {
        Pagereference p = new Pagereference('https://appcenter.intuit.com/app/connect/oauth2?client_id=ABEsx75dVP1IuYyHaWkVjgl2E0Q3k9jCIDqIFOJzhA0cskw94J&scope=com.intuit.quickbooks.accounting&redirect_uri=https://cyntexa92-dev-ed--c.visualforce.com/apex/quickbookPage?core.apexpages.request.devconsole=1&response_type=code&code_type=code&state=good');

        return p;
    }
    
    public static void getAcessToken()
    {
        System.debug('getAcces Token Method call');
        
        String code = ApexPages.currentPage().getParameters().get('code');
        System.debug(code);

        String endpointUrl='https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer?';

        if(!String.isBlank(code))
        {
            Http h = new Http();
            HttpRequest hreq = new HttpRequest();
            HttpResponse hres = new HttpResponse();

            String restokenbody = 'code='+code+'grant_type=authorization_code&redirect_uri=https://cyntexa92-dev-ed--c.visualforce.com/apex/quickbookPage?core.apexpages.request.devconsole=1' ; 

            hreq.setMethod('POST');
            hreq.setEndpoint(endpointUrl);
            hreq.setHeader('Content-Type', 'application/x-www-form-urlencoded');

            hreq.setBody(restokenbody);
            hres = h.send(hreq);

            System.debug('response is : '+hres.getStatus()+'-------'+hres.getBody());

        }
    }
}