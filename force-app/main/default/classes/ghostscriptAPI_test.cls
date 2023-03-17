@istest

Public class ghostscriptAPI_test{


Public static testmethod void ghostscriptAPI1(){

    test.starttest();
    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            Test_SetUpCaseProtocol_5.testCreateProtocol();
            
             Case[] testCase = [Select Settled_Status_Count__c,Protocol__r.Name,Settlement_Negotiation_Status_Count__c,Merit_Settled_Count__c,Merit_Negotiation_Count__c,Merit_Arbitration_Count__c,Merit_Arbitrated_Count__c,Refer_to_Arbitration_Count__c,Total_Loss_Item_Count__c,Arbitration_Prep_Count__c,Arbitration_Final_Offers_Count__c,Arbitration_Negotiation_Count__c,Arbitration_Completed_Count__c,Claimant_Confirms_Case_Settled__c,Payment_Obligation_Email_Sent__c from Case];
          
       TestDateghostDraft.Setup();   
          
    ghostscriptAPI.generateFinalAwardonclose(testCase[0].id);

    ghostscriptAPI.generateInterimAwardonclose(testCase[0].id);
    
    test.stoptest();
    

}



}