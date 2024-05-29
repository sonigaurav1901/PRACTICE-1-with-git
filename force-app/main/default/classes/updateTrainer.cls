public class updateTrainer {
    @AuraEnabled
    public static void main(String TrainerId , Integer MaxMarks)
    {
        institute_Trainee__c trainer = [Select id , Maximum_Marks__c from institute_Trainee__c where id=:TrainerId];
        trainer.Maximum_Marks__c = MaxMarks ;

        update trainer ;
    }
}