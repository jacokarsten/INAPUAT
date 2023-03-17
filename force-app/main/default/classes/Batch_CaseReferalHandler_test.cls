@istest

Public class Batch_CaseReferalHandler_test{


Public static testmethod void CaseReferalHandler1(){

    test.starttest();
      Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_SetUpCaseProtocol_1.testCreateProtocol();
           
              TestDateghostDraft.Setup();   
              
            Case cs = [Select id,Stage__c from Case limit 1];
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
            
            User[] UOwner = [Select id from User where (Profile.Name = 'System Administrator' OR Profile.Name = 'Market Maker') AND Isactive=:true ];
            Quick.CaseQuick.OwnerId =  UOwner[0].id;
            Quick.CaseQuick.status='Referred';
            Update Quick.CaseQuick;
            
          
            
            Quick.AcceptReject();
            system.debug('**CaseSTage**'+Quick.CaseQuick.Stage__c);
           
            
            
            Batch_CaseReferalHandler updateReferal = new Batch_CaseReferalHandler();
            String sch = '20 35 8 10 2 ?';
            system.schedule('Sequence Job Test Submit Order', sch, updateReferal);
    
    test.stoptest();
    

}



}