Public Class Test_ContentSetup{


Public static void SetupContent(){
    
   Case[] CaseDoc = [Select CaseNumber from Case];
        
   String DocName = 'Commencement';
   Blob requestresponse = blob.valueof('testing');
   Network[] Nwork = [SELECT Id,Name FROM Network limit 1];
    
    ContentVersion contentVersion = new ContentVersion(
      Title = DocName,
      PathOnClient = DocName,
      Sharing_Permissions__c = 'Shared',
      Case_Id__c = CaseDoc[0].id,
      VersionData = requestresponse,
      INAP_Doc_Type__c = 'Commencement',
      Ghost_Draft_Doc__c =true,
      NetworkId = Nwork[0].id,
      IsMajorVersion = true
    );
    insert contentVersion;    
    
    system.debug('**CV**'+contentVersion);
    List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument where title=:DocName];

    system.debug('**documents**'+documents);
    //create ContentDocumentLink  record 
    
    ContentDocumentLink cdl = New ContentDocumentLink();
    cdl.LinkedEntityId = CaseDoc[0].id;
    cdl.ContentDocumentId = documents[0].Id;
    cdl.shareType = 'V';
    insert cdl;


}




}