@istest

Public class ArbitrationItemViewLightningVF_test{


Public static testmethod void ArbitrationItemViewLightningVF0(){

    test.starttest(); 
    
            //Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB1@noemail.com','ARB1');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
           
           
            Loss_Sub_Categories__c[] lossItem = [Select id From Loss_Sub_Categories__c];
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
            
            ArbitrationItemViewLightningVF_2.TestLoggedinUser='Claimant Handler';
            
            arbvf .getParameters().put('RecId',lossItem[0].id);
            arbvf .getParameters().put('Amount','200');
            Arb.LOGGEDINUSER='Claimant Handler';
            Arb.UpdateItem();
            
             
           
            
            
    test.stoptest();
    

}

Public static testmethod void ArbitrationItemViewLightningVF1(){

    test.starttest(); 
       // Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB1@noemail.com','ARB1');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
           
           
            Loss_Sub_Categories__c[] lossItem = [Select id From Loss_Sub_Categories__c];
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
            
            
            
            arbvf .getParameters().put('RecId',lossItem[0].id);
            Arb.LOGGEDINUSER='Claimant Handler';
            
            Arb.InitateRationale();            
            Arb.UpdateRationale();
            Arb.ReferAllItems();
             
           
            
            
    test.stoptest();
    

}


Public static testmethod void ArbitrationItemViewLightningVF2(){

    test.starttest();
        //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
         //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
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
            Arb.CancelReferItem();
            
            
    test.stoptest();
    

}

Public static testmethod void ArbitrationItemViewLightningVF3(){

    test.starttest();
        //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
         //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
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
            Arb.AcceptArbitration();
            Arb.DeclineArbitration();
            
            
    test.stoptest();
    

}



Public static testmethod void ArbitrationItemViewLightningVF4(){

    test.starttest();
        //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
         //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
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
            
            
            Schedule_of_Losses__c[] ScheduleofLosses = [Select id from Schedule_of_Losses__c]; 
            arbvf .getParameters().put('ShedId',ScheduleofLosses[0].id);
            Arb.SubmitItems();
            
            
    test.stoptest();
    

}
Public static testmethod void ArbitrationItemViewLightningVF5(){

    test.starttest();
          // Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
               
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
          
            
            Loss_Sub_Categories__c[] lossItem = [Select id From Loss_Sub_Categories__c];
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
            
            
            arbvf .getParameters().put('RecId',lossItem[0].id);
            Arb.LOGGEDINUSER='Defendant Handler';
            Arb.ReferItem();
            
            
            Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c from Schedule_of_Losses__c];
            ScheduleofLosses[0].Defendant_Arbitration_Submitted__c=true;
            ScheduleofLosses[0].Claimaint_Arbitration_Submitted__c=true;
            update ScheduleofLosses;
              
            arbvf .getParameters().put('ShedId',ScheduleofLosses[0].id);
            Arb.SubmitItems();
            
            
    test.stoptest();
    

}

Public static testmethod void ArbitrationItemViewLightningVF4B(){

    test.starttest();
        //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
         //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
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
            
            
            Schedule_of_Losses__c[] ScheduleofLosses = [Select id from Schedule_of_Losses__c]; 
            arbvf .getParameters().put('ShedId',ScheduleofLosses[0].id);
            Arb.ConfirmDocumentUpload();
            
            
    test.stoptest();
    

}
Public static testmethod void ArbitrationItemViewLightningVF5b(){

    test.starttest();
          // Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
               
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
          
            
            Loss_Sub_Categories__c[] lossItem = [Select id From Loss_Sub_Categories__c];
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
            
            
            arbvf .getParameters().put('RecId',lossItem[0].id);
            Arb.LOGGEDINUSER='Defendant Handler';
            Arb.ReferItem();
            
            
            Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Defendant_Confirm_Documents_uploaded__c,Claimant_Confirm_Documents_Uploaded__c from Schedule_of_Losses__c];
            ScheduleofLosses[0].Claimant_Confirm_Documents_Uploaded__c=true;
            ScheduleofLosses[0].Defendant_Confirm_Documents_uploaded__c=true;
            update ScheduleofLosses;
              
            arbvf .getParameters().put('ShedId',ScheduleofLosses[0].id);
            Arb.ConfirmDocumentUpload();
           
            
            
    test.stoptest();
    

}

Public static testmethod void ArbitrationItemViewLightningVF5c(){

    test.starttest();
          // Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
               
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
          
            
            Loss_Sub_Categories__c[] lossItem = [Select id From Loss_Sub_Categories__c];
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
            
            
            arbvf .getParameters().put('RecId',lossItem[0].id);
            Arb.LOGGEDINUSER='Defendant Handler';
            Arb.ReferItem();
            
            
            Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Defendant_Confirm_Documents_uploaded__c,Claimant_Confirm_Documents_Uploaded__c from Schedule_of_Losses__c];
            ScheduleofLosses[0].Claimant_Confirm_Documents_Uploaded__c=true;
            ScheduleofLosses[0].Defendant_Confirm_Documents_uploaded__c=true;
            update ScheduleofLosses;
              
            arbvf .getParameters().put('ShedId',ScheduleofLosses[0].id);
           
            Arb.DocumentRefresh();
            
            
    test.stoptest();
    

}




Public static testmethod void ArbitrationItemViewLightningVF6(){

    test.starttest();
          // Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
               
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
            
            
            Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Defendant_Final_Offer_Confirmed__c,Claimant_Final_Offer_Confirmed__c from Schedule_of_Losses__c];
            ScheduleofLosses[0].Defendant_Final_Offer_Confirmed__c=true;
            ScheduleofLosses[0].Claimant_Final_Offer_Confirmed__c=true;
            update ScheduleofLosses;
              
            arbvf .getParameters().put('ShedId',ScheduleofLosses[0].id);
            Arb.ShowSubmitAward();
            
            
    test.stoptest();
    

}


Public static testmethod void ArbitrationItemViewLightningVF7(){

    test.starttest();
         //  Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
               
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
          
            
            Loss_Sub_Categories__c[] lossItem = [Select id From Loss_Sub_Categories__c];
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
            
            
            arbvf .getParameters().put('RecId',lossItem[0].id);
            Arb.LOGGEDINUSER='Defendant Handler';
            Arb.ReferItem();
            
            
            Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c from Schedule_of_Losses__c];
            ScheduleofLosses[0].Defendant_Final_Offer_Confirmed__c=true;
            ScheduleofLosses[0].Claimant_Final_Offer_Confirmed__c=true;
            update ScheduleofLosses;
              
            arbvf .getParameters().put('ShedId',ScheduleofLosses[0].id);
             Arb.ShowSubmitAward();
            
            
    test.stoptest();
    

}

Public static testmethod void ArbitrationItemViewLightningVF8(){

    test.starttest();
         //  Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
               
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            TestDateghostDraft.Setup();  
            
            Case cs = [Select id from Case limit 1];
          
            
            Loss_Sub_Categories__c[] lossItem = [Select id From Loss_Sub_Categories__c];
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            ArbitrationItemViewLightningVF_2.TestLoggedinUser='Arbitrator';
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
            
            
            arbvf .getParameters().put('RecId',lossItem[0].id);
            Arb.LOGGEDINUSER='Defendant Handler';
            Arb.ReferItem();
            
            
            Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c from Schedule_of_Losses__c];
            ScheduleofLosses[0].Defendant_Final_Offer_Confirmed__c=true;
            ScheduleofLosses[0].Claimant_Final_Offer_Confirmed__c=true;
            update ScheduleofLosses;
              
            arbvf .getParameters().put('ShedId',ScheduleofLosses[0].id);
             Arb.ShowArbitratorsAward();
            
            
    test.stoptest();
    

}

Public static testmethod void ArbitrationItemViewLightningVF9(){

    test.starttest();
         //  Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
               
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
          
            
            Merit__c[] Merit = [Select id From Merit__c];
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            ArbitrationItemViewLightningVF_2.TestLoggedinUser='Arbitrator';
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
            
            
            arbvf .getParameters().put('RecId',Merit[0].id);
            arbvf .getParameters().put('MerPerc','85');
            Arb.LOGGEDINUSER='Defendant Handler';
            Arb.UpdateMerit();
            
            
           
            
            
    test.stoptest();
    

}
Public static testmethod void ArbitrationItemViewLightningVF10(){

    test.starttest();
           //Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
               
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
          
            
            Merit__c[] Merit = [Select id From Merit__c];
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            ArbitrationItemViewLightningVF_2.TestLoggedinUser='Arbitrator';
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
            
            
            arbvf .getParameters().put('RecId',Merit[0].id);
            arbvf .getParameters().put('MerPerc','85');
            Arb.LOGGEDINUSER='Defendant Handler';
            Arb.ReferMerit();
            Arb.CancelReferMerit();
                    
    test.stoptest();
    

}

Public static testmethod void ArbitrationItemViewLightningVF11(){

    test.starttest();
          // Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
               
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
          
            
            Merit__c[] Merit = [Select id From Merit__c];
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            ArbitrationItemViewLightningVF_2.TestLoggedinUser='Arbitrator';
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
            
            
            arbvf .getParameters().put('RecId',Merit[0].id);
            arbvf .getParameters().put('MerPerc','85');
            Arb.LOGGEDINUSER='Defendant Handler';
            Arb.ReferMerit();
            Arb.DeclineMeritArbitration();
                    
    test.stoptest();
    

}
Public static testmethod void ArbitrationItemViewLightningVF12(){

    test.starttest();
           //Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
               
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
          
            
            Merit__c[] Merit = [Select id From Merit__c];
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            ArbitrationItemViewLightningVF_2.TestLoggedinUser='Arbitrator';
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
            
            
            arbvf .getParameters().put('RecId',Merit[0].id);
            arbvf .getParameters().put('MerPerc','85');
            Arb.LOGGEDINUSER='Defendant Handler';
            Arb.ReferMerit();
            Arb.AcceptMeritArbitration();
                    
    test.stoptest();
    

}

Public static testmethod void ArbitrationItemViewLightningVF13(){

    test.starttest();
           //Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
               
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
          
            
            
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            ArbitrationItemViewLightningVF_2.TestLoggedinUser='Arbitrator';
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
           
            Arb.LOGGEDINUSER='Defendant Handler';
            Arb.SaveAllFilesSelection();
            
                    
    test.stoptest();
    

}

Public static testmethod void ArbitrationItemViewLightningVF14(){

    test.starttest();
         //  Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPARB2@noemail.com','ARB2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
               
            Test_SetUpCaseProtocol_4.testCreateProtocol();
            
            TestDateghostDraft.Setup();
            
            Case cs = [Select id from Case limit 1];
          
            
            
            
            PageReference arbvf = Page.ArbitrationItemsList2;  
            arbvf .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(arbvf);
            ArbitrationItemViewLightningVF_2.TestLoggedinUser='Arbitrator';
            
            ArbitrationItemViewLightningVF_2 Arb = new ArbitrationItemViewLightningVF_2();
           
            Arb.LOGGEDINUSER='Defendant Handler';
            Arb.showAwardDocument();
            Arb.displayArbitrationAwardDoc();
                    
    test.stoptest();
    

}


}