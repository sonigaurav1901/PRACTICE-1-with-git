public with sharing class ContactDirectory {
    @AuraEnabled(cacheable = true)
    public static List<Contact> getContactRecords(){
        return [Select Id, Name from Contact];
    }
}