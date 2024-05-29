public class createStudent {
    public Static void main()
    {
        student__c std = new student__c(Student_Name__c = 's1',Student_Contact__c=21456458 ,Student_Email__c='s1@gmail.com' );
        //insert std;
        System.debug(std);
    }

}