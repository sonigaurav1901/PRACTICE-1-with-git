public class ApiWhatsAppController 
{
    
	Public static void sendTemplateMessage()
    {
        String ph = '919001090362';
        String apiToken = 'EAAlaDLEZCj1UBALQw1YAmLsk2GVUxip359vgQnhCVs5J2LN7UTSnKyxCyH0yYaDRhliTHeRBWfVQ2sSIDfLKvZCNrIDg4RzSsyROY2SL9BMs8nkfio1ohayaKGFOfXZAxanZBntTOocQ2zg44i5dxSuoTuRiMqfAKKAGHdbMrJrszZCZBZBmJZAZCOWkYnRHoYAU3JS9uxR63xQZDZD';
        String tempName = 'temp13';
        String messageToSend = 'Hello_guys_wellcome_to_chat';
        
        //FOR CREATING TEMPLATE
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        String str = '[{"type":"BODY","text":"'+messageToSend+'"}]';
        String endpoint = 'https://graph.facebook.com/v14.0/106364342237954/message_templates?name='+tempName+'&language=en_US&category=TRANSACTIONAL&components=[{"type":"BODY","text":"'+messageToSend+'"}]&access_token='+apiToken ;
        
        System.debug('url is : '+endpoint);
        req.setEndpoint(endpoint);
        
        req.setMethod('POST');
        
        system.debug(req.getEndpoint());
        system.debug(req.getBody());
        HttpResponse res = http.send(req);
        System.debug('status code of api callout is :->  '+res.getStatusCode());
        System.debug('response body is : '+res.getBody());
        if(res.getStatusCode() == 200)
        {
            System.debug('message send');
        }

       	// sending template on whatsapp
       	
       // String b = '{"messaging_product":"whatsapp","recipient_type":"individual","to":"919001090362","type":"template","template":{"name":"temp13","language":{"code":"en_US"},"components":[{"type":"body","parameters":[]}]}}' ;
        String b = '{'+
                        '"messaging_product":"whatsapp",'+
                        '"recipient_type": "individual",'+
                        '"to": "919001090362",'+
                        '"type": "template",'+
                        '"template": {'+
                            '"name": "temp13",'+
                            '"language": {'+
                                '"code": "en_US"'+
                            '},'+
                            '"components": ['+
                                '{'+
                                    '"type": "body",'+
                                    '"parameters": ['+
                                        
                                    ']'+
                                '}'+
                            ']'+
                        '}'+
                    '} ';
        Http h = new Http();
        HttpRequest hreq = new HttpRequest();
        String sendingTempUrl = 'https://graph.facebook.com/v14.0/110496165149304/messages';
        hreq.setEndpoint(sendingTempUrl);
        hreq.setMethod('POST');
        String auth = apiToken ;
        hreq.setHeader( 'Authorization' , auth );
        
        
        System.debug('body send is :- '+b);
        hreq.setBody(b);
        
        HttpResponse hres = h.send(hreq);
        System.debug('hres status code :- '+hres.getStatusCode());
        System.debug('hres Body :- '+hres.getBody());
        
        
    }
}