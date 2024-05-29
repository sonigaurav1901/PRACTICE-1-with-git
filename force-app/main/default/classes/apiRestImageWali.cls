public class apiRestImageWali {
    public static void kuchbhi() {
         HTTP h=new HTTP();
        HttpResponse res=new HttpResponse();
        HttpRequest req=new HttpRequest();
        
        req.setEndPoint('https://google-maps28.p.rapidapi.com/maps/api/place/photo?photo_reference=Aap_uEC7IbboaQKJZSB2DAZxtBI9K1d1tqSGfra8_C3ki8wga0qk2ttpvDjKD2PA4XlBFV_wXiSW10Nhi-V-1KzT78r0cxDLxMM4in71tluj9U1xTPYQfaAXq0wMVzcyQ6dj0PK2bBZD54_lRx_UAhXpMdq6vAxkD9aFcwZkmCzTKkK9jduu&maxwidth=400&maxheight=400');
        req.setHeader('X-RapidAPI-Key','333f61d0c3msh0beb4990d99a0e5p1ff020jsn2f5c123d9ebc');
                        req.setHeader('X-RapidAPI-Host','google-maps28.p.rapidapi.com');
        req.setMethod('GET');
        res=h.send(req);
        System.debug(res.getBody());
        //Map<String,Object> mapp=(Map<String,Object>) JSON.deserializeUntyped(res.getBody());
        //System.debug(mapp.get('refresh_token'));
        
    }
}