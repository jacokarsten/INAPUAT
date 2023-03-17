@istest

Public class DocumentGridController2_test{


Public static testmethod void setupgrid(){

    test.starttest();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            
            Test_SetUpCaseProtocol_2.testCreateProtocol();
            
            Test_ContentSetup.SetupContent();
            
            Case[] CaseDoc = [Select CaseNumber from Case];
            DocumentGridController2.getFiles(CaseDoc[0].id);
            
            ContentVersion[] files = [SELECT Id,INAP_Doc_Type__c,Sharing_Permissions__c FROM ContentVersion];
            
            DocumentGridController2.saveContentVersion(files);
            
            sObject s = new ContentVersion();
            s= files[0];
            
            DocumentGridController2.getselectOptions(s,'Sharing_Permissions__c');
            
            
    test.stoptest();
    

}



}