Public Class RemoveCaseTeams{


//CALLED FROM CASE TRIGGER ON CHANGE OF STATUS

Public Static void RemoveDefendantTeam(List<Case> Lst_OldCase,List<Case> Lst_NewCase){
     
     //Remove team tick box
     
     Map<String,String> Map_oldDefTeam = new Map<String,String>();
      
     for(Case oldc:Lst_OldCase){
         Map_oldDefTeam.put(oldc.id,oldc.Defendant_Firm_Team__c);
     }
     
     Set<String> Set_Case = new Set<String>();
     
     for(Case newc:Lst_NewCase){
     
         if(Map_oldDefTeam.get(newc.id) != newc.Defendant_Firm_Team__c){
             Set_Case.Add(newc.id);
         }
     }
     
     if(Set_Case.size()>0){
             Set<String> Set_Member = new Set<String>();
             Case[] Lst_Case = [Select id,Defendant_Firm__c From Case Where id in: Set_Case];
                
            CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId =:Set_Case AND TeamRole.Name =:'Defendant Handler'];       
           
            delete CaseTeamMember;
            
    }    
   /*
   for(CaseTeamMember mem:CaseTeamMember){
       Set_Member.add(mem.MemberId);   
   } 
   
    
    //CaseMemberHandler.RemoveTeam(Lst_Case[0].Defendant_Firm__c,CaseId,Set_Member);    
   */
    
}


Public Static void RemoveClaimantTeam(List<Case> Lst_OldCase,List<Case> Lst_NewCase){
    
      //Remove team tick box
     
     Map<String,String> Map_oldDefTeam = new Map<String,String>();
      
     for(Case oldc:Lst_OldCase){
         Map_oldDefTeam.put(oldc.id,oldc.Claimant_Firm_Team__c);
     }
     
     Set<String> Set_Case = new Set<String>();
     
     for(Case newc:Lst_NewCase){
     
         if(Map_oldDefTeam.get(newc.id) != newc.Claimant_Firm_Team__c){
             Set_Case.Add(newc.id);
         }
     }
     
     if(Set_Case.size()>0){
             Set<String> Set_Member = new Set<String>();
             Case[] Lst_Case = [Select id,Defendant_Firm__c From Case Where id in: Set_Case];
                
            CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId =:Set_Case AND TeamRole.Name =:'Claimant Handler'];       
           
            delete CaseTeamMember;
            
    }    
   /*
   for(CaseTeamMember mem:CaseTeamMember){
       Set_Member.add(mem.MemberId);   
   } 
   
    
    //CaseMemberHandler.RemoveTeam(Lst_Case[0].Defendant_Firm__c,CaseId,Set_Member);    
   */
    
}


Public Static void RemoveClaimantSupervisor(List<Case> Lst_OldCase,List<Case> Lst_NewCase){
    
      //Remove team tick box
     
     Map<String,String> Map_oldDefTeam = new Map<String,String>();
      
     for(Case oldc:Lst_OldCase){
         Map_oldDefTeam.put(oldc.id,oldc.ClaimantFirm__c);
     }
     
     Set<String> Set_Case = new Set<String>();
     
     for(Case newc:Lst_NewCase){
     
         if(Map_oldDefTeam.get(newc.id) != newc.ClaimantFirm__c){
             Set_Case.Add(newc.id);
         }
     }
     
     if(Set_Case.size()>0){
             Set<String> Set_Member = new Set<String>();
             Case[] Lst_Case = [Select id,Defendant_Firm__c From Case Where id in: Set_Case];
                
            CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId =:Set_Case AND TeamRole.Name =:'Claimant Supervisor'];       
           
            delete CaseTeamMember;
            
    }    
}


Public Static void RemoveDefendantSupervisor(List<Case> Lst_OldCase,List<Case> Lst_NewCase){
     
     //Remove team tick box
     
     Map<String,String> Map_oldDefTeam = new Map<String,String>();
      
     for(Case oldc:Lst_OldCase){
         Map_oldDefTeam.put(oldc.id,oldc.Defendant_Firm__c);
     }
     
     Set<String> Set_Case = new Set<String>();
     
     for(Case newc:Lst_NewCase){
     
         if(Map_oldDefTeam.get(newc.id) != newc.Defendant_Firm__c){
             Set_Case.Add(newc.id);
         }
     }
     
     if(Set_Case.size()>0){
             Set<String> Set_Member = new Set<String>();
             Case[] Lst_Case = [Select id,Defendant_Firm__c From Case Where id in: Set_Case];
                
            CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId =:Set_Case AND TeamRole.Name =:'Defendant Supervisor'];       
           
            delete CaseTeamMember;
            
    }    
   /*
   for(CaseTeamMember mem:CaseTeamMember){
       Set_Member.add(mem.MemberId);   
   } 
   
    
    //CaseMemberHandler.RemoveTeam(Lst_Case[0].Defendant_Firm__c,CaseId,Set_Member);    
   */
    
}

Public Static void RemoveFacilitator(List<Case> Lst_OldCase,List<Case> Lst_NewCase){
     
     //Remove team tick box
     
     Map<String,String> Map_oldFac = new Map<String,String>();
     Map<String,String> Map_oldFacCon = new Map<String,String>();
      
     for(Case oldc:Lst_OldCase){
         Map_oldFac.put(oldc.id,oldc.Facilitator_Firm__c);
         Map_oldFacCon.put(oldc.id,oldc.Facilitator_Contact__c);
         
     }
     
     Set<String> Set_Case = new Set<String>();
     
     for(Case newc:Lst_NewCase){
     
         if(Map_oldFac.get(newc.id) != newc.Facilitator_Firm__c){
             Set_Case.Add(newc.id);
             newc.Facilitator_Contact__c=null;
         }
         else if(Map_oldFacCon.get(newc.id) != newc.Facilitator_Contact__c){
             Set_Case.Add(newc.id);
         }
         
     }
     
     if(Set_Case.size()>0){
             Set<String> Set_Member = new Set<String>();
             Case[] Lst_Case = [Select id,Facilitator_Firm__c From Case Where id in: Set_Case];
                
            CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId =:Set_Case AND TeamRole.Name =:'Facilitator'];       
           
            delete CaseTeamMember;
            
    } 
    
    
       
   /*
   for(CaseTeamMember mem:CaseTeamMember){
       Set_Member.add(mem.MemberId);   
   } 
   
    
    //CaseMemberHandler.RemoveTeam(Lst_Case[0].Defendant_Firm__c,CaseId,Set_Member);    
   */
    
}


    
}