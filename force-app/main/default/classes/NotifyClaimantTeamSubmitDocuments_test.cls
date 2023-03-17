@istest

Public class NotifyClaimantTeamSubmitDocuments_test{


Public static testmethod void NotifyClaimantTeamSubmitDocumentsSOL1(){

    test.starttest();
    
           
         //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
        
            Test_InsertFirm_Contact_Team_TeamRole_2.insertContactUser();  
            Test_SetUpCaseProtocol_3.testCreateProtocol();
            
            List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c,
            Claimant_Accept_Decline__c, Defendant_Accept_Decline__c,Arbitrators_Award_Finalised__c,  Claimant_Final_Offer_Confirmed__c,Defendant_Final_Offer_Confirmed__c,Claimant_Confirm_Documents_Uploaded__c, 
             Defendant_Confirm_Documents_uploaded__c,   Arbitration_Start_Date__c,Doc_Prep_Start_Date__c,Final_Offers_Start_Date__c,Name,Case__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c]);
         
           ScheduleofLosses[0].Defendant_Confirm_Documents_uploaded__c=true;
           update ScheduleofLosses;
         //  ScheduleofLosses[0].Claimant_Confirm_Documents_Uploaded__c=true;
          // update ScheduleofLosses;
    test.stoptest();
    

}
Public static testmethod void NotifyClaimantTeamSubmitDocumentsSOL2(){

    test.starttest();
    
           
         //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
        
            Test_InsertFirm_Contact_Team_TeamRole_2.insertContactUser();  
            Test_SetUpCaseProtocol_3.testCreateProtocol();
            
            List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c,
            Claimant_Accept_Decline__c, Defendant_Accept_Decline__c,Arbitrators_Award_Finalised__c,  Claimant_Final_Offer_Confirmed__c,Defendant_Final_Offer_Confirmed__c,Claimant_Confirm_Documents_Uploaded__c, 
             Defendant_Confirm_Documents_uploaded__c,   Arbitration_Start_Date__c,Doc_Prep_Start_Date__c,Final_Offers_Start_Date__c,Name,Case__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c]);
         
       //    ScheduleofLosses[0].Defendant_Confirm_Documents_uploaded__c=true;
        //   update ScheduleofLosses;
           ScheduleofLosses[0].Claimant_Confirm_Documents_Uploaded__c=true;
           update ScheduleofLosses;
    test.stoptest();
    

}


}