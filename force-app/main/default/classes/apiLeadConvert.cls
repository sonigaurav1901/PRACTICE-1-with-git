@RestResource(urlMapping = '/LeadConRec/*')
global class apiLeadConvert {
	@HttpPost
    Global static List<String> myMethod()
    {
        RestRequest req = RestContext.request;
        //System.debug(req);
        
        String str = req.requestBody.toString();
        //System.debug(str);
        
        Map<String,object> m1 = (Map<String,object>)JSON.deserializeUntyped(str);
        List<object> leadIdes =  (List<object>)m1.get('Ides');
        List<String> ans = new List<String>();
        for(object ob:leadIdes)
        {
            ans.add((String)ob);
        }
        List<String> LeadId = new List<String>(); 
        
        List<Lead> lList = [Select id,ConvertedAccountId from Lead where id In:ans];
        for(Lead l:lList)
        {
            System.debug(l);
            
			
            Database.LeadConvert le = new Database.leadconvert();
            le.setLeadId(l.id);
            le.convertedstatus = 'Closed - Converted';
            le.ownerid = '0055i000003UCPZAA4';
            Database.LeadConvertResult lcr = Database.convertLead(le);
     
        }
        lList = [Select id,ConvertedAccountId from Lead where id IN:lList];
        //System.debug(l);
        for(Lead l1:lList)
        {
            if(lList[0].ConvertedAccountId != NULL)
            {
               LeadId.add(lList[0].ConvertedAccountId);
            }
        }
        
        return LeadId;
    }
}