@istest

Public class FromFirm_Activate_test{


Public static testmethod void FromFirmActivate1(){

    test.starttest();
     Test_InsertFirm_Contact_Team_TeamRole.testCreateAccount ();
       StatusChangeHandler.STATUSCHANGETRIGGER = false;
       Account[] Firm = [Select id from Account];
       Firm[0].Status__c ='Inactive';
       Update Firm;
       
       Firm[0].Status__c ='Active';
       Update Firm;
    
    test.stoptest();
    

}



}