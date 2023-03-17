Public Class CaseCommentUtility{
@InvocableMethod

Public static void SetCaseCommentSharing (List<ID> ids){
      System.Debug ('## SetCaseCommentSharing ##');  
      Set<Id> CaseArbitratorSetIds = new Set<Id>();
      Set<Id> CaseFacilitorSetIds = new Set<Id>();
      Set<Id> CaseArbitratorRemoveSetIds = new Set<Id>();
      Set<Id> CaseFacilitorRemoveSetIds = new Set<Id>();
      Set<Id> CaseTeamMemberIds = new Set<Id>();
      Set<Id> CaseTeamMemberRemoveIds = new Set<Id>();
      Set<id> CaseCommentShareRemoveIds = new Set<id>();
      Map<Id, Id> CaseCommentMap = New Map<id, Id>();
      Map <Id, Id> CaseTeamMemberMap = new Map<id, Id>();
       
      List<Case_Comment__Share > CaseCommentShareList = new List<Case_Comment__Share>();
      List<Case_Comment__Share > CaseCommentShareRemoveList = new List<Case_Comment__Share>();
      Set<id> CaseIdSet = new Set<id>();
      
      For (Case_Comment__c cc: [SELECT Case__c,Id,Share_with_Arbitrator__c,Share_with_Facilitor__c FROM Case_Comment__c where id = :ids]){       
          If (cc.Share_with_Arbitrator__c == true){
            CaseArbitratorSetIds.add(cc.Case__c);
            System.debug('#&# CaseArbitratorSetIds.add ' + cc.Case__c + ' #$#');
            
          }
          If (cc.Share_with_Arbitrator__c == false){
            CaseArbitratorRemoveSetIds.add(cc.Case__c);
            System.debug('#&# CaseArbitratorRemoveSetIds.add ' + cc.Case__c + ' #$#');
            
          }
          If (cc.Share_with_Facilitor__c == true){
             CaseFacilitorSetids.add(cc.Case__c);
          }
          If (cc.Share_with_Facilitor__c == False){
             CaseFacilitorRemoveSetids.add(cc.Case__c);
          }
          if (!CaseIdSet.contains(cc.Case__c)){
              CaseIdSet.add(cc.Case__c);
          }      
          CaseCommentMap.put(cc.id, cc.Case__C); 
      }
     
     List<CaseTeamMember > ctmList = [SELECT Id,MemberId,ParentId,TeamRole.name FROM CaseTeamMember where Parentid =: CaseIdSet]; 
     for (CaseTeamMember ctm : ctmlist){   
          CaseTeamMemberMap.put(ctm.memberid, ctm.ParentId);  
     }
     for (id ccId : CaseCommentMap.keyset()){
         String Caseid = CaseCommentMap.get(ccid);
         for (CaseTeamMember ctm : ctmList){
            if (ctm.parentid == caseid){
                System.debug('#&# TEAM ROLE ' + ctm.Teamrole.name + ' , ' + caseid + ' #$#');
                if (ctm.Teamrole.name == 'Arbitrator' && CaseArbitratorSetIds.contains(caseid)){
                   System.debug('#&# Case Comment Share ARBITRATOR  ' + ccid + ' #$#');
            
                    Case_Comment__Share caseCommentShare = new Case_Comment__Share();
                    caseCommentShare.ParentId  = ccid;
                    caseCommentShare.UserOrGroupId = ctm.Memberid; 
                    caseCommentShare.AccessLevel = 'Read';
                    caseCommentShare.RowCause = Schema.Case_Comment__Share.RowCause.Manual;
                    CaseCommentShareList.add(caseCommentShare );  
                 }   
                 if (ctm.TeamRole.name == 'Facilitator' && CaseFacilitorSetIds.contains(caseid)){
                     System.debug('#&# Case Comment Share facilitator  ' + ccid + ' #$#');
                    Case_Comment__Share caseCommentShare = new Case_Comment__Share();
                    caseCommentShare.ParentId  = ccid;
                    caseCommentShare.UserOrGroupId = ctm.Memberid; 
                    caseCommentShare.AccessLevel = 'Read';
                    caseCommentShare.RowCause = Schema.Case_Comment__Share.RowCause.Manual;
                    CaseCommentShareList.add(caseCommentShare ); 
                  }
                  if (ctm.Teamrole.name == 'Arbitrator'  && CaseArbitratorRemoveSetIds.contains(caseid)){
                     System.debug('#&# REMOVE Arbitrator Case Comment Share ' + ccid + ' #$#');
                     CaseCommentShareRemoveIds.add(ccid);
                     if (!CaseTeamMemberRemoveIds.contains(ctm.Memberid)){
                        CaseTeamMemberRemoveIds.add (ctm.MemberId);
                     }         
                  } 
                  if (ctm.TeamRole.name == 'Facilitator' && CaseFacilitorRemoveSetids.contains(caseid)){
                     System.debug('#&# REMOVE Facilitor Case Comment Share ' + ccid + ' #$#');
                     CaseCommentShareRemoveIds.add(ccid);
                     if (!CaseTeamMemberRemoveIds.contains(ctm.Memberid)){
                        CaseTeamMemberRemoveIds.add (ctm.MemberId);
                     }         
                  } 
                    
                  if (ctm.Teamrole.Name == 'Defendant Handler' || ctm.Teamrole.Name == 'Defendant Supervisor' || ctm.Teamrole.name  == 'Claimant Supervisor' || ctm.Teamrole.name  == 'Claimant Handler'){
                     System.debug('#&# DEFAULT Case Comment Share  ' + ccid + ' #$#');
                    Case_Comment__Share caseCommentShare = new Case_Comment__Share();
                    caseCommentShare.ParentId  = ccid;
                    caseCommentShare.UserOrGroupId = ctm.Memberid; 
                    caseCommentShare.AccessLevel = 'Read';
                    caseCommentShare.RowCause = Schema.Case_Comment__Share.RowCause.Manual;
                    CaseCommentShareList.add(caseCommentShare ); 
                 }     
            }        
         }    
     }
     
     /* Add Case Share Rules */
     Database.SaveResult[] srList = Database.insert(CaseCommentShareList,false);
     for (Database.SaveResult sr : srList) {
        if (sr.isSuccess()) {
            // Operation was successful, so get the ID of the record that was processed
            System.debug('Successfully inserted account. Account ID: ' + sr.getId());
        }
      else {
            // Operation failed, so get all errors               
            for(Database.Error err : sr.getErrors()) {
                System.debug('The following error has occurred.');                   
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                System.debug('Account fields that affected this error: ' + err.getFields());
            }
      }
      /* Remove Arbitor Case Share Rules */
      List <Case_Comment__Share> CaseCommentShareRemove = [SELECT id from Case_Comment__Share where UserOrGroupId in: CaseTeamMemberRemoveIds and ParentId in: CaseCommentShareRemoveIds];
      delete CaseCommentShareRemove;
   
      
      
  }
}

}