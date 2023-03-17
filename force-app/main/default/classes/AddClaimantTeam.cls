Public Class AddClaimantTeam{


@InvocableMethod
Public Static void AddClaimantTeam(List<Id> ClaimantId){
        
    Case[] Lst_Case = [Select id,Claimant_Firm_Team__c From Case Where id in: ClaimantId];
    
    Map<String,String> Map_TeamIdCaseId = new Map<String,String>();
    
    for(Case c:Lst_Case){
          Map_TeamIdCaseId.put(c.Claimant_Firm_Team__c,c.id);  
    }
    
    system.Debug('****'+Map_TeamIdCaseId);
    
    CaseMemberHandler.AddtoCaseTeam('Claimant Handler',Map_TeamIdCaseId);
    
    //FirmMemberTeamHandler.AddCountupdateTeamCase(Lst_Case[0].Claimant_Firm_Team__c);
}
    
}