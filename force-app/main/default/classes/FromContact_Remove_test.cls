@istest

Public class FromContact_Remove_test{


Public static testmethod void FromContactRemove1(){

    test.starttest();
     Test_InsertFirm_Contact_Team_TeamRole.testCreateAccount ();
     StatusChangeHandler.STATUSCHANGETRIGGER = false;
    Contact[] lstContact = [Select id,Status__c From Contact];     
       lstContact[0].Status__c ='Removed';
       Update lstContact;
       
    
    test.stoptest();
    

}



}