Public Class AddClaimantSupervisorTeam{


@InvocableMethod
Public Static void AddSupervisorTeam(List<Id>  SupervisorId){
      
    Case[] Lst_Case = [Select id,ClaimantFirm__c From Case Where id in: SupervisorId];
    
    Set<String> Set_ClFirm = new Set<string>();
    for(Case c:Lst_Case){
        Set_ClFirm.add(c.ClaimantFirm__c);  
    }
    Contact[] lstContact = [Select id,AccountId From Contact where Role__c=:'Supervisor' AND AccountId in:Set_ClFirm AND Status__c='Active']; 
    
    Map<String,String> Map_TeamIdCaseId = new Map<String,String>();
    
    system.Debug('**lstContact**'+lstContact);
    Set<String> Set_Con = new Set<String>();
    for(Case c:Lst_Case){
        for( Contact con:lstContact){
              if(con.AccountId == c.ClaimantFirm__c){ 
                  Set_Con.Add(con.id);     
                Map_TeamIdCaseId.put(con.id,c.id); 
              }   
        }
    }
    system.Debug('****'+Map_TeamIdCaseId);
   
    
    
    CaseMemberHandler.AddtoCaseTeamIndividual('Claimant Supervisor',Map_TeamIdCaseId);
    //FirmMemberTeamHandler.AddCountupdateIndividual(Set_Con);
}

    
}