public class fetchContactsAccRelated {
    
    // i refer as id ;
        @AuraEnabled
        public static List<Contact> relatedContact(String i)
        {
            try 
            {
                List<Contact> conList = [select Name , Mailingcity from Contact where AccountId = :i AND Mailingcity !=null];

                for (contact con : conList) 
                {
                    if (con.Mailingcity.contains(' ')) 
                    {
                        System.debug('inside if--');
                        System.debug('mailing city Before Replace is ==> '+con.Mailingcity);
                        String str = con.MailingCity.replace(' ', '%20');
                        // con.Mailingcity.replace(' ','/%20');
                        System.debug('String is ==> '+str);
                        con.MailingCity = str ;
                        System.debug('mailing city After Replace is ==> '+con.Mailingcity);
                    }    
                }
                System.debug('conList is : '+conList);

                return conList ;
    
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
    
        @AuraEnabled
        public static List<String> latitudeLongitude(List<String> loc){
            
            System.debug(loc);
    
            List<String> latLon = new List<String>();
            try 
            {
                for(Integer i = 0; i < loc.size(); i++) 
                {
                    System.debug('i is : => '+i);
    
                    Http h = new Http();
                    HttpRequest hreq = new HttpRequest();
                    HttpResponse hres = new HttpResponse();
    
                    String location = 'https://api.traveltimeapp.com/v4/geocoding/search?query='+loc[i];
    
                    hreq.setEndpoint(location);
                    hreq.setMethod('GET');
                    hreq.setHeader('Accept', 'application/json');
                    hreq.setHeader('X-Api-Key', '3ea8ee4b6e48883a9eb754206f736509');
                    hreq.setHeader('X-Application-Id', 'df91caae');
    
                    hres = h.send(hreq);
                    system.debug('Response is : '+hres.getBody());
    
                    Map<string,Object> data=(Map<string,object>)JSON.deserializeUntyped(hres.getBody());
                    // System.debug('data is : --> '+data);
    
                    // wrapperForTravelTime res = (wrapperForTravelTime) JSON.deserialize(hres.getBody(),wrapperForTravelTime.class );
    
                    List<object> m1 = (List<Object>)data.get('features');
    
                    String m1Data = Json.serialize(m1[0]);
                    // System.debug('After serialise '+ m1Data);
    
                    Map<String,object> m2 = (Map<String,Object>)Json.deserializeUntyped(m1Data) ;
                    // System.debug('Map m2 is : '+ m2);
                    // String m2Data = Json.serialize(m2);
                    Map<string,object> m3 = (Map<String,Object>)m2.get('geometry');
    
                    // System.debug('m3 data is -=-=> '+ m3 );
                    List<Object> m4 = (List<Object>) m3.get('coordinates');
                    // System.debug('data in m4 is ==> '+m4);
    
                    String actualdata = JSON.serialize(m4);
                    System.debug(actualdata);
                    actualdata = actualdata.substring( 1, actualdata.length() - 1 ) ;
    
                    List<String> modifyCordinates = actualdata.split(',');
    
                    String finalCordinates = modifyCordinates[1]+','+modifyCordinates[0];
                    System.debug('final cordinates are : '+finalCordinates);
    
                    latLon.add(finalCordinates);
                }
                    
                
            } 
            catch (Exception e) 
            {
                throw new AuraHandledException(e.getMessage());
            }
    
            return latLon ;
        }
    
    
    }