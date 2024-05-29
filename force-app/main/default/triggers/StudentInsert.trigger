trigger StudentInsert on webStudent__c (after insert) {
	
    if(Trigger.isAfter)
    {
        if(trigger.isInsert)
        {
            productStripeApi.main(JSON.serialize(trigger.new));
        }
    }
}