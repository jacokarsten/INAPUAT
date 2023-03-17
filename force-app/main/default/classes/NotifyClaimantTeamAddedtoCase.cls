Public Class NotifyClaimantTeamAddedtoCase{

    @invocablemethod
    Public static void NotifyClaimantTeam(List<Id> CaseId){
  
    Case[]  CaseQuick = [Select id,Invite_Arbitrator__c,Status,Settled_Status_Count__c ,Arbitrator_Contact__c ,Arbitration_Completed_Count__c ,Arbitration_Negotiation_Count__c,Settlement_Negotiation_Status_Count__c,Submit_Schedule_of_Losses__c,Submit_Case__c,Defendent_rejection_reason__c ,Stage__c,Defendant_Agree_to_Arbitration_Process__c,Defendant_Accept_Reject__c ,Submit_Schedule_of_Losses_Defendant__c,Arbitration_Firm__c,Agree_to_Arbitration_Process__c, Claimant_Firm_Team__c,ClaimantFirm__c,Claimant_Minimum_Personal_Details__c,Defendant_Minimum_Personal_Details__c,Facilitator_Firm__c,Facilitator_Contact__c,Defendant_Firm_Team__c,Defendant_Firm__c,Total_Obligation__c,Protocol__r.Mininmum_Schedule__c,Merit_Minimum_Requirements__c from Case Where id in:CaseId]; //CQuick.Id
 
    for(Case   c:CaseQuick){ 
        CaseNotificationHandler.NotifyTeamMembersRegistration(c.Claimant_Firm_Team__c,'Claimant',c.id,'NotifyTeam');
    }    
    
    //Defendant_Firm_Team__c
}



}