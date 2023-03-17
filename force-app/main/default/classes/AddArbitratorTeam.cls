Public Class AddArbitratorTeam{


@InvocableMethod
Public Static void AddArbitratorTeam(List<Id> ArbitratorId){
       
    Case[] Lst_Case = [Select id,Arbitrator_Contact__c From Case Where id in: ArbitratorId];
    
    Map<String,String> Map_TeamIdCaseId = new Map<String,String>();
    
    Set<String> Set_ContactId = new Set<String>();
    for(Case c:Lst_Case){
         // Set_ContactId.add(c.Facilitator_Contact__c);
          Map_TeamIdCaseId.put(c.Arbitrator_Contact__c,c.id);  
    }
    
    system.Debug('****'+Map_TeamIdCaseId);
    
    CaseMemberHandler.AddtoCaseTeamIndividual('Arbitrator',Map_TeamIdCaseId);
    //FirmMemberTeamHandler.AddCountupdateIndividual(Set_ContactId);
}
    
}