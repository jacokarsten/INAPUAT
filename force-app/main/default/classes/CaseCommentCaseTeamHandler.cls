Public Class CaseCommentCaseTeamHandler{
@InvocableMethod

  Public static void RemoveCaseCommentSharing (List<Id> ids){
    Set<Id> CaseTeamMemberIds = new Set<Id>();
    List<Case_Comment__Share > CaseCommentShareRemoveList = new List<Case_Comment__Share>();
   
    
    List<CaseTeamMember > ctmList = [SELECT Id,MemberId,ParentId,TeamRole.name FROM CaseTeamMember where Parentid =: Ids]; 
    for (CaseTeamMember ctm : ctmlist){ 
        if (!CaseTeamMemberIds.contains (ctm.MemberId) ){
           CaseTeamMemberIds.add(ctm.MemberId);
        }
     }
     
     for (Case_Comment__Share caseCommentShare  : [Select id from Case_Comment__Share where UserOrGroupId In :CaseTeamMemberIds]){
        CaseCommentShareRemoveList.add(caseCommentShare);  
     } 
     
     if (CaseCommentShareRemoveList.size()> 0 ){   
        delete CaseCommentShareRemoveList;
     }
                    
      
  
  }
  

@future
  Public static void AddCaseCommentSharing (List<ID> ids){
    Set<Id> CaseTeamMemberIds = new Set<Id>();
    Set<Id> CaseTeamMemberArbitratorIds = new Set<Id>();
    Set<Id> CaseTeamMemberFacilitatorids = new Set<Id>();
    Set<id> CaseTeamParentids = new Set<id>();
    Set<id> CaseIds = new Set<id>();
    Set<id> CaseCommentIds = new Set<id>();
    List<Case_Comment__Share > CaseCommentShareList = new List<Case_Comment__Share>();
    List<Case_Comment__Share > CaseCommentShareRemoveList = new List<Case_Comment__Share>();
    Map<id, id> CaseTeamMemberMap = new Map<id, id>();
      
    
    List<CaseTeamMember > ctmList = [SELECT Id,MemberId,ParentId,TeamRole.name FROM CaseTeamMember where Memberid =: Ids]; 
    
    for (CaseTeamMember ctm : ctmlist){
        System.Debug('#$#  Case Team Member ' + ctm.MemberId + ' #$#'); 
        if (!CaseTeamMemberIds.contains (ctm.MemberId) ){
           CaseTeamMemberIds.add(ctm.MemberId);
        }
        if (!CaseTeamMemberArbitratorIds.contains (ctm.MemberId) && ctm.TeamRole.Name == 'Arbitrator' ){
           CaseTeamMemberArbitratorIds.add(ctm.MemberId);
        }
        if (!CaseTeamMemberFacilitatorIds.contains (ctm.MemberId) && ctm.TeamRole.Name == 'Facilitator' ){
           CaseTeamMemberFacilitatorIds.add(ctm.MemberId);
           System.Debug('#$# FACILITOR ' + ctm.MemberId + ' #$#');
        }
        if (!CaseIds.contains (ctm.ParentId) ){
           CaseIds.add(ctm.ParentId);
           System.Debug('#$# CaseIds ' + ctm.ParentId + ' #$#');
        }   
        CaseTeamMemberMap.put(ctm.parentid, ctm.Memberid); 
         System.Debug('#$# CaseTeamMemberMap ' + ctm.parentid + ' , ' + ctm.MemberId + ' #$#');    
     }
     
     for (Case_Comment__c cc:  [SELECT id, Case__c,Comment__c,Share_with_Arbitrator__c,Share_with_Facilitor__c FROM Case_Comment__c Where Case__c in: CaseIds ]){
        /*
        if (!CaseCommentIds.contains (cc.Case__c) ){
           CaseCommentIds.add(cc.Case__c);
           System.Debug('#$# CaseCommentIds.add ' + cc.case__c + ' #$#');
        }
        */
        System.Debug('#$# Case Comment id ' + cc.id + '  #$#');
        for ( Id ctmid : CaseTeamMemberMap.keySet()){
               System.Debug('#$# Case team member map keyset ' + ctmid + '  #$#');
             if (ctmid == cc.case__c){
                id Memberid = CaseTeamMemberMap.get(ctmid);
                 System.Debug('#$# Memberid ' + Memberid + '  #$#');
                if  (CaseTeamMemberArbitratorIds.contains( MemberId) && cc.Share_with_Arbitrator__c == true){
                    Case_Comment__Share caseCommentShare = new Case_Comment__Share();
                    caseCommentShare.ParentId  = cc.id;
                    caseCommentShare.UserOrGroupId = Memberid;
                    caseCommentShare.AccessLevel = 'Read';
                    caseCommentShare.RowCause = Schema.Case_Comment__Share.RowCause.Manual;
                    CaseCommentShareList.add(caseCommentShare);  
                }
                if  (CaseTeamMemberFacilitatorIds.contains( MemberId) && cc.Share_with_Facilitor__C == true){
                    System.Debug('#$# FACILITATOR Case Comment Share   #$#');
                    Case_Comment__Share caseCommentShare = new Case_Comment__Share();
                    caseCommentShare.ParentId  = cc.id;
                    caseCommentShare.UserOrGroupId = Memberid;
                    caseCommentShare.AccessLevel = 'Read';
                    caseCommentShare.RowCause = Schema.Case_Comment__Share.RowCause.Manual;
                    CaseCommentShareList.add(caseCommentShare);  
                }
                if (CaseTeamMemberArbitratorIds.contains( MemberId)) {
                }
                else if  (CaseTeamMemberFacilitatorIds.contains( MemberId)){ 
                }
                else{
                    Case_Comment__Share caseCommentShare = new Case_Comment__Share();
                    caseCommentShare.ParentId  = cc.id;
                    caseCommentShare.UserOrGroupId = Memberid;
                    caseCommentShare.AccessLevel = 'Read';
                    caseCommentShare.RowCause = Schema.Case_Comment__Share.RowCause.Manual;
                    CaseCommentShareList.add(caseCommentShare);                        
                }                          
             }    
        }
         
      }
      
       System.Debug('#$# CaseCommentSharelist.size() ' + CaseCommentSharelist.size() + '  #$#');
      if (CaseCommentSharelist.size()> 0 ){   
        insert CaseCommentSharelist;
      }
    
     
  }
}