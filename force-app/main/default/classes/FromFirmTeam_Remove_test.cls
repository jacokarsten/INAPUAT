@istest

Public class FromFirmTeam_Remove_test{


Public static testmethod void FromFirmTeamRemove1(){

    test.starttest();
     Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPSOL1@noemail.com','SOL1');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
       StatusChangeHandler.STATUSCHANGETRIGGER = false;
       Firm_Team__c[] lstFirmTeam = [Select id,Active_Case_Count__c from Firm_Team__c ];    
       lstFirmTeam[0].Status__c ='Removed';
       Update lstFirmTeam;
    
    test.stoptest();
    

}



}