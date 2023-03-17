@istest

Public class FileListViewController_test{


Public static testmethod void setupFileListView(){

    test.starttest();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            
            Test_SetUpCaseProtocol_2.testCreateProtocol();
            
            Test_ContentSetup.SetupContent();
            
            Case[] CaseDoc = [Select CaseNumber from Case];
            FileListViewController.getFiles(CaseDoc[0].id);
            
            ContentVersion[] files = [SELECT Id,INAP_Doc_Type__c,Sharing_Permissions__c FROM ContentVersion];
            
            FileListViewController.saveContentVersion(files);
            
            sObject s = new ContentVersion();
            s= files[0];
            
            FileListViewController.getselectOptions(s,'Sharing_Permissions__c');
            
            
    test.stoptest();
    

}



}