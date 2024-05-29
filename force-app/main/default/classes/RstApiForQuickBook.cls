@RestResource ( urlMapping = '/TaskQuickBook/*' )
global class RstApiForQuickBook{
	
	@HttpPost
	global static string method(){

		RestRequest req = RestContext.request;
		System.debug(req);

		String str = req.requestBody.toString();
		System.debug(str);
        
        wrapperClassOfQuickBookData w = (wrapperClassOfQuickBookData) JSON.deserialize(str , wrapperClassOfQuickBookData.class);
        System.debug('wrapper data is : '+w);
        
        String iid = w.eventNotifications[0].dataChangeEvent.entities[0].id ;
        System.debug('idddd is : '+iid);
        
        List<quickbookRefToken__c> RefTokenList = [select refToken__c from quickbookRefToken__c];
        String refToken = RefTokenList[0].refToken__c;
        System.debug('refresh token is : '+refToken);
        String endpointUrl='https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer';
        
        Http h = new Http();
        HttpRequest hreq = new HttpRequest();
        HttpResponse hres = new HttpResponse();
        String clId = 'ABEsx75dVP1IuYyHaWkVjgl2E0Q3k9jCIDqIFOJzhA0cskw94J';
        String clSec = 'JkZ9VErd2QhiyAIMZrJ3x6ez9O2TMoaDLO4eYope';
        
        hreq.setMethod('POST');
        hreq.setEndpoint(endpointUrl);
        
        hreq.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
 		hreq.setBody('grant_type=refresh_token&refresh_token='+refToken+'&client_id='+EncodingUtil.urlEncode(clId,'UTF-8')+'&client_secret='+EncodingUtil.urlEncode(clSec,'UTF-8'));
        hres = h.send(hreq);
        System.debug('response is : '+hres.getStatus()+'----'+hres.getBody());
        Map<string,Object> pro=(Map<string,object>)JSON.deserializeUntyped(hres.getBody());
        system.debug(pro);
        
        String acessToken = (String)pro.get('access_token') ;
        System.debug(acessToken);
        
        String url1 = 'https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365226018760/account/'+iid+'?minorversion=40';
        
        Http h1 = new Http();
        HttpRequest h1req = new HttpRequest();
        HttpResponse h1res = new HttpResponse();
		h1req.setMethod('GET');
        h1req.setEndpoint(url1);
        h1req.setHeader('Content-type','application/json');
        h1req.setHeader('Accept','application/json');
        h1req.setHeader('Authorization', 'Bearer '+acessToken);
        h1res = h1.send(h1req);
        System.debug('res--> '+h1res.getStatus()+'--> '+h1res.getBody());
        
        Map<string,Object> finalResponse=(Map<string,object>)JSON.deserializeUntyped(h1res.getBody());
        Map<string,Object> acc = (Map<string,Object>)finalResponse.get( 'Account' );
        system.debug('Map is Name --> '+acc.get('Name'));
        
        System.debug('Accoutn Name after Trigger is : '+(String)acc.get('Name'));
        
        //Account Created
        Account ac = new Account(Name = (String)acc.get('Name'));
        insert ac ;
        system.debug('Map is Name field is --> '+finalResponse);
        
		return 'testing...'+iid;
    }
}