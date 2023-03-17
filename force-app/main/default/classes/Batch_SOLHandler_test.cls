@istest

Public class Batch_SOLHandler_test{


Public static testmethod void SOLHandler1(){

    test.starttest();
        Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            Test_SetUpCaseProtocol_5.testCreateProtocol();
            
             List<Schedule_of_Losses__c> ScheduleofLosses  = new List<Schedule_of_Losses__c>([Select 
             id, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c,
             Claimant_Accept_Decline__c, Defendant_Accept_Decline__c,Arbitrators_Award_Finalised__c,  Claimant_Final_Offer_Confirmed__c,
             Defendant_Final_Offer_Confirmed__c,Claimant_Confirm_Documents_Uploaded__c, 
             Defendant_Confirm_Documents_uploaded__c,Arbitrator_Invite_Date__c,Invite_Arbitrator__c,   
             Arbitration_Start_Date__c,Doc_Prep_Start_Date__c,Final_Offers_Start_Date__c,Name,Case__c,
             Unilateral_Arbitration_Overlap__c,
             Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c ]);
         
        System.Debug('***UNIREF**'+ ScheduleofLosses[0].Unilateral_referral_date_passed__c);
        System.Debug('**UNIARB***'+ ScheduleofLosses[0].Unilateral_Arbitration_Overlap__c);
        
        System.Debug('**UNIAA***'+ ScheduleofLosses[0].Arbitrators_Award_Finalised__c);   
            
            Batch_SOLHandler SOLHandler = new Batch_SOLHandler();
            database.executebatch(SOLHandler ,10);
    
    test.stoptest();
    

}



}