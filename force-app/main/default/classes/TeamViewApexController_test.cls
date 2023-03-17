@istest

Public class TeamViewApexController_test{


Public static testmethod void TeamViewApexControllertest(){

    test.starttest();
    
        Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
        Test_SetUpCaseProtocol_2.testCreateProtocol();
         
         
        User[] user1 = [Select id From User where username='handler4@testINAP.com']; 
    
    
     
    System.runAs(user1[0]) {
             TeamViewApexController.getFirmTeamRoles();
    }
    
    
   
        
        
        
    test.stoptest();
 }   

}