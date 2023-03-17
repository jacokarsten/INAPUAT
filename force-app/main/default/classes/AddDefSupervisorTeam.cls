Public Class AddDefSupervisorTeam{


@InvocableMethod
Public Static void AddSupervisorTeam(List<Id>  SupervisorId){
      
    Case[] Lst_Case = [Select id,Defendant_Firm_Team__c,Defendant_Firm__c From Case Where id in: SupervisorId];
    
    Set<String> Set_DefFirm = new Set<string>();
    for(Case c:Lst_Case){
        Set_DefFirm.add(c.Defendant_Firm__c);  
    }
    Contact[] lstContact = [Select id,AccountId From Contact where Role__c=:'Supervisor' AND AccountId in:Set_DefFirm AND Status__c ='Active']; 
    
    Map<String,String> Map_TeamIdCaseId = new Map<String,String>();
    
    system.Debug('**lstContact**'+lstContact);
    
    Set<String> Set_Con = new Set<String>();
    String CaseId;
    for(Case c:Lst_Case){
        for( Contact con:lstContact){
              if(con.AccountId == c.Defendant_Firm__c){      
                Map_TeamIdCaseId.put(con.id,c.id);
                Set_Con.Add(con.id);
                CaseId=c.id; 
              }   
        }
    }
    system.Debug('****'+Map_TeamIdCaseId);
     
    CaseMemberHandler.AddtoCaseTeamIndividual('Defendant Supervisor',Map_TeamIdCaseId);  
    CaseNotificationHandler.NotifySupervisorsRegistration(Set_Con,'Defendant',CaseId );
   // FirmMemberTeamHandler.AddCountupdateIndividual(Set_Con);
     
}
    
}