public class vfDataFetch {
    public static String stName;
    public static String stCource;
    public static Integer stAge;
    public static Integer stFees;
    public static String stEmail;
    
	public static void myMethod()
    {
        System.debug('Hello World');
        //system.debug(Apexpages.currentpage().getparameters());
        String n;
        if(String.valueOf(Apexpages.currentpage().getparameters().get('name'))!=''){
            n = Apexpages.currentpage().getparameters().get('name');
   		}
		String cou;
        if(Apexpages.currentpage().getparameters().get('cources')!=''){
            cou = Apexpages.currentpage().getparameters().get('cources');
   		}
        
        Integer age;
        if(String.valueOf(Apexpages.currentpage().getparameters().get('age'))!=''){
         	age = integer.valueOf(Apexpages.currentpage().getparameters().get('age') );
   		}
		Integer fees;
        if(String.valueOf(Apexpages.currentpage().getparameters().get('fees'))!=''){
         	fees = integer.valueOf(Apexpages.currentpage().getparameters().get('fees') );
   		}
        
		String email;
        if(Apexpages.currentpage().getparameters().get('email')!=''){
            email = Apexpages.currentpage().getparameters().get('email');
   		}
        /*
        //passing value to global variables ...
        stName = n ; vfDataFetch.stCource = cou ; vfDataFetch.stAge = age ;
        vfDataFetch.stFees = fees ; vfDataFetch.stEmail = email ;
        
        System.debug(vfDataFetch.stName);
        System.debug(vfDataFetch.stCource);
        System.debug(vfDataFetch.stAge);
        System.debug(vfDataFetch.stFees);
        System.debug(vfDataFetch.stEmail);
*/
        
        webStudent__c st = new webStudent__c(name = n , Cources__c = cou , age__c = age , fees__c = fees , Email__c = email);
        Database.SaveResult sr = database.insert(st,false);
        if(sr.isSuccess())
        {
            redirectFun();
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Success'));
            
        }
        else
        {
            for(Database.Error objErr : sr.getErrors()) {
                 System.debug('The following error has occurred.');
                 // Printing error message in Debug log
                 System.debug(objErr.getStatusCode() + ': ' + objErr.getMessage());
                 System.debug('Invoice oject field which are affected by the error:' 
                + objErr.getFields());
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'plz insert'));
      		}
            redirectFun1();
        }
    }
    
    public static PageReference redirectFun()
    {
        String n;
        if(String.valueOf(Apexpages.currentpage().getparameters().get('name'))!=''){
            n = Apexpages.currentpage().getparameters().get('name');
   		}
		String cou;
        if(Apexpages.currentpage().getparameters().get('cources')!=''){
            cou = Apexpages.currentpage().getparameters().get('cources');
   		}
        
        Integer age;
        if(String.valueOf(Apexpages.currentpage().getparameters().get('age'))!=''){
         	age = integer.valueOf(Apexpages.currentpage().getparameters().get('age') );
   		}
		Integer fees;
        if(String.valueOf(Apexpages.currentpage().getparameters().get('fees'))!=''){
         	fees = integer.valueOf(Apexpages.currentpage().getparameters().get('fees') );
   		}
        
		String email;
        if(Apexpages.currentpage().getparameters().get('email')!=''){
            email = Apexpages.currentpage().getparameters().get('email');
   		}
        
        //passing value to global variables ...
        stName = n ; vfDataFetch.stCource = cou ; vfDataFetch.stAge = age ;
        vfDataFetch.stFees = fees ; vfDataFetch.stEmail = email ;
        System.debug('chalega kya');
        PageReference retURL = new PageReference('http://127.0.0.1:5500/Q2.html?name='+vfDataFetch.stName+'&Cources='+vfDataFetch.stCource+'&age='+vfDataFetch.stAge+'&fees='+vfDataFetch.stFees+'&email='+vfDataFetch.stEmail);
		System.debug(retURL);
        System.debug(stName);
        System.debug(stCource);
        System.debug(stAge);
        System.debug(stFees);
        System.debug(stEmail);
        retURL.setRedirect(true);
      	return retURL;
    }
    
    public static PageReference redirectFun1()
    {
        PageReference retURL = new PageReference('http://127.0.0.1:5500/Q2.html');
      	retURL.setRedirect(true);
      	return retURL;
    }
    
}