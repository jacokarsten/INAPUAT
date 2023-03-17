@istest

Public class Batch_CaseNotification_test{


Public static testmethod void CaseNotification1(){

    test.starttest();
           // Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
           // Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
          //  Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
          //  Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            
            Test_InsertFirm_Contact_Team_TeamRole_2.insertContactUser();
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            
            Case cs = [Select id from Case limit 1];
            
            
            Loss_Sub_Categories__c[] lossItem = [Select id From Loss_Sub_Categories__c];
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
            
            
            arbvf .getParameters().put('RecId',lossItem[0].id);
            Arb.LOGGEDINUSER='Claimant Handler';
            Arb.ReferItem();
            //Arb.CancelReferItem();
            
            Schedule_of_Losses__c[] ScheduleofLosses = [Select id from Schedule_of_Losses__c]; 
            arbvf .getParameters().put('ShedId',ScheduleofLosses[0].id);
            Arb.SubmitItems();
            
            Batch_CaseNotification updateReferal = new Batch_CaseNotification();
            database.executebatch(updateReferal ,10);
    
    test.stoptest();
    

}



}