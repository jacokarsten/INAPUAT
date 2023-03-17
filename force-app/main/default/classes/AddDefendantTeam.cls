Public Class AddDefendantTeam{


@InvocableMethod
Public Static void AddDefendantTeam(List<Id> DefendantId){
       
    Case[] Lst_Case = [Select id,Defendant_Firm_Team__c From Case Where id in: DefendantId];
    
    Map<String,String> Map_TeamIdCaseId = new Map<String,String>();
    
    for(Case c:Lst_Case){
          Map_TeamIdCaseId.put(c.Defendant_Firm_Team__c,c.id);  
    }
    
    system.Debug('**HUH?**'+Map_TeamIdCaseId);
    
    CaseMemberHandler.AddtoCaseTeam('Defendant Handler',Map_TeamIdCaseId);
   // FirmMemberTeamHandler.AddCountupdateTeamCase(Lst_Case[0].Defendant_Firm_Team__c);
}
    
}