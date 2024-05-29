public class fetchTraineer {
    @AuraEnabled
    public static List<institute_Cources__c> Tmain()
    {
        List<institute_Cources__c> traineerList = [Select Name,(Select id , Name , Traineer_Email__c , Maximum_Marks__c from institute_Trainee__r) from institute_Cources__c ORDER BY Name];

        return traineerList ;

    }
}