Public Class CaseNotificationHandler{


public static void NotifyBilateralDate(Set<String> Set_CaseID){
    
       system.debug('**Set_CaseID**'+Set_CaseID); 
     
     Date todayDate = system.today();
        
     List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,Case__c,Bilateral_Prior_Notification_date__c,Doc_Prep_End_Date__c,Defendant_Accept_Decline__c,Claimant_Accept_Decline__c,Claimaint_Arbitration_Submitted__c,Defendant_Arbitration_Submitted__c, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c 
                         From Schedule_of_Losses__c Where Case__c in: Set_CaseID 
                         AND Bilateral_Prior_Notification_date__c =:todayDate AND Bilateral_Prior_Notification_days__c >:0]);
        
        
     
      CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:Set_CaseID AND (TeamRole.Name='Claimant Handler' OR TeamRole.Name='Defendant Handler')];  
  
      Set<String> Set_User = new Set<String>();
      Map<String,String> Map_MemRoleid = new Map<String,String>();
      Map<String,String> Map_MemRoleName = new Map<String,String>();
      
      for(CaseTeamMember mem:CaseTeamMember){
          Set_User.add(mem.MemberId);
          Map_MemRoleid.put(mem.TeamRoleId,mem.MemberId);      
      }
      
      CaseTeamRole[] TeamRole;
      
      if(CaseTeamMember.size()>0){      
          TeamRole  = [SELECT Id,Name FROM CaseTeamRole where id in: Map_MemRoleid.keyset()];
      
      
      
          for(CaseTeamRole role:TeamRole){
              Map_MemRoleName.put(Map_MemRoleid.get(role.Id),role.name);      
          }
      }
     
      User[] lst_User =  [SELECT email,FirstName,LastName FROM User Where id in: Map_MemRoleid.values()]; 
      
      
      List<Case_Notification__c> lst_Notify = new List<Case_Notification__c>();
        
      for(Schedule_of_Losses__c s:ScheduleofLosses){
        
        for(User u:lst_User){
                       
                       
                      if(Map_MemRoleName.get(u.id)=='Claimant Handler' || Map_MemRoleName.get(u.id)=='Defendant Handler'){
                          Case_Notification__c notify = new Case_Notification__c();
                           notify.Case_Progresses_to_Unilateral_Referral__c = true;
                           notify.Case_Member_Email__c = u.email;
                           notify.User__c = u.id;
                           Notify.Case__c = s.Case__c;
                           Notify.Due_Date__c = s.Bilateral_Prior_Notification_date__c;
                          lst_Notify.add(notify);
                      }
          }
     }  
     
     if(lst_Notify.size()>0){
         insert lst_Notify;
     } 
       
}

public static void NotifyUnilateralDate(Set<String> Set_CaseID){
    
       system.debug('**Set_CaseID**'+Set_CaseID); 
     
     Date todayDate = system.today();
        
     List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,Unilateral_Prior_Notification_date__c,Case__c,Doc_Prep_End_Date__c,Defendant_Accept_Decline__c,Claimant_Accept_Decline__c,Claimaint_Arbitration_Submitted__c,Defendant_Arbitration_Submitted__c, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c 
                         From Schedule_of_Losses__c Where Case__c in: Set_CaseID 
                         AND Unilateral_Prior_Notification_date__c=:todayDate AND Unilateral_Prior_Notification_days__c >:0]);
        
        
     
      CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:Set_CaseID AND (TeamRole.Name='Claimant Handler' OR TeamRole.Name='Defendant Handler')];  
  
      Set<String> Set_User = new Set<String>();
      Map<String,String> Map_MemRoleid = new Map<String,String>();
      Map<String,String> Map_MemRoleName = new Map<String,String>();
      
      for(CaseTeamMember mem:CaseTeamMember){
          Set_User.add(mem.MemberId);
          Map_MemRoleid.put(mem.TeamRoleId,mem.MemberId);      
      }
      
      CaseTeamRole[] TeamRole;
      
      if(CaseTeamMember.size()>0){      
          TeamRole  = [SELECT Id,Name FROM CaseTeamRole where id in: Map_MemRoleid.keyset()];
      
     
          for(CaseTeamRole role:TeamRole){
              Map_MemRoleName.put(Map_MemRoleid.get(role.Id),role.name);      
          }
     }
     
      User[] lst_User =  [SELECT email,FirstName,LastName FROM User Where id in: Map_MemRoleid.values()]; 
      
      
      List<Case_Notification__c> lst_Notify = new List<Case_Notification__c>();
        
      for(Schedule_of_Losses__c s:ScheduleofLosses){
        
        for(User u:lst_User){
                       
                       
                      if(Map_MemRoleName.get(u.id)=='Claimant Handler' || Map_MemRoleName.get(u.id)=='Defendant Handler'){
                          Case_Notification__c notify = new Case_Notification__c();
                           notify.X5_Days_to_End_of_Negotiation__c = true;
                           notify.Case_Member_Email__c = u.email;
                           notify.User__c = u.id;
                           Notify.Case__c = s.Case__c;
                           Notify.Due_Date__c = s.Unilateral_Prior_Notification_date__c;
                          lst_Notify.add(notify);
                      }
          }
     }  
     
     if(lst_Notify.size()>0){
         insert lst_Notify;
     } 
       
}

public static void NotifyDocPrepStatus(Set<String> Set_CaseID){
    
       system.debug('**Set_CaseID**'+Set_CaseID); 
     
     Date todayDate = system.today();
        
     List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,Case__c,Doc_Prep_End_Date__c,Defendant_Accept_Decline__c,Claimant_Accept_Decline__c,Claimaint_Arbitration_Submitted__c,Defendant_Arbitration_Submitted__c, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c 
                         From Schedule_of_Losses__c Where Case__c in: Set_CaseID 
                         AND Doc_Prep_Start_Date__c=:todayDate ]);
        
        
     
      CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:Set_CaseID AND (TeamRole.Name='Claimant Handler' OR TeamRole.Name='Defendant Handler')];  
  
      Set<String> Set_User = new Set<String>();
      Map<String,String> Map_MemRoleid = new Map<String,String>();
      Map<String,String> Map_MemRoleName = new Map<String,String>();
      
      for(CaseTeamMember mem:CaseTeamMember){
          Set_User.add(mem.MemberId);
          Map_MemRoleid.put(mem.TeamRoleId,mem.MemberId);      
      }
      
      CaseTeamRole[] TeamRole;
      
      if(CaseTeamMember.size()>0){      
          TeamRole  = [SELECT Id,Name FROM CaseTeamRole where id in: Map_MemRoleid.keyset()];
      
     
          for(CaseTeamRole role:TeamRole){
              Map_MemRoleName.put(Map_MemRoleid.get(role.Id),role.name);      
          }
     }
     
      User[] lst_User =  [SELECT email,FirstName,LastName FROM User Where id in: Map_MemRoleid.values()]; 
      
      
      List<Case_Notification__c> lst_Notify = new List<Case_Notification__c>();
        
      for(Schedule_of_Losses__c s:ScheduleofLosses){
        
        for(User u:lst_User){
                       
                       
                      if(Map_MemRoleName.get(u.id)=='Claimant Handler' || Map_MemRoleName.get(u.id)=='Defendant Handler'){
                          Case_Notification__c notify = new Case_Notification__c();
                           notify.Select_Submit_Documents_for_Arbitration__c = true;
                           notify.Case_Member_Email__c = u.email;
                           notify.User__c = u.id;
                           Notify.Case__c = s.Case__c;
                           Notify.Due_Date__c = s.Doc_Prep_End_Date__c;
                          lst_Notify.add(notify);
                      }
          }
     }  
     
     if(lst_Notify.size()>0){
         insert lst_Notify;
     } 
       
}


public static void NotifyDocPrepStatus_PriortoEnd(Set<String> Set_CaseID){
    
       system.debug('**Set_CaseID**'+Set_CaseID); 
     
     Date todayDate = system.today();
        
     List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,Case__c,Doc_Prep_End_Date__c,Defendant_Accept_Decline__c,Claimant_Accept_Decline__c,Claimaint_Arbitration_Submitted__c,Defendant_Arbitration_Submitted__c, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c 
                         From Schedule_of_Losses__c Where Case__c in: Set_CaseID 
                         AND Doc_Prep_prior_Notification_date__c=:todayDate AND Doc_Prep_prior_Notification_days__c >:0]);
        
        
     
      CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:Set_CaseID AND (TeamRole.Name='Claimant Handler' OR TeamRole.Name='Defendant Handler')];  
  
      Set<String> Set_User = new Set<String>();
      Map<String,String> Map_MemRoleid = new Map<String,String>();
      Map<String,String> Map_MemRoleName = new Map<String,String>();
      
      for(CaseTeamMember mem:CaseTeamMember){
          Set_User.add(mem.MemberId);
          Map_MemRoleid.put(mem.TeamRoleId,mem.MemberId);      
      }
      
      CaseTeamRole[] TeamRole;
      
      if(CaseTeamMember.size()>0){      
          TeamRole  = [SELECT Id,Name FROM CaseTeamRole where id in: Map_MemRoleid.keyset()];
      
     
          for(CaseTeamRole role:TeamRole){
              Map_MemRoleName.put(Map_MemRoleid.get(role.Id),role.name);      
          }
     }
     
      User[] lst_User =  [SELECT email,FirstName,LastName FROM User Where id in: Map_MemRoleid.values()]; 
      
      
      List<Case_Notification__c> lst_Notify = new List<Case_Notification__c>();
        
      for(Schedule_of_Losses__c s:ScheduleofLosses){
        
        for(User u:lst_User){
                       
                       
                      if(Map_MemRoleName.get(u.id)=='Claimant Handler' || Map_MemRoleName.get(u.id)=='Defendant Handler'){
                           
                           Case_Notification__c notify = new Case_Notification__c();
                           
                           notify.Case_Member_Email__c = u.email;
                           notify.User__c = u.id;
                           Notify.Case__c = s.Case__c;
                           Notify.Due_Date__c = s.Doc_Prep_End_Date__c;
                         if(Map_MemRoleName.get(u.id)=='Claimant Handler'){  
                           notify.Doc_Prep_closing_Claimant_Reminder__c = true;
                         }  
                         if(Map_MemRoleName.get(u.id)=='Defendant Handler'){  
                           notify.Doc_Prep_closing_Defendant_Reminder__c = true;
                         } 
                          lst_Notify.add(notify);
                      
                      
                      }
          }
     }  
     
     if(lst_Notify.size()>0){
         insert lst_Notify;
     } 
       
}

public static void NotifyFinalOfferStatus(Set<String> Set_CaseID){
    
       system.debug('**Set_CaseID**'+Set_CaseID); 
     
     Date todayDate = system.today();
        
     List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,Final_Offers_End_Date__c,Case__c,Defendant_Accept_Decline__c,Doc_Prep_End_Date__c,Claimant_Accept_Decline__c,Claimaint_Arbitration_Submitted__c,Defendant_Arbitration_Submitted__c, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c 
                         From Schedule_of_Losses__c Where Case__c in: Set_CaseID 
                         AND Final_Offers_Start_Date__c=:todayDate ]);
        
        
     
      
      CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:Set_CaseID AND (TeamRole.Name='Claimant Handler' OR TeamRole.Name='Defendant Handler')];  
  
      Set<String> Set_User = new Set<String>();
      Map<String,String> Map_MemRoleid = new Map<String,String>();
      Map<String,String> Map_MemRoleName = new Map<String,String>();
      
      for(CaseTeamMember mem:CaseTeamMember){
          Set_User.add(mem.MemberId);
          Map_MemRoleid.put(mem.TeamRoleId,mem.MemberId);      
      }
      
      CaseTeamRole[] TeamRole;
      
      if(CaseTeamMember.size()>0){      
          TeamRole  = [SELECT Id,Name FROM CaseTeamRole where id in: Map_MemRoleid.keyset()];
      
     
          for(CaseTeamRole role:TeamRole){
              Map_MemRoleName.put(Map_MemRoleid.get(role.Id),role.name);      
          }
      }   
     
      User[] lst_User =  [SELECT email,FirstName,LastName FROM User Where id in: Map_MemRoleid.values() OR Profile.Name='System Administrator']; 
      
      
      List<Case_Notification__c> lst_Notify = new List<Case_Notification__c>();
        
      for(Schedule_of_Losses__c s:ScheduleofLosses){
        
        for(User u:lst_User){
                       
                       
                      if(Map_MemRoleName.get(u.id)=='Claimant Handler' || Map_MemRoleName.get(u.id)=='Defendant Handler'){
                           Case_Notification__c notify = new Case_Notification__c();
                           notify.Items_progress_to_Final_Offers__c = true;
                           notify.Case_Member_Email__c = u.email;
                           Notify.Case__c = s.Case__c;
                           Notify.Due_Date__c = s.Final_Offers_End_Date__c;
                           notify.User__c = u.id;
                           lst_Notify.add(notify);    
                      }
                      /*
                      else if(Map_MemRoleName.get(u.id)=='System Administrator'){
                          
                          Case_Notification__c notify = new Case_Notification__c();
                           notify.Submit_Arbitral_Award_Platform_Admin__c = true;
                           notify.Case_Member_Email__c = u.email;
                            notify.User__c = u.id;
                           lst_Notify.add(notify);
                      }
                      */
                      
          }
     }  
     
     if(lst_Notify.size()>0){
         insert lst_Notify;
     } 
       
}

public static void NotifyFinalOfferStatus_PriortoEnd(Set<String> Set_CaseID){
    
       system.debug('**Set_CaseID**'+Set_CaseID); 
     
     Date todayDate = system.today();
        
     List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,Final_Offers_End_Date__c,Case__c,Defendant_Accept_Decline__c,Doc_Prep_End_Date__c,Claimant_Accept_Decline__c,Claimaint_Arbitration_Submitted__c,Defendant_Arbitration_Submitted__c, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c 
                         From Schedule_of_Losses__c Where Case__c in: Set_CaseID 
                         AND Final_Offer_prior_Notification_date__c=:todayDate AND Final_Offers_Duration__c >:0]);
        
        
     
      
      CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:Set_CaseID AND (TeamRole.Name='Claimant Handler' OR TeamRole.Name='Defendant Handler')];  
  
      Set<String> Set_User = new Set<String>();
      Map<String,String> Map_MemRoleid = new Map<String,String>();
      Map<String,String> Map_MemRoleName = new Map<String,String>();
      
      for(CaseTeamMember mem:CaseTeamMember){
          Set_User.add(mem.MemberId);
          Map_MemRoleid.put(mem.TeamRoleId,mem.MemberId);      
      }
      
      CaseTeamRole[] TeamRole;
      
      if(CaseTeamMember.size()>0){      
          TeamRole  = [SELECT Id,Name FROM CaseTeamRole where id in: Map_MemRoleid.keyset()];
      
     
          for(CaseTeamRole role:TeamRole){
              Map_MemRoleName.put(Map_MemRoleid.get(role.Id),role.name);      
          }
      }   
     
      User[] lst_User =  [SELECT email,FirstName,LastName FROM User Where id in: Map_MemRoleid.values() OR Profile.Name='System Administrator']; 
      
      
      List<Case_Notification__c> lst_Notify = new List<Case_Notification__c>();
        
      for(Schedule_of_Losses__c s:ScheduleofLosses){
        
        for(User u:lst_User){
                       
                       
                      if(Map_MemRoleName.get(u.id)=='Claimant Handler' || Map_MemRoleName.get(u.id)=='Defendant Handler'){
                           Case_Notification__c notify = new Case_Notification__c();
                           notify.Submit_Final_Offers_for_Arbitration__c  = true;
                           notify.Case_Member_Email__c = u.email;
                           Notify.Case__c = s.Case__c;
                           Notify.Due_Date__c = s.Final_Offers_End_Date__c;
                           notify.User__c = u.id;
                           lst_Notify.add(notify);    
                      }
                      /*
                      else if(Map_MemRoleName.get(u.id)=='System Administrator'){
                          
                          Case_Notification__c notify = new Case_Notification__c();
                           notify.Submit_Arbitral_Award_Platform_Admin__c = true;
                           notify.Case_Member_Email__c = u.email;
                            notify.User__c = u.id;
                           lst_Notify.add(notify);
                      }
                      */
                      
          }
     }  
     
     if(lst_Notify.size()>0){
         insert lst_Notify;
     } 
       
}

public static void NotifyArbitratorFinal(Set<String> Set_CaseID){
    
       system.debug('**Set_CaseID**'+Set_CaseID); 
     
     Date todayDate = system.today();
        
     List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,Arbitrator_Notification_Date__c,Case__c,Defendant_Accept_Decline__c,Claimant_Accept_Decline__c,Claimaint_Arbitration_Submitted__c,Defendant_Arbitration_Submitted__c, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c 
                         From Schedule_of_Losses__c Where Case__c in: Set_CaseID 
                         AND Arbitrator_Notification_Date__c=:todayDate]);
    
      CaseTeamMember[] CaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId in:Set_CaseID AND (TeamRole.Name='Arbitrator')];  
  
      Set<String> Set_User = new Set<String>();
      Map<String,String> Map_MemRoleid = new Map<String,String>();
      Map<String,String> Map_MemRoleName = new Map<String,String>();
      
      for(CaseTeamMember mem:CaseTeamMember){
          Set_User.add(mem.MemberId);
          Map_MemRoleid.put(mem.TeamRoleId,mem.MemberId);      
      }
      
      CaseTeamRole[] TeamRole;
      
      if(CaseTeamMember.size()>0){      
          TeamRole  = [SELECT Id,Name FROM CaseTeamRole where id in: Map_MemRoleid.keyset()];
           
          for(CaseTeamRole role:TeamRole){
              Map_MemRoleName.put(Map_MemRoleid.get(role.Id),role.name);      
          }
      }
     
      User[] lst_User =  [SELECT email,FirstName,LastName FROM User Where id in: Map_MemRoleid.values() OR Profile.Name='System Administrator']; 
      
      
      List<Case_Notification__c> lst_Notify = new List<Case_Notification__c>();
        
      for(Schedule_of_Losses__c s:ScheduleofLosses){
        
        for(User u:lst_User){
                       
                       
                      if(Map_MemRoleName.get(u.id)=='Arbitrator'){
                           Case_Notification__c notify = new Case_Notification__c();
                           notify.No_Arbitral_Award_Reminder__c = true;
                           notify.Case_Member_Email__c = u.email;
                           Notify.Case__c = s.Case__c;
                           Notify.Due_Date__c = s.Arbitrator_Notification_Date__c;
                           Notify.User__c = u.id;
                           lst_Notify.add(notify);    
                      }
                    
                      
          }
     }  
     
     if(lst_Notify.size()>0){
         insert lst_Notify;
     } 
       
}

public static void NotifyMarketMakerFinal(Set<String> Set_CaseID){
    
       system.debug('**Set_CaseID**'+Set_CaseID); 
     
     Date todayDate = system.today();
        
     List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,Market_Maker_Notification_Date__c,Case__c,Defendant_Accept_Decline__c,Claimant_Accept_Decline__c,Claimaint_Arbitration_Submitted__c,Defendant_Arbitration_Submitted__c, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c 
                         From Schedule_of_Losses__c Where Case__c in: Set_CaseID 
                         AND Market_Maker_Notification_Date__c=:todayDate]);
     
      User[] lst_User =  [SELECT email,FirstName,LastName,Profile.Name FROM User Where Profile.Name='System Administrator' and Isactive=:true]; 
      
      
      List<Case_Notification__c> lst_Notify = new List<Case_Notification__c>();
        
      for(Schedule_of_Losses__c s:ScheduleofLosses){
        
        for(User u:lst_User){
                       
                       
                      if(u.Profile.Name=='System Administrator'){
                          
                          Case_Notification__c notify = new Case_Notification__c();
                           notify.No_Arbitral_Award_Response_From_Arbitrat__c = true;
                           notify.Case_Member_Email__c = u.email;
                           Notify.Due_Date__c = s.Market_Maker_Notification_Date__c;
                           Notify.Case__c = s.Case__c;
                           notify.User__c = u.id;
                           notify.Due_Date__c = system.today();
                           lst_Notify.add(notify);
                      }
                      
          }
     }  
     
     if(lst_Notify.size()>0){
         insert lst_Notify;
     } 
       
}




//Registration




public static void NotifyTeamMembersRegistration(String TeamId,String Teamtype,String CaseId,String Type ){

    
    Set<String> Set_Con = new Set<String>();
     
    Firm_Team_Roles__c[] lst_FirmTeamRoles = [SELECT Contact__c,Roles__c,Firm_Team__c FROM Firm_Team_Roles__c where Firm_Team__c =: TeamId];
     
    for(Firm_Team_Roles__c tm:lst_FirmTeamRoles){
        Set_Con.add(tm.Contact__c);   
    }
    
       
    User[] lst_User =  [SELECT email,FirstName,ContactId,LastName,Profile.Name FROM User Where Isactive=:true and ContactId in:Set_Con]; 
    
    
    List<Case_Notification__c> lst_Notify = new List<Case_Notification__c>();
    
    Decimal Finalaward;
    if(Type=='Final'){
        Finalaward = 0;
        Finalaward = NotifyDefendantFINALAWARDCase.calculatefinalamount(CaseId);
    }
    
    
    
    for(User u:lst_User){
                          Case_Notification__c notify = new Case_Notification__c();
                          if(Teamtype == 'Defendant' && Type=='NotifyTeam'){
                               notify.Defendant_Team_Added_to_Case__c = true;
                           }    
                           else if(Teamtype == 'Claimant'  && Type=='NotifyTeam'){
                               notify.Claimant_Team_Added_to_Case__c = true;   
                          } 
                          else if(Type=='AcceptDecline'){
                               notify.Accept_Decline_items_for_arbitration_sub__c = true;   
                          } 
                          else if(Type=='SubmitDocuments'){
                               notify.Select_Submit_Documents_for_Arbitration__c = true;   
                          } 
                          else if(Type=='FinalOffers'){
                               notify.Submit_Final_Offers_for_Arbitration__c = true;   
                          } 
                          else if(Type=='ArbitratorSubmits'){
                               notify.Submit_Arbitral_Award_Arbitrator__c = true;   
                          } 
                          else if(Type=='Final'){
                                notify.Final_Award__c = Finalaward; 
                                notify.Case_Progresses_to_Finalisation__c = true;  
                          }
                         
                           notify.CurrencyIsoCode = 'GBP';
                           notify.Case_Member_Email__c =  u.email;
                           notify.Defendant_Firm_Email__c =  u.email;
                           notify.Case__c = CaseId;
                           notify.User__c = u.id;
                           lst_Notify.add(notify);
    }
     
    system.debug('**lst_Notify**'+lst_Notify); 
    insert lst_Notify;
    

}

@future
public static void NotifySupervisorsRegistration(Set<String> Set_Con,String Teamtype,String CaseId ){

      
    User[] lst_User =  [SELECT email,FirstName,ContactId,LastName,Profile.Name FROM User Where  Isactive=:true and ContactId in:Set_Con]; 
       
    List<Case_Notification__c> lst_Notify = new List<Case_Notification__c>();
    
    for(User u:lst_User){
                          Case_Notification__c notify = new Case_Notification__c();
                          if(Teamtype == 'Defendant' ){
                               notify.Defendant_Team_Added_to_Case_Task__c = true;
                           }    
                           else if(Teamtype == 'Claimant'){
                               notify.Defendant_Team_Added_to_Case_Task__c = true;   
                          } 
                          
                           notify.Case_Member_Email__c = u.email;
                           notify.Case__c = CaseId;
                           notify.User__c = u.id;
                           notify.Due_Date__c = system.today();
                           lst_Notify.add(notify);
    }
     
    system.debug('**lst_Notify**'+lst_Notify); 
    insert lst_Notify;
    

}


public static void NotifyCancelled(Set<String> Set_Con,String Teamtype,String CaseId ){

      
    User[] lst_User =  [SELECT email,FirstName,ContactId,LastName,Profile.Name FROM User Where  Isactive=:true and Id in:Set_Con]; 
       
    List<Case_Notification__c> lst_Notify = new List<Case_Notification__c>();
    
    for(User u:lst_User){
                          Case_Notification__c notify = new Case_Notification__c();
                          
                          notify.Case_Cancelled__c=true;
                          
                           notify.Case_Member_Email__c = u.email;
                           notify.Case__c = CaseId;
                           notify.User__c = u.id;
                           notify.Due_Date__c = system.today();
                           lst_Notify.add(notify);
    }
     
    system.debug('**lst_Notify**'+lst_Notify); 
    insert lst_Notify;
    

}



}