public class activityLwcTaskApex {
    
    @AuraEnabled
    public static List<Task> LoadTask(Id AccId){
        try {
            List<Task> relatedTask = [select Id,Subject,ActivityDate,account.id,Status FROM Task where subject != 'Call' AND account.id =: AccId AND ( NOT subject like 'Email:%')];
            System.debug('Related task are : '+relatedTask);

            return relatedTask ;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    } 
    @AuraEnabled
    public static List<Task> LoadCallLogs(Id AccId){
        try {
            List<Task> relatedCallLogs = [select Id,Subject,ActivityDate,account.id,Status FROM Task where subject = 'Call' AND account.id =: AccId];
            System.debug('Related CallLogs are : '+relatedCallLogs);

            return relatedCallLogs ;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    } 
    @AuraEnabled
    public static List<Task> LoadEmail(Id AccId){
        try {
            List<Task> relatedEmail = [select Id,Subject,ActivityDate,account.id,Status FROM Task where subject like 'Email:%' AND account.id =: AccId];
            System.debug('Related Email are : '+relatedEmail);

            return relatedEmail ;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    } 

    @AuraEnabled
    public static List<Event> LoadEvent(Id AccId){
        try {
            List<Event> relatedEvent=[Select subject,Id,WhoId,StartDateTime,account.Name from Event where account.id=: AccId and (subject='Meeting' or subject='Send Letter/Quote' or subject='Other')];
            System.debug('Related Events are : '+relatedEvent);

            return relatedEvent ;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    } 

}