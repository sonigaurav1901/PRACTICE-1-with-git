public with sharing class FileUploaderClass 
{

  //to upload file 
  @AuraEnabled
  public static String uploadFile(String base64, String filename, String recordId) 
  {
    ContentVersion cv = createContentVersion(base64, filename);
    ContentDocumentLink cdl = createContentLink(cv.Id, recordId);
    if (cv == null || cdl == null) 
    { return null; }
    return cdl.Id;
  }

  private static ContentVersion createContentVersion( String base64 , String filename ) 
  {
    ContentVersion cv = new ContentVersion();
    cv.VersionData = EncodingUtil.base64Decode(base64);
    cv.Title = filename;
    cv.PathOnClient = filename;
    try {
      insert cv;
      return cv;
    } 
    catch(DMLException e) 
    {
      System.debug(e);
      return null;
    }
  }
  
  private static ContentDocumentLink createContentLink(String contentVersionId, String recordId) {
    if (contentVersionId == null || recordId == null) { return null; }
    
    ContentDocumentLink cdl = new ContentDocumentLink();
    cdl.ContentDocumentId = [
      SELECT ContentDocumentId 
      FROM ContentVersion 
      WHERE Id =: contentVersionId
    ].ContentDocumentId;
    cdl.LinkedEntityId = recordId;
    
    cdl.ShareType = 'V';
    try {
      insert cdl;
      return cdl;
    } 
    catch(DMLException e) {
      System.debug(e);
      return null;
    }
  }

  //creating link between files and opportunity
  @AuraEnabled
  public static void getId( String oppId , String conVerId )
  {
    ContentDocumentLink conDL = new ContentDocumentLink( ContentDocumentId = conVerId , LinkedEntityId = oppId );
    System.debug(conDL);
    insert conDL ;
  }

  //to fecht related files
  @AuraEnabled(cacheable=true)
	public static List<contentVersion> getRec1(String oppId) 
  {
      List<ContentDocumentLink> cdl = [Select ContentDocumentId , LinkedEntityId from ContentDocumentLink where LinkedEntityId = :oppId];
      System.debug(cdl);
      List<String> conVer = new List<String>();
      for(ContentDocumentLink cd:cdl)
      {
          conVer.add(cd.ContentDocumentId);
      }
      system.debug(conVer);
      
      List<contentVersion> conV1 = [Select Title , FileType , FileExtension , ContentDocumentId from contentVersion where ContentDocumentId IN :conVer ];
      System.debug('Final ans ---> '+conv1);
      return conV1 ;
  }

  // send email
  @AuraEnabled
  public static void sendEmail( String demooemail , String verId)
  {
    System.debug(verId);
    ContentVersion con=[select id,contentdocumentid,FileExtension,FileType,versiondata,title from contentversion where id=:verId Limit 1];
    System.debug(con);
    // id temp = con.opportunityid__c;
    // String oppEmail=[select Emai__c from opportunity where id=:temp].emai__c;

    Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
    efa.setFileName(con.title);
    efa.setBody(con.versiondata);
    if(con.FileExtension=='pdf')
    { 
      efa.setContentType('application/pdf');

    }
    else if(con.FileType=='JPEG' || con.FileType=='JPG')
    { 
      efa.setContentType('image/jpeg');
    }
    else if(con.FileExtension=='doc')
    { 
      efa.setContentType('application/msword');
    }
    else if(con.FileExtension=='docx')
    {
      efa.setContentType('application/vnd.openxmlformats-officedocument.wordprocessingml.document');
    }

    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    list<String> emailAddr = new list<String>();
    emailAddr.add(demooemail);
    mail.setToAddresses(emailAddr);
    mail.setPlainTextBody('Hello');
    
    
    mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
    Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
  }
}