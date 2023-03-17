@istest

Public class CaseTeamListController_test{


Public static testmethod void AddArbitratorTeam1(){

    test.starttest();
    
        Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
        Test_SetUpCaseProtocol_2.testCreateProtocol();
        Case[] cs = [Select id from Case];
        
        CaseTeamListController.getCaseTeamMembers(cs[0].id);
        
    test.stoptest();
    

}



}