Public Class StatusChangeHandler{

Public Static Boolean STATUSCHANGETRIGGER;

Public static void FromFirm(List<Account> lstOld,List<Account> lstNew){
    
    //STATUSCHANGETRIGGER = true;
    
    Map<String,String> Map_Old = new Map<String,String>();
    List<Id> lstActive = new List<Id>();
    List<Id> lstInactive = new List<Id>();
    List<Id> lstRemoved = new List<Id>();
    
    for(Account acc:lstOld){
      Map_Old.put(acc.id,acc.Status__c);        
    }
    
    for(Account acc:lstNew){
      
      if(Map_Old.get(acc.id) != null && Map_Old.get(acc.id) != acc.Status__c){
              
              if(acc.Status__c=='Active'){
                  lstActive.Add(acc.id);
              } 
              else if(acc.Status__c=='Inactive'){
                  lstInactive.Add(acc.id);
              }
              else if(acc.Status__c=='Removed'){
                  lstRemoved.Add(acc.id);
              }
                 
      }  
    }
    
   
    Boolean DeactivateValidation = false;
    if(lstActive.size()>0){
        FromFirm_Activate.ActivateAll(lstActive); 
    }
    
    if(lstInactive.size()>0){
        DeactivateValidation = FromFirm_Deactivate.DactivateAll(lstInactive);
    }
    
    if(lstRemoved.size()>0){
        DeactivateValidation = FromFirm_Remove.RemoveAll(lstRemoved);   
    }
    
    for(Account acc:lstNew){     
         acc.Deactivate_Validation__c =DeactivateValidation;
    }
    
    
    

}


Public static void FromTeam(List<Firm_Team_Roles__c> lstNew){
    
    Set<String> Set_TeamId = new Set<String>();
    Set<String> Set_TeamRoldId = new Set<String>();
    
    for(Firm_Team_Roles__c team:lstNew){                                       
                  Set_TeamId.Add(team.Firm_Team__c);
                  Set_TeamRoldId.add(team.id);        
    }
      
    system.debug('**One***'+Set_TeamId);
   if(Set_TeamId.size()>0){ 
        Firm_Team_Roles__c[] lst_FirmTeamRolesAc = [SELECT Contact__c,Roles__c,Firm_Team__c FROM Firm_Team_Roles__c where Firm_Team__c in: Set_TeamId AND id not in:Set_TeamRoldId];        
        
         system.debug('**Two***'+lst_FirmTeamRolesAc);
        if(lst_FirmTeamRolesAc.size()==0){
            
           
            
            
            
            Firm_Team__c[] lstNewTeam = [Select Must_have_Active_Members_Validation__c From Firm_Team__c where id in:Set_TeamId AND Status__c='Active'];

            if(lstNewTeam.size()>0){
                 for(Firm_Team_Roles__c team:lstNew){                                       
                  team.addError('Action cannot be performed, because at least 1 active Case Handler is required on an active team');     
                }
            /*
                    for(Firm_Team__c team:lstNewTeam){  
                          system.debug('**HOW TEAM***');          
                          team.Must_have_Active_Members_Validation__c=true;        
                        
                    }
               update lstNewTeam;*/
               
            } 
            
               
        }
   } 
}





Public static void FromTeam(List<Firm_Team__c> lstNew){
    
    Set<String> Set_TeamId = new Set<String>();
    
    
    for(Firm_Team__c team:lstNew){             
          if(team.Status__c=='Active'){
                  Set_TeamId.Add(team.id);
          }         
    }
    
    if(Set_TeamId.size()>0){
        Firm_Team_Roles__c[] lst_FirmTeamRolesAc = [SELECT Contact__c,Roles__c,Firm_Team__c FROM Firm_Team_Roles__c where Firm_Team__c in: Set_TeamId ];        
      
        if(lst_FirmTeamRolesAc.size()==0){
            for(Firm_Team__c team:lstNew){  
            system.debug('**HOW TEAM ROLE***');  
              team.addError('Action cannot be performed, because at least 1 active Case Handler is required on an active team.');         
             // team.Must_have_Active_Members_Validation__c=true;        
            }
        }
    }
}

Public static void FromTeam(List<Firm_Team__c> lstOld,List<Firm_Team__c> lstNew){
    
   //STATUSCHANGETRIGGER = true;
    
    Map<String,String> Map_Old = new Map<String,String>();
    List<Id> lstActive = new List<Id>();
    List<Id> lstInactive = new List<Id>();
    List<Id> lstRemoved = new List<Id>();
    
    for(Firm_Team__c team:lstOld){    
          Map_Old.put(team.id,team.Status__c);        
    }
    
    for(Firm_Team__c team:lstNew){
      system.debug('**TEAM0***');
      if(Map_Old.get(team.id) != null && Map_Old.get(team.id) != team.Status__c){
              system.debug('**TEAM1***'+team.Status__c);
              /*
              if(team.Status__c=='Active'){
                  lstActive.Add(team.id);
              } 
              else if(team.Status__c=='Inactive'){
                  lstInactive.Add(team.id);
              }*/
              
              if(team.Status__c=='Removed'){
                  lstRemoved.Add(team.id);
              }
                 
      }  
    }
    
   
    Boolean DeactivateValidation = false;
    /*
    if(lstActive.size()>0){
         FromFirmTeam_Activate.ActivateAllMembers(lstActive); 
    }
    
    if(lstInactive.size()>0){
        DeactivateValidation =FromFirmTeam_Deactivate.DactivateAllMembers(lstInactive);
    }
    */
    
    if(lstRemoved.size()>0){
        DeactivateValidation = FromFirmTeam_Remove.RemoveAllMembers(lstRemoved);   
    }
    
    /*
    for(Firm_Team__c team:lstNew){     
         team.Deactivate_Validation__c =DeactivateValidation;
    }
    */
    

}

Public static void FromContact(List<Contact> lstOld,List<Contact> lstNew){
    
  STATUSCHANGETRIGGER = true;
    
    Map<String,String> Map_Old = new Map<String,String>();
    List<Id> lstActive = new List<Id>();
    List<Id> lstInactive = new List<Id>();
    List<Id> lstRemoved = new List<Id>();
    List<Id> ContactID = new List<Id>();
    
    for(Contact con:lstOld){    
          Map_Old.put(con.id,con.Status__c);        
    }
    
    for(Contact con:lstNew){
      system.debug('**CONSTATUS1***');
      if(Map_Old.get(con.id) != null && Map_Old.get(con.id) != con.Status__c){
          system.debug('**CONSTATUS2***');
              /*
              if(con.Status__c=='Active'){
                  lstActive.Add(con.id);
              } 
              else if(con.Status__c=='Inactive'){
                  lstInactive.Add(con.id);
              }
              */
              
              if(con.Status__c=='Removed'){
                  lstRemoved.Add(con.id);
              }
              
              
                 
      }  
      ContactID.Add(con.id);
    }
    
    
   
   
    Boolean DeactivateValidation = false;
    /*
    if(lstActive.size()>0){
        system.debug('**CONSTATUSAC***');
         FromContact_Activate.ActivateAllMembers(lstActive); 
    }
    
    
    if(lstInactive.size()>0){
        system.debug('**CONSTATUSINACT***');
        DeactivateValidation =FromContact_Deactivate.DeactivateAllMembers(lstInactive);
    }
    */
    
    if(lstRemoved.size()>0){
        DeactivateValidation = FromContact_Remove.RemoveAllMembers(lstRemoved);   
    }
    
    for(Contact con:lstNew){     
         con.Deactivate_Validation__c =DeactivateValidation;
    }

    if(UserHandler.STOPUSERTRIGGER != true){
        UserHandler.updateContactUserDetails(ContactID);
    } 
    
    
}





}