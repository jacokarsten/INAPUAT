@istest

Public class NotifyClaimantTeamAcceptDeclineSOL_test{


Public static testmethod void NotifyClaimantTeamAcceptDeclineSOL1(){

    test.starttest();
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();            
                       
            Test_SetUpCaseProtocol_2.testCreateProtocol();
                       
            Schedule_of_Losses__c[] ScheduleLosses = [Select id,Defendant_Arbitration_Submitted__c,Case__c From Schedule_of_Losses__c];
            
            ScheduleLosses[0].Defendant_Arbitration_Submitted__c =  true;
            
            update ScheduleLosses;
            
    test.stoptest();
    

}



}