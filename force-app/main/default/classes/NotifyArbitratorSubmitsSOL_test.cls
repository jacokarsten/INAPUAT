@istest

Public class NotifyArbitratorSubmitsSOL_test{


Public static testmethod void NotifyArbitratorSubmitsSOL1(){

    test.starttest();
           //  Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            Test_SetUpCaseProtocol_3.testCreateProtocol();
            
            List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,Arbitrators_Award_Finalised__c, Invite_Arbitrator__c From Schedule_of_Losses__c]);
         
         
           ScheduleofLosses[0].Arbitrators_Award_Finalised__c = true;
           update ScheduleofLosses;
           
           ScheduleofLosses[0].Invite_Arbitrator__c=true;           
           update ScheduleofLosses;
    
    test.stoptest();
    

}



}