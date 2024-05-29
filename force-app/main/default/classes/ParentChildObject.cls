public class ParentChildObject 
{
    //to fetch Related Child object
    @AuraEnabled
    public static List<String> childObjOfAcc(String objName)
    {
        try 
        {
            String myString = objName;
            SObjectType objectName = ((SObject) Type.forName(myString).newInstance())
                                  .getSObjectType();

            List<String> temp = new List<String>();
            Schema.DescribeSObjectResult R = objectName.getDescribe();
            for (Schema.ChildRelationship cr: R.getChildRelationships()) 
            {
                system.debug(cr.getChildSObject());
                temp.add(String.valueOf(cr.getChildSObject()));
            }
            return temp ; 
        } catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }
    // to fetch related parent objects
    @AuraEnabled
    public static List<String> ParentObjOfAcc(String objName)
    {
        try 
        {
            String myString = objName;
            SObjectType objectName = ((SObject) Type.forName(myString).newInstance())
                                  .getSObjectType();

            List<String> temp = new List<String>();
            // Schema.DescribeSObjectResult R = objectName.getDescribe();
            for(Schema.SobjectField strFld: objectName.getDescribe().fields.getMap().Values()){
                if(strFld.getDescribe().getType() == Schema.DisplayType.REFERENCE){
                    system.debug(strFld.getDescribe().getReferenceTo());
                    temp.add(String.valueOf(strFld.getDescribe().getReferenceTo()));
                }
            }
            return temp ; 
        } catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //To fetch records of parent component
    @AuraEnabled
    public static List<SObject> fetchParentRec(String objName)
    {
        try 
        {
            String str = 'select Name , OwnerId from '+objName ;
            System.debug('our Query is : '+str);
            //  [ SELECT FIELDS(Standard) FROM Acc];    
            List<SObject> li = Database.query(str);
            System.debug('Value of List : '+li);
            return li ; 
        } catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }


    // to fetch all field of child object which is selected ... 
    @AuraEnabled
    public static List<SObject> childData(String Acc)
    {
        try 
        {
            String str =  'SELECT FIELDS(Standard) FROM '+Acc+' Limit 1' ;
            System.debug('value of str : '+str);
            //  [ SELECT FIELDS(Standard) FROM Acc];  
            List<SObject> li = Database.query(str);
            System.debug('Value of Li : '+li);
            return li ; 
        } catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }


    //Fetching records according to requirement
    @AuraEnabled
    public static List<SObject> fetchRec(String objName , String fields)
    {
        try 
        {
            String str = 'select '+fields+' from '+objName ;
            System.debug('our Query is : '+str);
            //  [ SELECT FIELDS(Standard) FROM Acc];  
            List<SObject> li = Database.query(str);
            System.debug('Value of List : '+li);
            return li ; 
        } catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }
}