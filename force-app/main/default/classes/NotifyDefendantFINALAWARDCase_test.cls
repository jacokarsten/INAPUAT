@istest

Public class NotifyDefendantFINALAWARDCase_test{


Public static testmethod void NotifyDefendantFINALAWARDCase1(){

    test.starttest();
          // Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
          //  Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
           // Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
           // Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            Test_InsertFirm_Contact_Team_TeamRole_2.insertContactUser();  
            Test_SetUpCaseProtocol_5.testCreateProtocol();
            
             Case[] testCase = [Select Settled_Status_Count__c,Protocol__r.Name,Settlement_Negotiation_Status_Count__c,Merit_Settled_Count__c,Merit_Negotiation_Count__c,Merit_Arbitration_Count__c,Merit_Arbitrated_Count__c,Refer_to_Arbitration_Count__c,Total_Loss_Item_Count__c,Arbitration_Prep_Count__c,Arbitration_Final_Offers_Count__c,Arbitration_Negotiation_Count__c,Arbitration_Completed_Count__c,Claimant_Confirms_Case_Settled__c,Payment_Obligation_Email_Sent__c from Case];
             testCase[0].Claimant_Confirms_Case_Settled__c = true;
             testCase[0].Payment_Obligation_Email_Sent__c = true;
              /*
             System.debug('**Settled_Status_Count***'+testCase[0].Settled_Status_Count__c);
             System.debug('**Settlement_Negotiation_Status_Count__c***'+testCase[0].Settlement_Negotiation_Status_Count__c);
             System.debug('***Total_Loss_Item_Count__c**'+testCase[0].Total_Loss_Item_Count__c);
             System.debug('***Merit_Settled_Count__c**'+testCase[0].Merit_Settled_Count__c);
             System.debug('**Merit_Negotiation_Count__c***'+testCase[0].Merit_Negotiation_Count__c);
             System.debug('**Merit_Arbitration_Count__c***'+testCase[0].Merit_Arbitration_Count__c);
             System.debug('***Merit_Arbitrated_Count_**'+testCase[0].Merit_Arbitrated_Count__c);
             System.debug('**Arbitration_Negotiation_Count__c***'+testCase[0].Arbitration_Negotiation_Count__c);
             System.debug('**Arbitration_Completed_Count__c***'+testCase[0].Arbitration_Completed_Count__c);
             System.debug('**Protocol***'+testCase[0].Protocol__r.Name);
             */
             
             update testCase; 
    
    test.stoptest();
    

}



}