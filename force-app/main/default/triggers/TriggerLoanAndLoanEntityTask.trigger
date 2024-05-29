trigger TriggerLoanAndLoanEntityTask on LoanEntity_Task__c (before insert) 
{
	LoanAndLoanEntityTask.checkData(Trigger.new);
}