Public Class CaseMemberHandler{



Public Static void AddtoCaseTeam(String Role, Map<String,String> Map_TeamIdCaseId) {


  Firm_Team_Roles__c[] lst_FirmTeamRoles = [SELECT Contact__c,Roles__c,Firm_Team__c FROM Firm_Team_Roles__c where Firm_Team__c in: Map_TeamIdCaseId.keyset() ];
  
  Map<String,String> Map_TeamIdContactId = new Map<String,String>();
  
  String TempRole = 'Case Handler';
    
  system.Debug('**TeamIdCaseId**'+Map_TeamIdCaseId);
    
  for(Firm_Team_Roles__c  f:lst_FirmTeamRoles){
      if(Role.Contains('Handler')){
          if(f.Roles__c == TempRole){      
              Map_TeamIdContactId.put(f.Contact__c  ,Map_TeamIdCaseId.get(f.Firm_Team__c) );  
          }
      }
      else if(f.Roles__c == Role){      
              Map_TeamIdContactId.put(f.Contact__c  ,Map_TeamIdCaseId.get(f.Firm_Team__c) );  
      }
  }
  
   system.Debug('**Map_TeamIdContactId**'+Map_TeamIdContactId);
    
   
  User[] lst_User =  [SELECT ContactId FROM User Where ContactId in: Map_TeamIdContactId.keyset()];
  CaseTeamRole[] TeamRole  = [SELECT Id,Name FROM CaseTeamRole where Name=: Role];
  
  Set<String> Set_Usr = new Set<String>();
  Map<String,String> Map_UsrCon = new Map<String,String>();
  
  for(User u:lst_User){
          Set_Usr.add(u.id);
          Map_UsrCon.put(u.ContactId,u.id);
      }
  
  
  CaseTeamMember[] lstExistCaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where MemberId in:Set_Usr AND ParentId in:Map_TeamIdContactId.values()  ];   
        
      
      Map<String,String> Map_MemCase = new  Map<String,String>(); 
      
      system.Debug('**lstCaseTeamMember**'+lstExistCaseTeamMember);
      
      Map<String,String>  Map_Add = new Map<String,String>();
      
      String CaseCon;
      
      for(CaseTeamMember mem:lstExistCaseTeamMember){
          Map_MemCase.put(mem.MemberId,mem.ParentId);  
         
      }
  
  for(String str:Map_TeamIdContactId.keyset()){
      
          system.Debug('**Map_MemCase**'+Map_MemCase.get(Map_UsrCon.get(str)));
      
          if(Map_MemCase.get(Map_UsrCon.get(str))==null){
              Map_Add.put(str,Map_TeamIdContactId.get(str));             
          }
          
      }
  
  
  
  List<ID> lst_Comments = new List<ID>();
  
  List<CaseTeamMember> lst_CaseTeamMember = new List<CaseTeamMember>();  
  for(string str:Map_Add.keyset()){ 
      for(User  u:lst_User){
          if(str  != null && str == u.ContactId){
              CaseTeamMember CaseTeamMember = new CaseTeamMember(MemberId=u.Id,TeamRoleId = TeamRole[0].id,ParentId = Map_TeamIdContactId.get(u.ContactId));  
              lst_CaseTeamMember.Add(CaseTeamMember);
              lst_Comments.add(u.Id);
          }    
      }  
  }    
  
  system.Debug('**lst_CaseTeamMember**'+lst_CaseTeamMember);
  Insert lst_CaseTeamMember;
  
  CaseCommentCaseTeamHandler.AddCaseCommentSharing(lst_Comments);

}

Public Static void AddtoCaseTeamIndividual(String Role, Map<String,String> Map_TeamIdContactId) {
   
      User[] lst_User =  [SELECT ContactId FROM User Where ContactId in:Map_TeamIdContactId.keyset() AND isactive=True ];
      CaseTeamRole[] TeamRole  = [SELECT Id,Name FROM CaseTeamRole where Name=: Role];
      
      Set<String> Set_Usr = new Set<String>();
      Map<String,String> Map_UsrCon = new Map<String,String>();
      
      for(User u:lst_User){
          Set_Usr.add(u.id);
          Map_UsrCon.put(u.ContactId,u.id);
      }
      
      system.Debug('**TeamRole**'+TeamRole);
      
      CaseTeamMember[] lstCaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where MemberId in:Set_Usr AND ParentId in:Map_TeamIdContactId.values()  ];   
        
      
      Map<String,String> Map_MemCase = new  Map<String,String>(); 
      
      system.Debug('**lstCaseTeamMember**'+lstCaseTeamMember);
      
      Map<String,String>  Map_Add = new Map<String,String>();
      
      String CaseCon;
      
      for(CaseTeamMember mem:lstCaseTeamMember){
          Map_MemCase.put(mem.MemberId,mem.ParentId);  
         
      }
      
     
     
      for(String str:Map_TeamIdContactId.keyset()){
      
          system.Debug('**Map_MemCase**'+Map_MemCase.get(Map_UsrCon.get(str)));
      
          if(Map_MemCase.get(Map_UsrCon.get(str))==null){
              Map_Add.put(str,Map_TeamIdContactId.get(str));             
          }
          
      }
     
      
      List<CaseTeamMember> lst_CaseTeamMember = new List<CaseTeamMember>();  

    
    system.Debug('**lst_User**'+lst_User);
    
    List<ID> lst_Comments = new List<ID>();
    for(string str:Map_Add.keyset()){      
      for(User  u:lst_User){
      
          system.Debug('**Map_Add.get(str)**'+Map_Add.get(str) +'******'+u.ContactId);
           if(str  != null && str == u.ContactId){
                  CaseTeamMember CaseTeamMember = new CaseTeamMember(MemberId=u.Id,TeamRoleId = TeamRole[0].id,ParentId = Map_Add.get(str));  
                  lst_CaseTeamMember.Add(CaseTeamMember);
                  lst_Comments.add(u.Id);
           }
       }
    }    
    
      
      Insert lst_CaseTeamMember;
      CaseCommentCaseTeamHandler.AddCaseCommentSharing(lst_Comments);
}


Public Static void RemoverCaseTeamRole(String TeamRole, Set<String> CaseId, Set<String> UserId) {
     
  CaseTeamMember[] CaseTeamMember;
    
  if(TeamRole=='Defendant'){   
      CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:CaseId AND (TeamRole.Name =:'Defendant Handler' OR TeamRole.Name =:'Defendant Supervisor') AND MemberId in:UserId];  
  }
  else if(TeamRole=='Claimant'){
      CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:CaseId AND (TeamRole.Name =:'Claimant Handler' OR TeamRole.Name =:'Claimant Supervisor') AND MemberId in:UserId];  
  }
  else if(TeamRole=='Defendant Handler'){
      CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:CaseId AND TeamRole.Name =:'Defendant Handler' AND MemberId in:UserId];  
  }
  else if(TeamRole=='Claimant Handler'){
      CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:CaseId AND TeamRole.Name =:'Claimant Handler' AND MemberId in:UserId];   
  }
  else if(TeamRole=='Supervisor'){
         CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:CaseId AND (TeamRole.Name =:'Claimant Supervisor' OR TeamRole.Name =:'Defendant Supervisor') AND MemberId in:UserId];   
  }    
  else if(TeamRole=='Arbitrator'){
         CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:CaseId AND TeamRole.Name =:'Arbitrator' AND MemberId in:UserId];    
         system.debug('***ARB**'); 
  }
  
  else if(TeamRole=='All'){
         CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:CaseId AND MemberId in:UserId];    
  }
  system.debug('***CaseTeamMember**'+CaseTeamMember);
  if(CaseTeamMember.size()>0){ 
      delete CaseTeamMember;    
  }  
    
    
    
}
/*
 Replaced via trigger
Public Static void RemoveTeam(String TeamId,List<Id> CaseId,Set<string> Set_Member){
        
   
    Firm_Team_Roles__c[] lst_FirmTeamRoles = [SELECT Contact__c,Roles__c,Firm_Team__c FROM Firm_Team_Roles__c where Firm_Team__c =: TeamId];
      
    Set<String> Set_Con = new Set<String>();  
    Set<String> Set_DelMember = new Set<String>();
      
    for(Firm_Team_Roles__c  f:lst_FirmTeamRoles){
         Set_Con.add(f.Contact__c);
    }  
      
    User[] lst_User =  [SELECT ContactId FROM User Where ContactId in: Set_Con];
    
    for(User u:lst_User){
        if(!Set_Member.contains(u.ContactId)){
            Set_DelMember.add(u.id);
        }    
    }
    
    CaseTeamMember[] CaseTeamMemberdelete = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where memberId in:Set_DelMember AND ParentId =:CaseId];   
    
    if(CaseTeamMemberdelete.size()>0){
        delete CaseTeamMemberdelete;
    }
    
   // FirmMemberTeamHandler.MinusCountupdateTeamCase(lst_FirmTeamRoles[0].Firm_Team__c);
    
}
*/

Public Static void BulkRemoveHandlerCaseTeam(List<Firm_Team_Roles__c> lst_FirmTeamRoles){
        
    Set<string> Set_Team = new Set<String>();    
    Set<String> Set_Con = new Set<String>();
    Set<String> Set_DelMember = new Set<String>();
    
    for(Firm_Team_Roles__c  f:lst_FirmTeamRoles){ 
         Set_Con.add(f.Contact__c);
         Set_Team.add(f.Firm_Team__c);
    }  
      
    User[] lst_User =  [SELECT id,ContactId FROM User Where ContactId in: Set_Con];
    
    for(User u:lst_User){
            Set_DelMember.add(u.id);  
    }
       
    Case[] CurrentCase = [Select OwnerId from Case where  (Stage__c =:'Negotiation' OR Stage__c =:'Created') AND (Defendant_Firm__c in:Set_Team OR Claimant_Firm_Team__c in:Set_Team)];
    
    CaseTeamMember[] CaseTeamMemberdelete = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where memberId in:Set_DelMember AND parentid in:CurrentCase]; 

    
    delete CaseTeamMemberdelete;
    
}


Public Static void BulkAddHandlerCaseTeam(List<Firm_Team_Roles__c> lst_FirmTeamRoles){
        
    Map<string,string> Map_Team = new Map<string,string>();
    Map<string,string> Map_Role = new Map<string,string>();       
    
    Set<String> Set_DelMember = new Set<String>();
    
    
    for(Firm_Team_Roles__c  f:lst_FirmTeamRoles){
         Map_Team.put(f.Firm_Team__c,f.Contact__c);
         Map_Role.put(f.Contact__c,f.Roles__c);
    }  
      
       
    Case[] CurrentCase = [Select OwnerId,Defendant_Firm_Team__c,Claimant_Firm_Team__c from Case where  (Stage__c =:'Negotiation' OR Stage__c =:'Created') AND (Defendant_Firm_Team__c in:Map_Team.keyset() OR Claimant_Firm_Team__c in:Map_Team.keyset())];
    
    Map<String,String> Map_TeamIdClHandler;  
    Map<String,String> Map_TeamIdDefHandler;
    Map<String,String> Map_TeamIdClSupervisor; 
    Map<String,String> Map_TeamIdDefSupervisor;
    
    for(Case cur:CurrentCase){
        
        if(cur.Defendant_Firm_Team__c !=null && Map_Team.get(cur.Defendant_Firm_Team__c) != null){
            
            Map_TeamIdDefHandler = new Map<String,String>(); 
            Map_TeamIdDefSupervisor = new Map<String,String>();
                
            for(Firm_Team_Roles__c  f:lst_FirmTeamRoles){
                 if(f.Roles__c=='Case Handler'){
                     Map_TeamIdDefHandler.put(f.Contact__c,cur.id);
                 }
                 else if(f.Roles__c=='Supervisor'){
                     Map_TeamIdDefSupervisor.put(f.Contact__c,cur.id);
                 }                                 
            }
            if(Map_TeamIdDefHandler.size()>0){
                AddtoCaseTeamIndividual('Defendant Handler', Map_TeamIdDefHandler); 
            }
            if(Map_TeamIdDefSupervisor.size()>0){
                AddtoCaseTeamIndividual('Defendant Supervisor', Map_TeamIdDefSupervisor); 
            }
            
        }
        
        if(cur.Claimant_Firm_Team__c !=null && Map_Team.get(cur.Claimant_Firm_Team__c) != null){
        
           Map_TeamIdClHandler = new Map<String,String>();
           Map_TeamIdClSupervisor = new Map<String,String>();
             
           for(Firm_Team_Roles__c  f:lst_FirmTeamRoles){
                 if(f.Roles__c=='Case Handler'){
                     Map_TeamIdClHandler.put(f.Contact__c,cur.id);
                 }
                 else if(f.Roles__c=='Supervisor'){
                     Map_TeamIdClSupervisor.put(f.Contact__c,cur.id);
                 }                                 
           }
           if(Map_TeamIdClHandler.size()>0){
               AddtoCaseTeamIndividual('Claimant Handler', Map_TeamIdClHandler);
           }
           if(Map_TeamIdClSupervisor.size()>0){
               AddtoCaseTeamIndividual('Claimant Supervisor', Map_TeamIdClSupervisor); 
           }
           
        }
                        
    }
    
    
    
    
    
    
}

Public Static void BulkAddSupervisor(List<Contact> lstContact){

    Map<String,String> Map_Acc = new Map<String,String>();
    Map<String,String> Map_USRAcc = new Map<String,String>();
    
    Set<String> Set_Case = new Set<String>();
    Set<String> Set_Con = new Set<String>();
    
    for(Contact con:lstContact){
        if(con.Role__c=='Supervisor'){
            Map_Acc.put(con.id,con.AccountId);
            Set_Con.Add(con.id);
        }    
    }
    
  if(Set_Con.size()>0){  
  
  
    Case[] Lst_Case = [Select id,ClaimantFirm__c,Defendant_Firm__c From Case Where (Defendant_Firm__c in: Map_Acc.values() OR ClaimantFirm__c in:Map_Acc.values()) AND (Stage__c='Registration' OR Stage__c='Negotiation') ];
    
   
    
    
   //-------- 
      User[] lst_User =  [SELECT ContactId FROM User Where ContactId in:Set_Con AND IsActive=:true];
      CaseTeamRole[] DefTeamRole  = [SELECT Id,Name FROM CaseTeamRole where Name=: 'Defendant Supervisor'];
      CaseTeamRole[] ClaimTeamRole  = [SELECT Id,Name FROM CaseTeamRole where Name=: 'Claimant Supervisor'];
      
      Set<String> Set_Usr = new Set<String>();
      
      for(User u:lst_User){
          Set_Usr.add(u.id);
          Map_USRAcc.Put(u.Id,Map_Acc.get(u.ContactId));
      }
      
      for(Case c:Lst_Case){
          Set_Case.add(c.id);
      
      }
    
    
    CaseTeamMember[] lstExisTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where MemberId in:Set_Usr  ];
    
    CaseTeamMember[] lstCaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:Set_Case];
       
    String MemPar;
     Map<String,String> Map_MemCase = new  Map<String,String>(); 
    for(CaseTeamMember mem:lstCaseTeamMember){
          MemPar=mem.MemberId;
          MemPar=MemPar+mem.ParentId;
            
          Map_MemCase.put(MemPar,mem.ParentId);           
    }    
   //---------------- 
    
    system.Debug('**Lst_Case**'+Lst_Case);
    system.Debug('**lstContact**'+lstContact);
   
    List<CaseTeamMember> lst_NewCaseTeamMember = new List<CaseTeamMember>();
    
    for(Case c:Lst_Case){
    
        for( CaseTeamMember mem:lstExisTeamMember){
             
              MemPar=mem.MemberId;
              MemPar=MemPar+c.id;
            
            if(Map_MemCase.get(MemPar)==null){
                if(Map_USRAcc.get(mem.MemberId) == c.ClaimantFirm__c){
                      CaseTeamMember CaseTeamMember = new CaseTeamMember(MemberId=mem.MemberId,TeamRoleId = ClaimTeamRole[0].id,ParentId = c.id);  
                      lst_NewCaseTeamMember.Add(CaseTeamMember);
                }
                else if(Map_USRAcc.get(mem.MemberId) == c.Defendant_Firm__c){
                      CaseTeamMember CaseTeamMember = new CaseTeamMember(MemberId=mem.MemberId,TeamRoleId = DefTeamRole[0].id,ParentId = c.id);  
                      lst_NewCaseTeamMember.Add(CaseTeamMember);
                }
            }
        }
    }
   
   if(lst_NewCaseTeamMember.size()>0){
       insert lst_NewCaseTeamMember;
   }
  } 
   
}

Public Static void BulkRemoveSupervisor(List<Contact> lstContact){

     Set<String> Set_Acc = new Set<String>();
     Set<String> Set_Con = new Set<String>();
     Set<String> Set_User = new Set<String>();
     Set<String> Set_UserInactive = new Set<String>();
     Set<String> Set_Case = new Set<String>();
     
    
    for(Contact con:lstContact){
         
            Set_Acc.add(con.AccountId);
            Set_Con.add(con.id);
           
    }
    
   if(Set_Acc.size()>0){  
       User[] lst_User =  [SELECT id,ContactId FROM User Where ContactId in: Set_Con];
       Case[] Lst_Case = [Select id,ClaimantFirm__c,Defendant_Firm__c From Case Where (Defendant_Firm__c in: Set_Acc OR ClaimantFirm__c in:Set_Acc) AND (Stage__c='Registration' OR Stage__c='Negotiation')];
       
     system.debug('***REMOVE2**');
     
       for(Case c:Lst_Case){
        for( Contact con:lstContact){
              if(con.AccountId == c.Defendant_Firm__c || con.AccountId == c.ClaimantFirm__c){      
                   Set_Case.Add(c.id); 
                   for(User u:lst_User){
                       if(u.ContactId == con.id){
                           
                           system.debug('***REMOVE3**'+con.Status__c);
                           if(con.Status__c=='Removed'){
                               Set_UserInactive.add(u.id);
                           }
                           else{
                               Set_User.add(u.id);
                           }
                           
                       } 
                       
                          
                   }
              }              
         }
       }
       
       if(Set_User.size()>0){
           RemoverCaseTeamRole('Supervisor', Set_Case, Set_User);
       }
       
       if(Set_UserInactive.size()>0){
           RemoverCaseTeamRole('All', Set_Case, Set_UserInactive);
       }
        
    }

}




Public Static String returnCaseTeamRole(Id CaseId,Id UserId) {
  CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId =:CaseId AND MemberId=:UserId ];  
  
  Case[] CurrentCase = [Select OwnerId from Case where Id=:CaseId];
  
  CaseTeamRole[] TeamRole;
  
  system.debug('**CASEID**'+CaseId+'****'+CurrentCase);

  
  if(CaseTeamMember.size()>0){      
      TeamRole  = [SELECT Id,Name FROM CaseTeamRole where id=: CaseTeamMember[0].TeamRoleId];
      Return TeamRole[0].Name;
  }
  else if(CurrentCase[0].OwnerId==UserId){
      return 'Owner';
  }
  
  return '';

}

Public static id returnTeamId(){
        
        Id ContactId = UserAccessRights.returnContact();
        Firm_Team_Roles__c[] FirmTeamRoles =[Select  Contact__c ,Firm_Team__c From Firm_Team_Roles__c Where Contact__c  =: ContactId];
        
        Return FirmTeamRoles[0].Firm_Team__c;
        

}




}