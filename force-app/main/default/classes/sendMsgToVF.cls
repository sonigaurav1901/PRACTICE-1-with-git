public class sendMsgToVF {
    @AuraEnabled
    public static void sendMsg(String my_message) {
        
        System.debug('message is :- '+my_message);
        
        // Instantiate the new event
        Test_Platform_Event__e ev = new Test_Platform_Event__e();
        ev.Description__c = my_message;
        
        // Publish the event
        Database.SaveResult sr = EventBus.publish(ev);
    }
}