public class kk 
{
    @future ( callout = true )		//(future for async and callout true when calling api)
    public static void methodName ( String s )
    {
        List<Account> aclist = (List<Account>)JSON.deserialize(s, List<Account>.class);
        
        List<Account> updatedlist = new List<Account>();
        
        for(Account a: aclist){
        
        Http h = new Http();
        
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint('https://cheap-translate.p.rapidapi.com/translate');
        
        req.setMethod('POST');
        
        req.setHeader('Content-Type','application/json');
        req.setHeader('X-RapidAPI-Host','cheap-translate.p.rapidapi.com');
        req.setHeader('X-RapidAPI-Key','9beaee754cmsh4b3ae4822b2dbedp1ff6d4jsn9c75a77971bc');
		
        req.setBody('{"fromLang":"auto-detect","text":"'+ a.Name +'","to":"hi"}');
        
        HttpResponse res = new HttpResponse();
        
        res = h.send(req);       
        
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        
        System.debug(results);
            
        String translatedname = (String)results.get('translatedText');
        
        System.debug(translatedname);
            
        //a.jaiho__Translated_name__c = translatedname;
        
        updatedlist.add(a);    
        
    }

		update updatedlist;

        system.debug('res'+Database.update(aclist, false));
    }       
}