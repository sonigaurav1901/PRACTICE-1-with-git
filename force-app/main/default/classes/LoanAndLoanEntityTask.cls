public class LoanAndLoanEntityTask {
	public static void checkData(List<LoanEntity_Task__c> loanEntity) 
    {
        String loanID = loanEntity[0].select_Loan__c ;
        List<LoanEntity_Task__c> L_Entity = [select Id,Name,Borrower_Type__c,Loan_Amount__c from LoanEntity_Task__c where Select_Loan__c=:loanID];
        
        //system.debug('Working'+L_Entity);
        integer LoanAmtSum = 0;
        
        integer count_CoBorrower = 0 ;
        
        for(LoanEntity_Task__c l : L_Entity)
        {
            LoanAmtSum = LoanAmtSum + (integer)l.Loan_Amount__c ; 
            if(l.Borrower_Type__c == 'Co-Borrower' )
            {
                count_CoBorrower = count_CoBorrower+1 ; 
            }
        }
        System.debug('count is : '+count_CoBorrower);
        System.debug('sum of total loan amount is : '+LoanAmtSum);
        
        List<LoanEntity_Task__c> finalList = new List<LoanEntity_Task__c>();
        
        for(LoanEntity_Task__c l : loanEntity)
        {
            if(LoanAmtSum <= 50000)
            {
                System.debug('Less than 50 K');
                if(l.Borrower_Type__c == 'Co-Borrower') 
                {
                    if(count_CoBorrower < 3)
                    {
                        finalList.add(l);
                    }
                    else
                    {
                        l.addError('you can not use Co-Borrower as it exceed limit...');
                        System.debug('Inside error if ...');
                    }
                }
                else
                {
                    finalList.add(l);
                }
            }
            else if (LoanAmtSum > 50000)
            {
                System.debug('greater than 50 K');
                finalList.add(l);
            }
        }
        System.debug('Final list is :- '+finalList);
        //insert finalList ; 
    }
}