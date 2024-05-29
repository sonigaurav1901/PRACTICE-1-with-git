public class api_cheap_Translate {
     public static void main()
     {
         Http h = new Http();
         HttpRequest req = new HttpRequest();
         HttpResponse res = new HttpResponse();
         
         req.setMethod('POST');
         req.setEndpoint('https://cheap-translate.p.rapidapi.com/goo/translate');
         req.setHeader( 'content-type' , 'application/json' );
         req.setHeader( 'X-RapidAPI-Key' , '333f61d0c3msh0beb4990d99a0e5p1ff020jsn2f5c123d9ebc' );
         req.setHeader( 'X-RapidAPI-Host' , 'cheap-translate.p.rapidapi.com' );
         req.setBody('{"fromLang":"auto-detect","text":"bsdk","to":"hi"}');
         
         res = h.send(req);
         system.debug(res.getBody());
         
     }

}