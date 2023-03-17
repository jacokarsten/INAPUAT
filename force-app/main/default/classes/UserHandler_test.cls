@istest

Public class UserHandler_test{


Public static testmethod void UserHandler1(){

    test.starttest();
        Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPUSR1@noemail.com','USR1');
       
       StatusChangeHandler.STATUSCHANGETRIGGER = true;
       /*
       Contact[] lstContact = [Select id,Status__c From Contact];     
       lstContact[0].Status__c ='Inactive';
       Update lstContact;
       */
       User thisUser = [ select Id from User where username=:'sys@noemail.com' ];
       
       User[] lstUser = [Select id,IsActive From User where lastname='Testing'];
       System.runAs ( thisUser ) { 
           lstUser[0].IsActive = false;
           update lstUser;
       } 
    test.stoptest();
    

}



}