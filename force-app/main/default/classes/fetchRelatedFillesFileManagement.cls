public class fetchRelatedFillesFileManagement 
{
    @AuraEnabled
    public static List<ContentDocument> fetchFilesData( String recId )
    {
        List<ContentDocumentLink> cdlList = [SELECT LinkedEntityId, ContentDocumentId FROM ContentDocumentLink where LinkedEntityId = :recId];

        System.debug( 'Result of Content Document Link List is : ');
        System.debug( cdlList );


        List<String> conDocId = new List<String>();

        for (ContentDocumentLink cdID : cdlList) 
        {
            conDocId.add((String)cdId.ContentDocumentId);
        }

        System.debug('only ides of ContentDocument is :-> ');
        System.debug( conDocId );
        
        List<ContentDocument> conDocument = [SELECT Id, Title, FileType, FileExtension FROM ContentDocument where Id IN :conDocId];
        
        System.debug(' Records of Content Document is :-> ');
        System.debug( conDocument );

        return conDocument ;
    }


    @AuraEnabled
    public static String sendEmail( String i , String email)
    {
        try 
        {
            System.debug('id is :- '+i);
            System.debug('email is :- '+email);

            ContentVersion conVer = [select id,contentdocumentid,FileExtension,FileType,versiondata,title from contentversion where contentdocumentid=:i limit 1];

            System.debug('conVer is :-> ');
            System.debug( conVer );


            Messaging.Emailfileattachment e = new Messaging.Emailfileattachment();
            e.setFileName(conVer.title);
            e.setBody(conVer.versiondata);
            if(conVer.FileExtension=='pdf')
            { 
                e.setContentType('application/pdf');

            }
            else if(conVer.FileType=='JPEG' || conVer.FileType=='JPG' || conVer.FileType=='PNG')
            { 
                e.setContentType('image/jpeg');
            }
            else if(conVer.FileExtension=='doc')
            { 
                e.setContentType('application/msword');
            }
            else if(conVer.FileExtension=='docx')
            {
                e.setContentType('application/vnd.openxmlformats-officedocument.wordprocessingml.document');
            }


            //===========================

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            list<String> emailAddr = new list<String>();
            emailAddr.add(email);
            mail.setToAddresses(emailAddr);
            mail.setPlainTextBody('Gaurav Salesforce File');
            
            
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] {e});
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});



        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return 'emailsend';
    }

}