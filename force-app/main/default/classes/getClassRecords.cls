public class getClassRecords {
    @AuraEnabled
    public static List<Student_Class__c> getOptions(){
        try 
        {
            List<Student_Class__c> stCl = [select Name from Student_Class__c];
            System.debug(stCl);
            return stCl;
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Student_Class__c> classStudentData(String i)
    {
        System.debug('Id Of Class Is '+i);
        try 
        {
            List<Student_Class__c> clDetail = [select Name, (select Name , studentSeatLoc__c , stName__c , stRollNo__c , stMarks__c from Student_Detail__r where Student_Class__c = :i) from Student_Class__c where Id = :i ];
            System.debug(clDetail);
            return clDetail;
        }
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }
    // to fetch Selected option 
    @AuraEnabled
    public static Student_Class__c getSelectedOptions(String i,Integer row)
    {
        System.debug(i);
        try 
        {
            Student_Class__c selectedVal = [select Name from Student_Class__c where Id = :i] ;
            selectedVal.rowsInClass__c = row ;
            update selectedVal ;
            return selectedVal ;
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Student_Class__c fetchRows(String ide)
    {
        System.debug(ide);
        try 
        {
            Student_Class__c selectedRowVal = [select Name,rowsInClass__c from Student_Class__c where Id = :ide] ;
            System.debug('count of rows --> '+selectedRowVal);
            return selectedRowVal;
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }
            // Student detail wheather it is assigned seat or not ... 
    @AuraEnabled
    public static Student_Details__c fetchSeatAssignedOrNot(String sNo){
        try 
        {
            Student_Details__c st = [select stName__c , assignedSeateOrNot__c from Student_Details__c where Name =:sNo];  
            return st;
        }
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }
            // to assign seat to student...to delete assigned seat to an student...
    @AuraEnabled
    public static Student_Details__c AssignedSeatAndSetInfo(String sNo , Integer i , String stdSeetingInfo)
    {
        try 
        {
            Student_Details__c st = [select stName__c , studentSeatLoc__c , assignedSeateOrNot__c from Student_Details__c where Name =:sNo];  
            st.assignedSeateOrNot__c = i;
            st.studentSeatLoc__c = stdSeetingInfo ;
            update st;
            return st;
        }
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }



    // @AuraEnabled
    // public static Student_Details__c fetchSnoRec(String sNo)
    // {
    //     try 
    //     {
    //         Student_Details__c st = [select Name, stName__c , studentSeatLoc__c , assignedSeateOrNot__c from Student_Details__c where Name =:sNo];         
    //     } catch (Exception e) 
    //     {
    //         throw new AuraHandledException(e.getMessage());
    //     }
    // }
}