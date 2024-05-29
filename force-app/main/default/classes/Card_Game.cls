public with sharing class Card_Game
{
    @AuraEnabled
    public static Boolean UserInfo(String Name,String Email)
    {
        Boolean isCheck = true;
        List<Card_Game_User_Info__c> UserList = [Select Id,User_Email__c from Card_Game_User_Info__c];
        For(Card_Game_User_Info__c user : UserList)
        {
            if(Email == user.User_Email__c)
            {
                isCheck = false;
                break;
            }
        }
        if(isCheck)
        {
            Card_Game_User_Info__c newUser = new Card_Game_User_Info__c();
            newUser.User_Name__c  = Name;
            newUser.User_Email__c = Email;
            Insert newUser;
        }
        return isCheck;
    }
}