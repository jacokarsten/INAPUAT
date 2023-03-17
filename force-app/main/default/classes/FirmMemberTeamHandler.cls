Public class FirmMemberTeamHandler{


Public static Boolean CheckForActiveFirm(List<ID> firm){
        
        Case[] Lst_CaseDef = [Select id,Claimant_Firm_Team__c,Facilitator_Contact__c,Defendant_Firm_Team__c,ClaimantFirm__c,Defendant_Firm__c  From Case Where (Stage__c =: 'Registration' OR Stage__c =: 'Negotiation') AND Defendant_Firm__c in:firm];
        Case[] Lst_CaseCl = [Select id,Claimant_Firm_Team__c,Facilitator_Contact__c,Defendant_Firm_Team__c,ClaimantFirm__c,Defendant_Firm__c  From Case Where (Stage__c =: 'Registration' OR Stage__c =: 'Negotiation') AND ClaimantFirm__c in:firm];
        Case[] Lst_CaseSup = [Select id,Facilitator_Firm__c,Arbitration_Firm__c,Claimant_Firm_Team__c,Facilitator_Contact__c,Defendant_Firm_Team__c,ClaimantFirm__c,Defendant_Firm__c  From Case Where (Stage__c =: 'Registration' OR Stage__c =: 'Negotiation') AND Facilitator_Firm__c in:firm];
        Case[] Lst_CaseArb = [Select id,Arbitration_Firm__c,Claimant_Firm_Team__c,Facilitator_Contact__c,Defendant_Firm_Team__c,ClaimantFirm__c,Defendant_Firm__c  From Case Where (Stage__c =: 'Registration' OR Stage__c =: 'Negotiation')  AND Arbitration_Firm__c in:firm];
        
        
         
        Boolean Inactive = false;
        if(Lst_CaseDef.size()>0){
            Inactive = true;
        }
        else if(Lst_CaseCl.size()>0){
            Inactive = true;
        }
        else if(Lst_CaseSup.size()>0){
            Inactive = true;
        }
        else if(Lst_CaseArb.size()>0){
            Inactive = true;
        }
        
        return Inactive;
}


Public static Boolean CheckForActiveTeam(List<ID> firmteam){
    
    Case[] Lst_CaseDef = [Select id,Claimant_Firm_Team__c,Facilitator_Contact__c,Defendant_Firm_Team__c,ClaimantFirm__c,Defendant_Firm__c  From Case Where (Stage__c =: 'Registration' OR Stage__c =: 'Negotiation') AND Defendant_Firm_Team__c in:firmteam];
    Case[] Lst_CaseCl = [Select id,Claimant_Firm_Team__c,Facilitator_Contact__c,Defendant_Firm_Team__c,ClaimantFirm__c,Defendant_Firm__c  From Case Where (Stage__c =: 'Registration' OR Stage__c =: 'Negotiation') AND Claimant_Firm_Team__c in:firmteam];
         
        Boolean Inactive = false;
            
        if(Lst_CaseDef.size()>0){
            Inactive = true;
        }
        else if(Lst_CaseCl.size()>0){
            Inactive = true;
        }
        return Inactive;
    
}


Public static Boolean CheckForActiveIndvidual(List<ID> Individual){
        Case[] Lst_CaseSup = [Select id,Facilitator_Firm__c,Arbitration_Firm__c,Claimant_Firm_Team__c,Facilitator_Contact__c,Defendant_Firm_Team__c,ClaimantFirm__c,Defendant_Firm__c  From Case Where (Stage__c =: 'Registration' OR Stage__c =: 'Negotiation') AND Facilitator_Contact__c in:Individual];
        Case[] Lst_CaseArb = [Select id,Arbitration_Firm__c,Claimant_Firm_Team__c,Facilitator_Contact__c,Arbitrator_Contact__c  From Case Where (Stage__c =: 'Registration' OR Stage__c =: 'Negotiation')  AND Arbitrator_Contact__c in:Individual];
      
      Boolean Inactive = false;
       if(Lst_CaseSup.size()>0){
            Inactive = true;
        }
        else if(Lst_CaseArb.size()>0){
            Inactive = true;
        }  
      return Inactive;  
}





//From Invocable
Public static void DeactiveAllFromfirm(List<ID> Accid){
        
        Firm_Team__c[] lstFirmTeam = [Select id,Active_Case_Count__c from Firm_Team__c where Firm__c in:Accid AND Status__c !='Removed'];    
        Contact[] lstContact = [Select id,Active_Case_on_Individual_Count__c,Status__c,AccountId From Contact where AccountId in:Accid AND Status__c !='Removed']; 
       
        set<String> Set_firm = new set<String>();
        for(Firm_Team__c team:lstFirmTeam){
            team.Status__c='Inactive';
        }
        update lstFirmTeam;
        
        
        
       
        
        //Invocable will update members
        
        for(Contact con:lstContact){
            con.Status__c='Inactive';
        }
        update lstContact;
        system.debug('**Contact_FIRM**');
                        
        
}
Public static void ActiveAllFromfirm(List<ID> Accid){
        
        Firm_Team__c[] lstFirmTeam = [Select id,Active_Case_Count__c from Firm_Team__c where Firm__c in:Accid AND Status__c !='Removed'];    
        Contact[] lstContact = [Select id,Active_Case_on_Individual_Count__c,Status__c,AccountId From Contact where AccountId in:Accid AND Status__c !='Removed']; 
        
        
          
          
        set<String> Set_firm = new set<String>();
        for(Contact con:lstContact){
            con.Status__c='Active';
        }
        update lstContact;
        
        
        
        for(Firm_Team__c team:lstFirmTeam){
            team.Status__c='Active';
        }
        update lstFirmTeam;
        //Invocable will update members
        
        
        
                        
        
}
Public static void RemoveAllFromfirm(List<ID> Accid){
        
        Firm_Team__c[] lstFirmTeam = [Select id,Active_Case_Count__c from Firm_Team__c where Firm__c in:Accid];    
        Contact[] lstContact = [Select id,Active_Case_on_Individual_Count__c,Status__c,AccountId From Contact where AccountId in:Accid ]; 
        
        set<String> Set_firm = new set<String>();
        for(Contact con:lstContact){
            con.Status__c='Removed';
        }
        update lstContact;
        
        for(Firm_Team__c team:lstFirmTeam){
            team.Status__c='Removed';
        }
        update lstFirmTeam;
        //Invocable will update members
        
        for(Contact con:lstContact){
            con.Status__c='Removed';
        }
        update lstContact;
        
                        
        
}
public static void RemoveAllmembersContact(List<ID> ContactID){
    
    Firm_Team_Roles__c[] lst_FirmTeamRoles = [SELECT Contact__c,Roles__c,Firm_Team__c FROM Firm_Team_Roles__c where Contact__c in: ContactID];            
    delete lst_FirmTeamRoles;
   
}
public static void RemoveAllmembersinteam(List<ID> FirmTeam){
    
    Firm_Team_Roles__c[] lst_FirmTeamRoles = [SELECT Contact__c,Roles__c,Firm_Team__c FROM Firm_Team_Roles__c where Firm_Team__c in: FirmTeam];            
    delete lst_FirmTeamRoles;
    
}


//From Invocable -- Comment out ALL BELOW
/*
public static void DecativeAllmembersinteam(List<ID> FirmTeam){
    
    Firm_Team_Roles__c[] lst_FirmTeamRoles = [SELECT Contact__c,Roles__c,Firm_Team__c,Status__c FROM Firm_Team_Roles__c where Firm_Team__c in: FirmTeam AND Status__c !='Removed'];        
    
    for(Firm_Team_Roles__c mem:lst_FirmTeamRoles){    
        
        mem.Status__c='Inactive';
    }
    update lst_FirmTeamRoles;
    
}

public static void ActiveAllmembersinteam(List<ID> FirmTeam){
    
    Firm_Team_Roles__c[] lst_FirmTeamRoles = [SELECT Contact__c,Roles__c,Firm_Team__c,Status__c FROM Firm_Team_Roles__c where Firm_Team__c in: FirmTeam AND Status__c !='Removed'];        
    system.debug('***Roles**'+lst_FirmTeamRoles);
    for(Firm_Team_Roles__c mem:lst_FirmTeamRoles){    
        
        mem.Status__c='Active';
    }
    update lst_FirmTeamRoles;
    
}




public static void DecativeAllmembersContact(List<ID> ContactID){
    
    Firm_Team_Roles__c[] lst_FirmTeamRoles = [SELECT Contact__c,Roles__c,Firm_Team__c,Status__c FROM Firm_Team_Roles__c where Contact__c in: ContactID AND Status__c !='Removed'];        
    
    for(Firm_Team_Roles__c mem:lst_FirmTeamRoles){    
        
        mem.Status__c='Inactive';
    }
    
    update lst_FirmTeamRoles;
    
    system.debug('**ROLINAC**'+lst_FirmTeamRoles+'****'+UserHandler.STOPUSERTRIGGER);
    
      
}

public static void ActiveAllmembersContact(List<ID> ContactID){
    
    Firm_Team_Roles__c[] lst_FirmTeamRoles = [SELECT Contact__c,Roles__c,Firm_Team__c,Status__c FROM Firm_Team_Roles__c where Contact__c in: ContactID AND Status__c !='Removed'];        
    
    for(Firm_Team_Roles__c mem:lst_FirmTeamRoles){    
        
        mem.Status__c='Active';
    }
    update lst_FirmTeamRoles;
    
    system.debug('**ROLAC**'+lst_FirmTeamRoles+'****'+UserHandler.STOPUSERTRIGGER);
  
     
}
*/




/*
Public static void AddCountupdateTeamCase(String TeamId){
  
    Firm_Team__c[] lstFirmTeam = [Select id,Active_Case_Count__c from Firm_Team__c where id=:TeamId];    
    lstFirmTeam[0].Active_Case_Count__c = lstFirmTeam[0].Active_Case_Count__c +1;    
    update lstFirmTeam;
}

Public static void MinusCountupdateTeamCase(String TeamId){
  
    Firm_Team__c[] lstFirmTeam = [Select id,Active_Case_Count__c from Firm_Team__c where id=:TeamId];    
    lstFirmTeam[0].Active_Case_Count__c = lstFirmTeam[0].Active_Case_Count__c -1;    
    update lstFirmTeam;
}


Public static void AddCountupdateIndividual(Set<String> ContactId){
  
    Contact[] lstContact = [Select id,Active_Case_on_Individual_Count__c,AccountId From Contact where id in:ContactId]; 
    
    Set<String> Set_acc = new Set<String>();
    for(Contact con:lstContact){
            Set_acc.add(con.AccountId);
    }
    
    Account[] lstAccount = [Select id,Active_Individual_Members__c from Account where id in:Set_acc];
   
   for(Account acc:lstAccount){ 
    for(Contact con:lstContact){
        con.Active_Case_on_Individual_Count__c = con.Active_Case_on_Individual_Count__c+1; 
        acc.Active_Individual_Members__c=acc.Active_Individual_Members__c+1;       
    } 
   } 
    update lstContact;
    update lstAccount;
}

Public static void MinusCountupdateIndividual(Set<String> ContactId){
  
    Contact[] lstContact = [Select id,Active_Case_on_Individual_Count__c,AccountId From Contact where id in:ContactId]; 
    
    Set<String> Set_acc = new Set<String>();
    for(Contact con:lstContact){
            Set_acc.add(con.AccountId);
    }
    
    Account[] lstAccount = [Select id,Active_Individual_Members__c from Account where id in:Set_acc];
   
   for(Account acc:lstAccount){ 
    for(Contact con:lstContact){
        con.Active_Case_on_Individual_Count__c = con.Active_Case_on_Individual_Count__c-1; 
        acc.Active_Individual_Members__c=acc.Active_Individual_Members__c-1;       
    } 
   } 
    update lstContact;
    update lstAccount;
    
    
}


//From Invocable FROM CASE STATUS CHANGE TO CLOSED

Public static void AddCountupdateTeamCase(List<Id> CaseId){
  
    Case[] Lst_Case = [Select id,Claimant_Firm_Team__c,Facilitator_Contact__c,Defendant_Firm_Team__c,ClaimantFirm__c,Defendant_Firm__c  From Case Where id in: CaseId];
    
    Set<string> Set_Claim = new Set<string>();
    Set<string> Set_Def = new Set<string>();
    Set<string> Set_Fac = new Set<string>();
    
    for(Case c:Lst_Case){
        Set_Claim.add(c.Claimant_Firm_Team__c);
        Set_Def.add(c.Defendant_Firm_Team__c);
        Set_Fac.add(c.Facilitator_Contact__c);
    }
    
    Firm_Team__c[] lstFirmTeamDef = [Select id,Active_Case_Count__c from Firm_Team__c where id in:Set_Def];
    
    Firm_Team__c[] lstFirmTeamClaim = [Select id,Active_Case_Count__c from Firm_Team__c where id in:Set_Claim];
    
    Contact[] lstContact = [Select id,Active_Case_on_Individual_Count__c,Status__c,AccountId From Contact where id in:Set_Fac ]; 
        
    
    for(Firm_Team__c def:lstFirmTeamDef){
        def.Active_Case_Count__c = def.Active_Case_Count__c-1;
    
    }
    
    for(Firm_Team__c cl:lstFirmTeamClaim){
        cl.Active_Case_Count__c = cl.Active_Case_Count__c-1;    
    }
    
    for(Contact con:lstContact){
        con.Active_Case_on_Individual_Count__c =  con.Active_Case_on_Individual_Count__c+1;
    }
    
    
    
    update lstFirmTeamDef;
    update lstFirmTeamClaim;
}
*/


}