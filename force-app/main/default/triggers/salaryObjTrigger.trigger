trigger salaryObjTrigger on Salary__c (after insert,after update) {
	if(trigger.isAfter)
    {
        if(trigger.isInsert)
        {
            SalaryHelperClass.afterInsert(trigger.new);
        }
        else if(trigger.isUpdate)
        {
            SalaryHelperClass.afterUpdate(Trigger.OldMap, Trigger.NewMap);
        }
    }
}