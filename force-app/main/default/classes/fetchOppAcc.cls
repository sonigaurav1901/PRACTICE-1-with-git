public class fetchOppAcc {
    @AuraEnabled
    public static List<Opportunity> fetchOnLoad()
    {
        List<Opportunity> oppAcc = [select Name , Account.Name , Amount , StageName , payed_Amount__c , (select Name from Payment_obj__r ) from Opportunity limit 20 ];
        System.debug('opp is :-> '+oppAcc);
        return oppAcc ;
    }

    @AuraEnabled
    public static List<Payment_obj__c> fetchPayment(String i)
    {
        List<Payment_obj__c> payList = [select Name from Payment_obj__c where Opportunity__c=:i ];
        System.debug('opp is :-> '+payList);
        return payList ;
    }
    
    @AuraEnabled
    public static List<Payment_obj__c> fetchPaymentdetails(String i)
    {
        List<Payment_obj__c> payList = [select Name,Id from Payment_obj__c where Name=:i ];
        System.debug('opp is :-> '+payList);
        return payList ;
    }

    @AuraEnabled
    public static void insertPayment(String ownerNa , Decimal cardN , integer mont , integer yea , integer cv , integer amt , String rowId){
        try     
        {
            System.debug('owner Name is : '+ownerNa);
            System.debug('Card Number is : '+cardN);
            System.debug('Month is : '+mont);
            System.debug('Year is : '+yea);
            System.debug('cvv is : '+cv);
            System.debug('amount is : '+amt);
            System.debug('Row id is : '+rowId);
            Payment_obj__c p = new Payment_obj__c(owner_Name__c=ownerNa , card_Number__c=cardN , month__c=mont , year__c=yea , cvv__c=cv , amount_Payable__c=amt , Opportunity__c=rowId );

            insert p ;

            Opportunity opp = [select payed_Amount__c from Opportunity where id =:rowId limit 1];
            if(opp.payed_Amount__c == null)
            {
                opp.payed_Amount__c = 0 ;
            }
            opp.payed_Amount__c = opp.payed_Amount__c + amt ;
            update opp ;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}