@istest

Public class RemoveSupervisorBulk_test{


Public static testmethod void RemoveSupervisorBulk1(){

    test.starttest();
    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPSOL1@noemail.com','SOL1');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            
           Contact[] supervisor = [Select id,Status__c from Contact where Role__c = 'Supervisor' limit 1];
            
            supervisor[0].Status__c = 'Inactive';
            update supervisor;
    
    test.stoptest();
    

}



}