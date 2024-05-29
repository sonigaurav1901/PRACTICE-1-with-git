public class contactController_AuraTest {
    @AuraEnabled
    public static List<Contact> getContacts(Id recordId) {
        return [Select Id, FirstName, LastName, Email, Phone FROM Contact WHERE AccountId =: recordId];
    }
}