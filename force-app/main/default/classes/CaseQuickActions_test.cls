@istest

Public class CaseQuickActions_test{

Public static testmethod void CaseQuickActions0(){
        test.starttest();
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPQUICK1@noemail.com','quik1');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            User[] user1 = [Select id From User where username='handler1@testINAP.com']; 
   
            System.runAs(user1[0]) {
                  Test_SetUpCaseProtocol_1.testCreateProtocol();
            }
            
     test.stoptest();       
}

Public static testmethod void CaseQuickActions1(){

    test.starttest();
            
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPQUICK1@noemail.com','quik1');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_SetUpCaseProtocol_1.testCreateProtocol();
           
           
            Case cs = [Select id from Case limit 1];
            PageReference QuickActions = Page.QuickActionsCase;  
            QuickActions .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(QuickActions);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(cs);
            CaseQuickActions Quick  = new CaseQuickActions(sc);
            
            
            Account[] FirmCl = [Select id from Account where Name = 'Legalsmiths'];
            Quick.CaseQuick.ClaimantFirm__c = FirmCl[0].id;
            Update Quick.CaseQuick;
            
             
             Account[] FirmDef = [Select id from Account where Name = 'Insuresmiths'];
             Quick.CaseQuick.Defendant_Firm__c = FirmDef[0].id; 
             Quick.CaseQuick.Subject = 'Test';
                                   
             Quick.addDefendentFirm();
            
         
            Quick.ShowFirmTeamsClaimant();
            Firm_Team__c[] testCl = [Select Firm__c From Firm_Team__c where Firm__c=:FirmCl[0].id];
            Quick.ClaimFirm = testCl[0].id;
            Quick.updateClaimTeam();
            
            
            Quick.ShowFirmTeamsDefendant();
            Firm_Team__c[] testDef = [Select Firm__c From Firm_Team__c where Firm__c=:FirmDef[0].id];
            Quick.DefFirm = testDef[0].id;
            
            Quick.updateDefTeam();
            
           /* 
            Quick.updaterefer();
            system.debug('**CASEREFER**'+Quick.CaseQuick.Status);
            
            Quick.CaseQuick.Defendant_Accept_Reject__c='Accept';
            Quick.CaseQuick.Defendant_Agree_to_Arbitration_Process__c=true;
            Quick.AcceptReject();
           */ 
           
            
            
            
    test.stoptest();
    

}

Public static testmethod void CaseQuickActions1a(){

    test.starttest();
            
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPQUICK1@noemail.com','quik1');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_SetUpCaseProtocol_1.testCreateProtocol();
           
              TestDateghostDraft.Setup();   
              
            Case cs = [Select id from Case limit 1];
            PageReference QuickActions = Page.QuickActionsCase;  
            QuickActions .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(QuickActions);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(cs);
            CaseQuickActions Quick  = new CaseQuickActions(sc);
            
            
            Account[] FirmCl = [Select id from Account where Name = 'Legalsmiths'];
            Quick.CaseQuick.ClaimantFirm__c = FirmCl[0].id;
         
        
             Account[] FirmDef = [Select id from Account where Name = 'Insuresmiths'];
             Quick.CaseQuick.Defendant_Firm__c = FirmDef[0].id; 
             Quick.CaseQuick.Subject = 'Test';
                                   
          
            Firm_Team__c[] testCl = [Select Firm__c From Firm_Team__c where Firm__c=:FirmCl[0].id];
            Quick.CaseQuick.Claimant_Firm_Team__c = testCl[0].id;
         
         
            Firm_Team__c[] testDef = [Select Firm__c From Firm_Team__c where Firm__c=:FirmDef[0].id];
            Quick.CaseQuick.Defendant_Firm_Team__c = testDef[0].id;
            Quick.CaseQuick.Defendant_Accept_Reject__c='Accept';
            Quick.CaseQuick.Defendant_Agree_to_Arbitration_Process__c=true;
            
            Update Quick.CaseQuick;
            
          
            Quick.updaterefer();
            system.debug('**CASEREFER**'+Quick.CaseQuick.Status);
            
            
           
            
            
            
    test.stoptest();
    

}

Public static testmethod void CaseQuickActions2(){

    test.starttest();
            //Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPQUICK2@noemail.com','quik2');
            
            //Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            //Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            //Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            Test_InsertFirm_Contact_Team_TeamRole_2.insertContactUser();
            Test_SetUpCaseProtocol_2a.testCreateProtocol();
            
            Case cs = [Select id from Case limit 1];
            PageReference QuickActions = Page.QuickActionsCase;  
            QuickActions .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(QuickActions);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(cs);
            
            CaseQuickActions Quick  = new CaseQuickActions(sc);
            
            
            
            
            Account[] FirmFac = [Select id from Account where Name = 'Facilitate'];
            
            Quick.CaseQuick.Facilitator_Firm__c=FirmFac[0].id; 
            Quick.Facilitator();
            
            Contact[] Facilitator = [Select id from Contact where Role__c = 'Facilitator'];            
            Quick.FacCon = Facilitator[0].id;            
            Quick.CaseQuick.Facilitator_Contact__c = Quick.FacCon;            
            
            Quick.updateFacCon();
            
           
            
            
            Quick.ShowActions();
            Quick.HideActions();
            
            Quick.AgreeArbitration();
            Quick.ClaimantSubmitSOL();
             
            Quick.ClaimantFinalise();
           
            
            
            
            
            
    test.stoptest();
    

}
Public static testmethod void CaseQuickActions2aa(){

    test.starttest();
            //Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPQUICK2@noemail.com','quik2');
            
            //Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            //Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            //Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            Test_InsertFirm_Contact_Team_TeamRole_2.insertContactUser();
            Test_SetUpCaseProtocol_2a.testCreateProtocol();
            
            
            TestDateghostDraft.Setup();
            
            Case cs = [Select id from Case limit 1];
            PageReference QuickActions = Page.QuickActionsCase;  
            QuickActions .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(QuickActions);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(cs);
            
            CaseQuickActions Quick  = new CaseQuickActions(sc);
         
            
            Account[] FirmArb = [Select id from Account where Name = 'Arbitrator'];
            Quick.CaseQuick.Arbitration_Firm__c = FirmArb[0].id;
            Quick.Arbitrator();
            
            Contact[] Arbitrator = [Select id from Contact where Role__c = 'Arbitrator'];            
            Quick.ArbCon = Arbitrator[0].id;            
            Quick.CaseQuick.Arbitrator_Contact__c = Quick.ArbCon;
            Quick.updateArbCon(); 
            
       
            Quick.CaseQuick.Arbitrator_Accept_Decline__c='Accept';
            Update Quick.CaseQuick;
            Quick.AcceptReject();
            
            
            
            
    test.stoptest();
    

}

Public static testmethod void CaseQuickActions2a(){

    test.starttest();
            
            
           // Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPQUICK1@noemail.com','quik1');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_SetUpCaseProtocol_1.testCreateProtocol();
           
              TestDateghostDraft.Setup();   
              
            Case cs = [Select id from Case limit 1];
            PageReference QuickActions = Page.QuickActionsCase;  
            QuickActions .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(QuickActions);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(cs);
            CaseQuickActions Quick  = new CaseQuickActions(sc);
            
            
            Account[] FirmCl = [Select id from Account where Name = 'Legalsmiths'];
            Quick.CaseQuick.ClaimantFirm__c = FirmCl[0].id;
         
        
             Account[] FirmDef = [Select id from Account where Name = 'Insuresmiths'];
             Quick.CaseQuick.Defendant_Firm__c = FirmDef[0].id; 
             Quick.CaseQuick.Subject = 'Test';
                                   
          
            Firm_Team__c[] testCl = [Select Firm__c From Firm_Team__c where Firm__c=:FirmCl[0].id];
            Quick.CaseQuick.Claimant_Firm_Team__c = testCl[0].id;
         
         
            Firm_Team__c[] testDef = [Select Firm__c From Firm_Team__c where Firm__c=:FirmDef[0].id];
            Quick.CaseQuick.Defendant_Firm_Team__c = testDef[0].id;
            
            Update Quick.CaseQuick;
            
            Quick.loadClaimant();
            Quick.UpdateClaimant();
       
            Quick.loadDefedant();
            Quick.UpdateDefendant();
            Quick.ChangeDefendentFirm();
            Quick.ChangeDefendentFirmTeam();
            Quick.updateClaim();

            Quick.ShowArbitrator();
            Quick.ShowFacilitator();
            Quick.ShowDefendant();
            Quick.ShowClaimant();

            Quick.ArbitratorReset();
            Quick.checkMinRequirements();
                     
            
            test.stoptest();
    

}

Public static testmethod void CaseQuickActions2b(){

    test.starttest();
            
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPQUICK1@noemail.com','quik1');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_SetUpCaseProtocol_1.testCreateProtocol();
           
              TestDateghostDraft.Setup();   
              
            Case cs = [Select id from Case limit 1];
            PageReference QuickActions = Page.QuickActionsCase;  
            QuickActions .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(QuickActions);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(cs);
            CaseQuickActions Quick  = new CaseQuickActions(sc);
            
            
            Account[] FirmCl = [Select id from Account where Name = 'Legalsmiths'];
            Quick.CaseQuick.ClaimantFirm__c = FirmCl[0].id;
         
        
             Account[] FirmDef = [Select id from Account where Name = 'Insuresmiths'];
             Quick.CaseQuick.Defendant_Firm__c = FirmDef[0].id; 
             Quick.CaseQuick.Subject = 'Test';
                                   
          
            Firm_Team__c[] testCl = [Select Firm__c From Firm_Team__c where Firm__c=:FirmCl[0].id];
            Quick.CaseQuick.Claimant_Firm_Team__c = testCl[0].id;
         
         
            Firm_Team__c[] testDef = [Select Firm__c From Firm_Team__c where Firm__c=:FirmDef[0].id];
            Quick.CaseQuick.Defendant_Firm_Team__c = testDef[0].id;
            Quick.CaseQuick.Defendant_Accept_Reject__c='Accept';
            Quick.CaseQuick.Defendant_Agree_to_Arbitration_Process__c=true;
            
            Update Quick.CaseQuick;
            
          
             Quick.CancelCase(); 
            system.debug('**CASEREFER**'+Quick.CaseQuick.Status);
            
            
           
            
            
            
    test.stoptest();
    

}

Public static testmethod void CaseQuickActions2c(){

    test.starttest();
            
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser('testINAPQUICK1@noemail.com','quik1');
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_SetUpCaseProtocol_1.testCreateProtocol();
           
              TestDateghostDraft.Setup();   
              
            Case cs = [Select id from Case limit 1];
            PageReference QuickActions = Page.QuickActionsCase;  
            QuickActions .getParameters().put('id',cs.id);     
            
            Test.setCurrentPageReference(QuickActions);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(cs);
            CaseQuickActions Quick  = new CaseQuickActions(sc);
            
            
            Account[] FirmCl = [Select id from Account where Name = 'Legalsmiths'];
            Quick.CaseQuick.ClaimantFirm__c = FirmCl[0].id;
         
        
             Account[] FirmDef = [Select id from Account where Name = 'Insuresmiths'];
             Quick.CaseQuick.Defendant_Firm__c = FirmDef[0].id; 
             Quick.CaseQuick.Subject = 'Test';
                                   
          
            Firm_Team__c[] testCl = [Select Firm__c From Firm_Team__c where Firm__c=:FirmCl[0].id];
            Quick.CaseQuick.Claimant_Firm_Team__c = testCl[0].id;
         
         
            Firm_Team__c[] testDef = [Select Firm__c From Firm_Team__c where Firm__c=:FirmDef[0].id];
            Quick.CaseQuick.Defendant_Firm_Team__c = testDef[0].id;
            Quick.CaseQuick.Defendant_Accept_Reject__c='Reject';
            Quick.CaseQuick.Defendant_Accept_Decline_Date__c = system.today();            
            Quick.CaseQuick.Defendent_rejection_reason__c = 'n/a';
            Quick.AcceptReject();
            
            
          
              
            system.debug('**CASEREFER**'+Quick.CaseQuick.Status);
            
            
           
            
            
            
    test.stoptest();
    

}



}