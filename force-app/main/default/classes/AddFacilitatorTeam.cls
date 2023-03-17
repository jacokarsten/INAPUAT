Public Class AddFacilitatorTeam{


@InvocableMethod
Public Static void AddFacilitatorTeam(List<Id> FacilitatorId){
      
    Case[] Lst_Case = [Select id,Facilitator_Contact__c From Case Where id in: FacilitatorId];
    
    Map<String,String> Map_TeamIdCaseId = new Map<String,String>();
    
    Set<String> Set_ContactId = new Set<String>();
    for(Case c:Lst_Case){
          Set_ContactId.add(c.Facilitator_Contact__c); 
          Map_TeamIdCaseId.put(c.Facilitator_Contact__c,c.id);  
    }
    
    system.Debug('****'+Map_TeamIdCaseId);
    
    CaseMemberHandler.AddtoCaseTeamIndividual('Facilitator',Map_TeamIdCaseId);
    //FirmMemberTeamHandler.AddCountupdateIndividual(Set_ContactId);
}
    
}