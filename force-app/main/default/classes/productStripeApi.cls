public class productStripeApi {
    @future(callout=true)
    public Static void main(String studStr)
    {
        List<webStudent__c> stud = (List<webStudent__c>)JSON.deserialize(studStr, List<webStudent__c>.class);
        //For Product  
        String pro = 'choclate';
        HTTP h=new HTTP();
        HttpResponse res=new HttpResponse();
        HttpRequest req=new HttpRequest();
        
        req.setEndPoint('https://api.stripe.com/v1/products');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setHeader('Authorization','Bearer sk_test_51L4No0SDSwUG2gnL7Hzc2fxiRSmpT22XFmGuIxWAsRGznDDQDPQ32DYySE4ZERsxgDFnh8FzWu2zDIxHjX3yNQ0H00yaH5KlhL');
       	req.setBody('name='+pro);
        req.setMethod('POST');
        res=h.send(req);
        //System.debug(res.getBody());
        Map<String,object> m1 = (Map<String,object>) JSON.deserializeUntyped(res.getBody());
        System.debug(m1.get('id'));
        
        //For Price
        integer Amount=5000;
        HTTP h1=new HTTP();
        HttpResponse res1=new HttpResponse();
        HttpRequest req1=new HttpRequest();
        
        req1.setEndPoint('https://api.stripe.com/v1/prices?currency=INR&unit_amount='+Amount+'&product='+m1.get('id'));
        req1.setHeader('Content-Type','application/x-www-form-urlencoded');
        req1.setHeader('Authorization','Bearer sk_test_51L4No0SDSwUG2gnL7Hzc2fxiRSmpT22XFmGuIxWAsRGznDDQDPQ32DYySE4ZERsxgDFnh8FzWu2zDIxHjX3yNQ0H00yaH5KlhL');
        req1.setMethod('POST');
        res1=h.send(req1);
        //System.debug(res1.getBody());
        Map<String,object> m2 = (Map<String,object>) JSON.deserializeUntyped(res1.getBody());
        System.debug(m2.get('id'));
        
        
        //For Payment Link
        
        HTTP h2=new HTTP();
        HttpResponse res2=new HttpResponse();
        HttpRequest req2=new HttpRequest();
        
        req2.setEndPoint('https://api.stripe.com/v1/payment_links');
        req2.setHeader('Content-Type','application/x-www-form-urlencoded');
        req2.setHeader('Authorization','Bearer sk_test_51L4No0SDSwUG2gnL7Hzc2fxiRSmpT22XFmGuIxWAsRGznDDQDPQ32DYySE4ZERsxgDFnh8FzWu2zDIxHjX3yNQ0H00yaH5KlhL');
        req2.setMethod('POST');
        req2.setBody('line_items[0][price]=price_1LFds3SDSwUG2gnLOsFb65QK&line_items[0][quantity]=1');
        res2=h.send(req2);
        System.debug(res2.getBody());
        Map<String,object> m3 = (Map<String,object>) JSON.deserializeUntyped(res2.getBody());
        System.debug(m3.get('id'));
        
        //Payment Link Url....
        System.debug(m3.get('url'));
        
        
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String[] toAddress = new list<string>{stud[0].Email__c};
            
        mail.setToAddresses(toAddress);
        
        mail.setSubject('Payment Link Open IT ');
        
        mail.setPlainTextBody('Hey Your payment Link is here'+m3.get('url'));
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        System.debug('mail'+mail);
    }

}