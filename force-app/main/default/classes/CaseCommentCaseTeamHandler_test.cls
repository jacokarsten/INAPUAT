@istest

Public class CaseCommentCaseTeamHandler_test{


Public static testmethod void CaseCommentCaseTeamHandler1(){

    test.starttest();
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();                                  
            Test_SetUpCaseProtocol_2a.testCreateProtocol();
             
            Case cs = [Select id,Claimant_Firm_Team__c,Defendant_Firm_Team__c from Case limit 1];           
            
            system.debug('**CS TEAM**'+cs.Claimant_Firm_Team__c);
            
            Case_Comment__c Case_Comment = new Case_Comment__c(Case__c = cs.id,Comment__c ='Test',Share_with_Arbitrator__c = true,Share_with_Facilitor__c= true); 
            insert Case_Comment;
            
             User[] user1 = [Select id From User where username='handler4@testINAP.com']; 
    
            CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember ];  
            
            system.debug('**CS CaseTeamMember**'+CaseTeamMember);
            
           List<ID> ids = new List<ID>();
           ids.add(CaseTeamMember[0].id);
           
           CaseCommentCaseTeamHandler.AddCaseCommentSharing(ids);
           
           //Contact[] con = [Select id from Contact where email='handler4@testINAP.com']; 
            
            CaseCommentCaseTeamHandler.RemoveCaseCommentSharing(ids);
            
    test.stoptest();
    

}



}