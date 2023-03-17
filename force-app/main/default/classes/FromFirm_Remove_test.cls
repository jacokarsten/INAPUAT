@istest

Public class FromFirm_Remove_test{


Public static testmethod void FromFirmDeactivate1(){

    test.starttest();
    
    Test_InsertFirm_Contact_Team_TeamRole.testCreateAccount ();
       StatusChangeHandler.STATUSCHANGETRIGGER = false;
       Account[] Firm = [Select id from Account];
       Firm[0].Status__c ='Removed';
       Update Firm;
    test.stoptest();
    

}



}