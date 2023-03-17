@istest

Public class LossItemViewLightningVF_test{


Public static testmethod void LossItemViewLightning1(){

    test.starttest();
         //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPSOL1@noemail.com','SOL1');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            Test_SetUpCaseProtocol_2.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
            PageReference lossitem = Page.LossitemsCategories;  
            lossitem .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(lossitem);
            
            
            LossItemViewLightningVF SOL  = new LossItemViewLightningVF();
            SOL.LOGGEDINUSER = 'Defendant Handler';
            
            Loss_Category__c[] LossCategory = [Select id,Case__c,Head_of_Loss_Type__c,Schedule_of_Losses__c,RecordType.DeveloperName from Loss_Category__c where Head_of_Loss_Type__c = 'Past Financial Losses'];
            lossitem .getParameters().put('RecId',LossCategory[0].id);
            SOL.NewItem(); 
            SOL.NewLossItem.Loss_Type__c='Other Losses';
            lossitem .getParameters().put('Amount','500');
            SOL.SaveItem();
            
            
            lossitem .getParameters().put('RecId',SOL.NewLossItem.id);
            SOL.UpdateItem();
            
            SOL.InitateRationale();
            SOL.UpdateRationale();
            
            
            
           
    
    test.stoptest();
    

}

Public static testmethod void LossItemViewLightning2(){

    test.starttest();
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPSOL1@noemail.com','SOL1');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            Test_SetUpCaseProtocol_2.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
            PageReference lossitem = Page.LossitemsCategories;  
            lossitem .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(lossitem);
            
            
            LossItemViewLightningVF SOL  = new LossItemViewLightningVF();
            
            SOL.LOGGEDINUSER = 'Defendant Handler';
            
            Loss_Category__c[] LossCategory = [Select id,Case__c,Head_of_Loss_Type__c,Schedule_of_Losses__c,RecordType.DeveloperName from Loss_Category__c where Head_of_Loss_Type__c = 'Past Financial Losses'];
            lossitem .getParameters().put('RecId',LossCategory[0].id);
            SOL.NewItem(); 
            SOL.NewLossItem.Loss_Type__c='Other Losses';
            lossitem .getParameters().put('Amount','500');
            SOL.SaveItem();
            
            
            lossitem .getParameters().put('RecId',SOL.NewLossItem.id);
            SOL.UpdateItem();
            
            SOL.InitateInterest();
            SOL.StartDate = '2019-10-10';
            SOL.UpdateInterest();
            SOL.RemoveInterest();
            
           
    
    test.stoptest();
    

}



Public static testmethod void LossItemViewLightning3(){

    test.starttest();
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPSOL1@noemail.com','SOL1');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            Test_SetUpCaseProtocol_2.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
            PageReference lossitem = Page.LossitemsCategories;  
            lossitem .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(lossitem);
            
            
            LossItemViewLightningVF SOL  = new LossItemViewLightningVF();
            SOL.LOGGEDINUSER = 'Defendant Handler';
            
            Loss_Category__c[] LossCategory = [Select id,Case__c,Head_of_Loss_Type__c,Schedule_of_Losses__c,RecordType.DeveloperName from Loss_Category__c where Head_of_Loss_Type__c = 'Past Financial Losses'];
            lossitem .getParameters().put('RecId',LossCategory[0].id);
            SOL.NewItem(); 
            SOL.NewLossItem.Loss_Type__c='Other Losses';
            lossitem .getParameters().put('Amount','500');
            SOL.SaveItem();
           
            
            LossCategory = [Select id,Case__c,Head_of_Loss_Type__c,Schedule_of_Losses__c,RecordType.DeveloperName from Loss_Category__c where Head_of_Loss_Type__c = 'Pain, Suffering & Loss of Amenities'];
            lossitem .getParameters().put('RecId',LossCategory[0].id);
            SOL.NewCode();
            SOL.SaveCode();
            
    
    test.stoptest();
    

}



Public static testmethod void LossItemViewLightning4(){

    test.starttest();
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPSOL2@noemail.com','SOL2');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            Test_SetUpCaseProtocol_2.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
            PageReference lossitem = Page.LossitemsCategories;  
            lossitem .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(lossitem);
            
            
            LossItemViewLightningVF SOL  = new LossItemViewLightningVF();
            SOL.LOGGEDINUSER = 'Defendant Handler';
            
            Loss_Category__c[] LossCategory = [Select id,Case__c,Head_of_Loss_Type__c,Schedule_of_Losses__c,RecordType.DeveloperName from Loss_Category__c where Head_of_Loss_Type__c = 'Past Financial Losses'];
            lossitem .getParameters().put('RecId',LossCategory[0].id);
            SOL.NewItem(); 
            SOL.NewLossItem.Loss_Type__c='Other Losses';
            lossitem .getParameters().put('Amount','500');
            SOL.SaveItem();
            SOL.populateCaseFiles();
            SOL.SaveCaseFilesSelection();
            
            
    
    test.stoptest();
    

}

Public static testmethod void LossItemViewLightning5(){

    test.starttest();
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPSOL3@noemail.com','SOL3');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            Test_SetUpCaseProtocol_2.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
            PageReference lossitem = Page.LossitemsCategories;  
            lossitem .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(lossitem);
            
            
            LossItemViewLightningVF SOL  = new LossItemViewLightningVF();
            SOL.LOGGEDINUSER = 'Defendant Handler';
            
            List<Merit__c> lstMerit = new List<Merit__c>([Select id,Defendant_Position__c,Arbitration_Referred_By__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c limit 1]);

            
            lossitem .getParameters().put('RecId',lstMerit[0].id);
            lossitem .getParameters().put('MerPerc','90');
           
            SOL.UpdateMerit(); 
      
    test.stoptest();
    

}






}