trigger trigger_on_lead on Lead (before insert) 
{
    Database.executeBatch(new batchClassOnLead(Trigger.new),200);
	//HelperClassOnLead.main(trigger.new);
}