@RestResource(urlMapping = '/apiCompanyDelasTask/*')
Global class apiPostman 
{
    @HttpPost
    Global static String myMethod()
    {
        RestRequest req = RestContext.request;
        String str = req.requestBody.toString();
        Map<String,object> m1 = (Map<String , object>) JSON.deserializeUntyped(str) ; 
        
									//Comapny conditions
		 
        String idd = (String)m1.get('company_external_system_id__c');
        String na = (String)m1.get('comapny_Name__c');
        String lastModDate = (String)m1.get('comp_external_last_modified_datetime__c');
        String exId = (String)m1.get('company_external_system_id__c');
        String comDescription = (String)m1.get('description__c');
        
        List<String>str1 = lastModDate.split('-');
        List<comapny_Task__c> company = [select comapny_Name__c,company_external_system_id__c,comp_external_last_modified_datetime__c from comapny_Task__c where company_external_system_id__c =:idd LIMIT 1];

        date d = Date.newInstance(integer.valueof(str1[0]),integer.valueof(str1[1]),integer.valueof(str1[2]));
        if( company.size() != 0 )
        {
         	if(company[0].comp_external_last_modified_datetime__c < d )
            {
                company[0].Name = na ;
                company[0].comapny_Name__c = na ;
                company[0].comp_external_last_modified_datetime__c = d ;
                update company ; 
            }
        }
        else
        {
            comapny_Task__c com = new comapny_Task__c (Name = na , comapny_Name__c = na , company_external_system_id__c = exId , description__c = comDescription , comp_external_last_modified_datetime__c = d );
            insert com;
        }
        
        						//Deal Conditions 
        
        String dealId = (String)m1.get('deal_external_system_id__c');
        String dealna = (String)m1.get('dealNameTask__c');
        Integer sealAmt = integer.valueof(m1.get('amount__c'));
        String dealLastModDate = (String)m1.get('external_last_modified_datetime__c');
        String dealExId = (String)m1.get('deal_external_system_id__c');
        String dealDescription = (String)m1.get('deal_description__c');
        String dealContactPerson = (String)m1.get('contact_person__c');
        
        List<String>dealStr = dealLastModDate.split('-');
        List<deals__c> deals = [select dealNameTask__c , amount__c , deal_description__c , contact_person__c , deal_external_system_id__c , external_last_modified_datetime__c from deals__c where deal_external_system_id__c =:dealExId limit 1];
        
        date dealD = Date.newInstance(integer.valueof(dealStr[0]),integer.valueof(dealStr[1]),integer.valueof(dealStr[2]));

        if( deals.size() != 0 )
        {
         	if(deals[0].external_last_modified_datetime__c < dealD )
            {
                deals[0].Name = dealna ;
                deals[0].dealNameTask__c = dealna ;
                deals[0].amount__c = sealAmt ;
                deals[0].deal_description__c = dealDescription ;
                deals[0].external_last_modified_datetime__c = dealD ;
                deals[0].deal_external_system_id__c = dealExId ;
                deals[0].contact_person__c = dealContactPerson ;
                
                update deals ; 
            }
        }
        else
        {
            deals__c deals1 = new deals__c (Name = dealna , dealNameTask__c = dealna , deal_external_system_id__c = dealExId , deal_description__c = dealDescription , external_last_modified_datetime__c = dealD );
            insert deals1;
        }
       
        					// Contact conditions
        
        String Contactna = (String)m1.get('lastName');
        String ContactlastModDate = (String)m1.get('Contact_external_last_modified_datetime__c');
        String ContactexId = (String)m1.get('contact_external_system_id__c');
        String ContactDescription = (String)m1.get('Description');
        
        List<String>conStr = ContactlastModDate.split('-');
        date ConD = Date.newInstance(integer.valueof(conStr[0]),integer.valueof(conStr[1]),integer.valueof(conStr[2]));
        List<Contact> conList = [select Name ,Contact_external_last_modified_datetime__c,contact_external_system_id__c, Description from contact where contact_external_system_id__c=:ContactexId ];
        System.debug('Conlist is ======> '+conList);
        if( conList.size() != 0 )
        {
            System.debug('Inside if ... ');
         	if(conList[0].Contact_external_last_modified_datetime__c < ConD )
            {
                System.debug('Inside nested if...');
                conList[0].lastName = Contactna ;
                conList[0].contact_external_system_id__c = ContactexId ; 
                conList[0].Contact_external_last_modified_datetime__c = ConD ;
                conList[0].Description = ContactDescription;
                update conList ; 
                System.debug('conList details ... are ... '+conList);   
            }
        }
        else
        {
            contact con1 = new contact (lastName = Contactna , contact_external_system_id__c = ContactexId , Contact_external_last_modified_datetime__c = ConD  , Description = ContactDescription );
            insert con1;
        }
        return 'Test';
    }

}