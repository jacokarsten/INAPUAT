@istest

Public class RemoveHandlerBulk_test{


Public static testmethod void RemoveHandlerBulk1(){

    test.starttest();
         //  Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            //Test_InsertFirm_Contact_Team_TeamRole.addteamRoles();
            
            Test_SetUpCaseProtocol_3.testCreateProtocol();
   
           
            
            
           List<Firm_Team_Roles__c> lst_FirmTeamRoles = [Select Contact__c,Firm_Team__c,Roles__c From Firm_Team_Roles__c  limit 1];
            
             
            delete lst_FirmTeamRoles;
            
    
    test.stoptest();
    

}



}