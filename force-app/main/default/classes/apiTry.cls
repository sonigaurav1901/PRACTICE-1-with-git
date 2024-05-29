public class apiTry {

    public static void data()
    {
        
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://tbgvr-api.esper.cloud/api/enterprise/report/device-report?start_date=2022-06-20&end_date=2022-06-24&sync=true&fields=recently_changed_location,days_active,days_inactive,last_known_location,device_id,device_name');//tfi
        request.setMethod('GET');
        String token='XwXv01jEjszBDwZC3Dunzny8e2Ueni';
        
        request.setHeader('Authorization','Bearer '+token);
        HttpResponse response=http.send(request);
        system.debug('res'+response);
         system.debug('resbody   '+response.getBody());
    }
    
    
    
}