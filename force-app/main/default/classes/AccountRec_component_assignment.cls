public class AccountRec_component_assignment {
    @AuraEnabled(cacheable=true)
    public static List<Account> fetchAccountRec() {
        List<Account> accList = [SELECT Id, Staff_ID__c, Name, RecordType.Name, Active__c, Email__c FROM Account ORDER BY CreatedDate DESC Limit 45];
        System.debug('accList -> '+accList);
        return accList;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Account> filterRecord(String NameLike , String recordTypeName) {
        List<Account> accList = new List<Account>();
        NameLike = '%'+NameLike+'%';
        System.debug('record '+recordTypeName);
        if(recordTypeName != '' && NameLike == '') {
            System.debug('if   '+recordTypeName+'  --  '+NameLike);
         	accList = [SELECT Staff_ID__c, Name, RecordType.Name, Active__c, Email__c FROM Account where RecordType.Name =:recordTypeName ORDER BY CreatedDate DESC Limit 45];
        } else if(recordTypeName != '' && NameLike != '') {
            System.debug('else if   '+recordTypeName+'  --  '+NameLike);
			accList = [SELECT Staff_ID__c, Name, RecordType.Name, Active__c, Email__c FROM Account where (Name like :NameLike OR Staff_ID__c like :NameLike OR Email__c like :NameLike) AND RecordType.Name =:recordTypeName ORDER BY CreatedDate DESC Limit 45];            
        } 
        else {
            System.debug('else   '+recordTypeName+'  --  '+NameLike);
            accList = [SELECT Staff_ID__c, Name, RecordType.Name, Active__c, Email__c FROM Account where Name like :NameLike OR Staff_ID__c like :NameLike OR Email__c like :NameLike ORDER BY CreatedDate DESC Limit 45];
        }
        
        System.debug('Filter accList -> '+accList);
        return accList;
    }
    
    @AuraEnabled
    public static List<Map<String,Object>> getFields(String AccountId) {
        //String AccountId = '0015i00000uaAnnAAE';
        List<LwcAccountsAssignment__mdt> listAccount = [SELECT Id,AccountFields__c from LwcAccountsAssignment__mdt];
        System.debug('listAccount is '+listAccount);
        Map<String,Object> m1 = (Map<String,Object>)JSON.deserializeUntyped(String.valueOf(listAccount[0].get('AccountFields__c')));
        System.debug('Section 1 '+ m1.get('section1'));
        List<Object> dataInsection1 = (List<Object>) JSON.deserializeUntyped(JSON.serialize(m1.get('section1')));
        List<Object> dataInsection2 = (List<Object>) JSON.deserializeUntyped(JSON.serialize(m1.get('section2')));
        
        System.debug('dataInsection1 is -> '+dataInsection1);
        String query = 'Select Id, '+dataInsection1+','+dataInsection2+' from Account where Id ="'+AccountId+'" Limit 1';
        query = query.replace('(', '');
        query = query.replace(')', '');
        query = query.replace('"', '\'');
        System.debug('query is -> '+query);
        Account ac = Database.query(query);
        System.debug('ac is -> '+ac);
        Map<String, Object> acMap = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(ac));
        System.debug('ac map is '+acMap);
        Map<String,Schema.SObjectField> mfields = Schema.Account.SObjectType.getDescribe().fields.getMap();
        Map<String,Object> fieldLabelSec1 = new Map<String,Object>();
       
        for(object section1Val: dataInsection1)
        {
            Schema.DescribeFieldResult fieldResult = mfields.get(String.valueOf(section1Val)).getDescribe();
            String fieldApi = String.valueOf(section1Val);
            System.debug('field  -> '+acMap.get(fieldApi));
			if(acMap.get(fieldApi) != null )
            {
            	fieldLabelSec1.put( fieldResult.getLabel() , acMap.get(fieldApi));    
            } 
            else {
                fieldLabelSec1.put( fieldResult.getLabel() , ' ');
            }
        }
        
        System.debug('fieldresult Sec1 -> '+fieldLabelSec1);
        
        
        Map<String,Object> fieldLabelSec2 = new Map<String,Object>();
        for(object section2Val: dataInsection2)
        {
            String fieldApi = String.valueOf(section2Val);
            Schema.DescribeFieldResult fieldResult = mfields.get(String.valueOf(section2Val)).getDescribe();
            if(acMap.get(fieldApi) != null )
            {
            	fieldLabelSec2.put( fieldResult.getLabel() , acMap.get(fieldApi));    
            } 
            else {
                fieldLabelSec2.put( fieldResult.getLabel() , ' ');
            }
			
        }
        System.debug('fieldresult Sec2 -> '+fieldLabelSec2);
        
        List<Map<String,Object>> finalData = new List<Map<String,Object>>();
        finalData.add(fieldLabelSec1);
        finalData.add(fieldLabelSec2);
        System.debug('final Data is ==> '+finalData);
        return finalData;
    }
    
    @AuraEnabled
    public static Map<String,Object> fetchDataOfOpp(String AccId){
        //String AccId1 = '0015i00000uaAnnAAE';
        List<AggregateResult> closeWonCount = [select Count(Id)total from Opportunity where AccountId =:AccId AND StageName ='Closed Won'];
        System.debug('count of close won opp is :- ' + closeWonCount[0].get('total'));
        List<AggregateResult> closeLostCount = [select Count(Id)total from Opportunity where AccountId =:AccId AND StageName ='Closed Lost'];
        System.debug('count of close Lost opp is :- ' + closeLostCount[0].get('total'));
        List<AggregateResult> openCount = [select Count(Id)total from Opportunity where AccountId =:AccId AND StageName !='Closed Won' AND StageName !='Closed Lost'];
        System.debug('count of close open opp is :- ' + openCount[0].get('total'));
        Map<String,Object> percentages_of_opportunity = new Map<String,Object>();
        
        percentages_of_opportunity.put('cw',closeWonCount[0].get('total'));
        percentages_of_opportunity.put('cl',closeLostCount[0].get('total'));
        percentages_of_opportunity.put('open',openCount[0].get('total'));
        
        System.debug('map is -> '+percentages_of_opportunity);
        
        return percentages_of_opportunity;
    }
    
}