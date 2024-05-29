trigger trigger_on_Lead_for_platform_event on Lead (before insert,before update) {
	System.debug('Lead trigger');
    
    Test_Platform_Event__e tpe = new Test_Platform_Event__e();
    tpe.Description__c =  Trigger.new[0].FirstName+' '+Trigger.new[0].LastName;
    //insert tpe;
    EventBus.publish(tpe);   
}