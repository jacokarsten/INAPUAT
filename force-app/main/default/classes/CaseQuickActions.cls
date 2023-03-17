Public without sharing class CaseQuickActions{

Public Case CaseQuick{get;set;}
Public String ErrorMsg{get;set;}

Public List<SelectOption> DefFirmOptions {get;set;}    
Public String DefFirm {get;set;}

Public List<SelectOption> ClaimFirmOptions {get;set;}    
Public String ClaimFirm {get;set;}

Public List<SelectOption> FacFirmOptions {get;set;}    
Public String FacCon {get;set;} 

Public List<SelectOption> ArbFirmOptions {get;set;}    
Public String ArbCon {get;set;}    
  
Public ContentVersion AcceptArbitration {get;set;}  
    
 Public Id StartRecId;   
  Public String LOGGEDINUSER {get;set;}   
  
 Public boolean ShowActions {get;set;} 
 
 Public boolean ShowArbitrator {get;set;} 
 Public boolean ShowFacilitator {get;set;} 
 Public boolean ShowDefendant {get;set;} 
 Public boolean ShowClaimant {get;set;}   
    
 Public Schedule_of_Losses__c ScheduleofLoss {get;set;}   
    
 public CaseQuickActions(ApexPages.StandardController controller) {   
    
      ShowActions = false;    
      ShowArbitrator = false;
      ShowFacilitator = false;
      ShowDefendant = false;
      ShowClaimant = false;
      
      Case CQuick = new Case();
      CQuick = (Case)controller.getRecord();
      StartRecId = apexpages.currentpage().getparameters().get('id');
      
     
    //system.debug('**Case**'+CQuick.id);
      
      CaseQuick = [Select id,Arbitration_Accept_Date__c,Arbitrator_Contact__r.lastName,Arbitrator_Contact__r.firstName,Facilitator_Contact__r.firstName, Facilitator_Contact__r.lastName,Claimant_Firm_Team__r.name,Defendant_Firm_Team__r.name,Subject,Defendant_Internal_Reference_Number__c,Claimant_Internal_Reference_Number__c,Arbitration_Final_Offers_Count__c,Arbitration_Prep_Count__c,Merit_Arbitrated_Count__c,Merit_Arbitration_Count__c,Merit_Negotiation_Count__c,Merit_Settled_Count__c,Generate_Arbitration_Document__c,Arbitrator_Accept_Decline__c,Claimant_Confirms_Case_Settled__c,Generate_Notice_of_Commencement__c,Invite_Arbitrator__c,Status,Settled_Status_Count__c ,Arbitrator_Contact__c ,Arbitration_Completed_Count__c ,Arbitration_Negotiation_Count__c,Settlement_Negotiation_Status_Count__c,Submit_Schedule_of_Losses__c,Submit_Case__c,Defendent_rejection_reason__c ,Stage__c,Defendant_Agree_to_Arbitration_Process__c,Defendant_Accept_Reject__c ,Submit_Schedule_of_Losses_Defendant__c,Arbitration_Firm__c,Agree_to_Arbitration_Process__c, Claimant_Firm_Team__c,ClaimantFirm__c,Claimant_Minimum_Personal_Details__c,Defendant_Minimum_Personal_Details__c,Facilitator_Firm__c,Facilitator_Contact__c,Defendant_Firm_Team__c,Defendant_Firm__c,Total_Obligation__c,Protocol__r.Mininmum_Schedule__c,Merit_Minimum_Requirements__c from Case Where id =:StartRecId]; //CQuick.Id
      ErrorMsg='false';
      ShowFirmTeamsDefendant();
      ShowFacilitatorContact();
      ShowFirmTeamsClaimant();
      ShowArbitrationContact();
      
      Schedule_of_Losses__c[] tmpScheduleofLoss = [Select Automated_Doc_Prep_Start_Date__c,Bilateral_Length_days__c,Unilateral_Length_days__c,No_referral_Length_days__c,Accept_Case_New_Arbitration_Date__c,Unilateral_Start_Date__c,Bilateral_Start_Date__c,Doc_Prep_End_Date__c,Arbitrators_Award_Finalised__c,Final_Offers_Duration__c,Doc_Prep_Duration__c,Arbitration_Start_Date__c,No_referral_date__c,Bilateral_referral_date__c,Unilateral_referral_date__c,Doc_Prep_Start_Date__c,Final_Offers_Start_Date__c,Final_Offers_End_Date__c from  Schedule_of_Losses__c where  Case__c =:StartRecId limit 1];
      if(tmpScheduleofLoss.size()>0){
          ScheduleofLoss = tmpScheduleofLoss[0];
      }
          
       LOGGEDINUSER = UserAccessRights.ProfileName(CaseQuick.id);
       
       system.debug('**LOGGEDINUSER**'+LOGGEDINUSER);
       system.debug('**CaseQuick.Status**'+CaseQuick.Status);
       
       if((LOGGEDINUSER == 'Defendant Handler' || LOGGEDINUSER == 'Claimant Handler' || LOGGEDINUSER == 'Owner') && (CaseQuick.Status=='Created' || CaseQuick.Status=='Pending_Acceptance')){
           ContentVersion[] Content = [SELECT Case_Id__c,Document_Source__c,ContentDocumentId,Submitted_for_Arbitration_By__c,FileType,INAP_Doc_Type__c,Loss_Item_ID__c,Sharing_Permissions__c,Title FROM ContentVersion  where Title like 'AcceptAr%' limit 1];
           
           system.debug('**HANDLER**');
           if(Content.size()>0){
               
               AcceptArbitration = Content[0];  
           }    
       }     
    }



Public CaseQuickActions(){
    /*   
    Case CQuick = new Case();
      StartRecId = apexpages.currentpage().getparameters().get('id');
      
     
    //system.debug('**Case**'+CQuick.id);
      
      CaseQuick = [Select id,Arbitration_Accept_Date__c,Arbitrator_Contact__r.lastName,Arbitrator_Contact__r.firstName,Facilitator_Contact__r.firstName, Facilitator_Contact__r.lastName,Claimant_Firm_Team__r.name,Defendant_Firm_Team__r.name,Defendant_Internal_Reference_Number__c,Claimant_Internal_Reference_Number__c,Arbitration_Final_Offers_Count__c,Arbitration_Prep_Count__c,Merit_Arbitrated_Count__c,Merit_Arbitration_Count__c,Merit_Negotiation_Count__c,Merit_Settled_Count__c,Generate_Arbitration_Document__c,Arbitrator_Accept_Decline__c,Claimant_Confirms_Case_Settled__c,Generate_Notice_of_Commencement__c,Invite_Arbitrator__c,Status,Settled_Status_Count__c ,Arbitrator_Contact__c ,Arbitration_Completed_Count__c ,Arbitration_Negotiation_Count__c,Settlement_Negotiation_Status_Count__c,Submit_Schedule_of_Losses__c,Submit_Case__c,Defendent_rejection_reason__c ,Stage__c,Defendant_Agree_to_Arbitration_Process__c,Defendant_Accept_Reject__c ,Submit_Schedule_of_Losses_Defendant__c,Arbitration_Firm__c,Agree_to_Arbitration_Process__c, Claimant_Firm_Team__c,ClaimantFirm__c,Claimant_Minimum_Personal_Details__c,Defendant_Minimum_Personal_Details__c,Facilitator_Firm__c,Facilitator_Contact__c,Defendant_Firm_Team__c,Defendant_Firm__c,Total_Obligation__c,Protocol__r.Mininmum_Schedule__c,Merit_Minimum_Requirements__c from Case Where id =:StartRecId]; //CQuick.Id
      ErrorMsg='false';
      ShowFirmTeamsDefendant();
      ShowFacilitatorContact();
      ShowFirmTeamsClaimant();
      ShowArbitrationContact();
      
      Schedule_of_Losses__c[] tmpScheduleofLoss = [Select Accept_Case_New_Arbitration_Date__c,Final_Offers_Duration__c,Arbitration_Start_Date__c,No_referral_date__c,Bilateral_referral_date__c,Unilateral_referral_date__c from  Schedule_of_Losses__c where  Case__c =:StartRecId limit 1];
      if(tmpScheduleofLoss.size()>0){
          ScheduleofLoss = tmpScheduleofLoss[0];
      }
          
       LOGGEDINUSER = UserAccessRights.ProfileName(CaseQuick.id);
*/    
} 



Public void checkMinRequirements(){

 CaseQuick = [Select id,Arbitrator_Contact__r.lastName,Arbitrator_Contact__r.firstName,Facilitator_Contact__r.firstName, Facilitator_Contact__r.lastName,Claimant_Firm_Team__r.name,Defendant_Firm_Team__r.name,Defendant_Internal_Reference_Number__c,Claimant_Internal_Reference_Number__c,Arbitration_Final_Offers_Count__c,Arbitration_Prep_Count__c,Arbitrator_Accept_Decline__c,Merit_Arbitrated_Count__c,Merit_Arbitration_Count__c,Merit_Negotiation_Count__c,Merit_Settled_Count__c,Claimant_Confirms_Case_Settled__c,Generate_Arbitration_Document__c,Status,Generate_Notice_of_Commencement__c,Invite_Arbitrator__c,Arbitrator_Contact__c ,Settled_Status_Count__c ,Arbitration_Completed_Count__c ,Arbitration_Negotiation_Count__c,Settlement_Negotiation_Status_Count__c,Submit_Schedule_of_Losses__c,Submit_Case__c,Defendent_rejection_reason__c ,Stage__c,Defendant_Agree_to_Arbitration_Process__c,Defendant_Accept_Reject__c ,Submit_Schedule_of_Losses_Defendant__c,Arbitration_Firm__c,Agree_to_Arbitration_Process__c, Claimant_Firm_Team__c,ClaimantFirm__c,Claimant_Minimum_Personal_Details__c,Defendant_Minimum_Personal_Details__c,Facilitator_Firm__c,Facilitator_Contact__c,Defendant_Firm_Team__c,Defendant_Firm__c,Total_Obligation__c,Protocol__r.Mininmum_Schedule__c,Merit_Minimum_Requirements__c from Case Where id =:StartRecId]; //CQuick.Id
    
}

Public Claimant_Information__c Claimant {get;set;}
Public Defendant_Information__c Defendant {get;set;}
Public String DateofBirth {get;set;}

Public void loadClaimant(){
    Claimant_Information__c[] Claimant_Information = [Select id,Claimant_First_Name__c,Claimant_Last_Name__c,Claimant_Date_of_Birth__c From Claimant_Information__c  where Case__c =:CaseQuick.id limit 1];
    Claimant = new Claimant_Information__c();
    Claimant = Claimant_Information[0];
}

Public void UpdateClaimant(){
    try{
        update Claimant;
    }
    catch (exception e){
    
    }
}

Public void loadDefedant(){
    Defendant_Information__c[] Defendant_Information = [Select Defendant_First_Name__c,Defendant_Date_of_Birth__c From Defendant_Information__c where Case__c =:CaseQuick.id limit 1];
    Defendant = new Defendant_Information__c();
    Defendant = Defendant_Information[0]; 
}

Public void UpdateDefendant(){
    try{
        update Defendant;
    }
    catch (exception e){
    
    }
}

/*
Public void subjectChange(){

//CaseQuick.subject='FinalTest';
    CaseQuick.Arbitration_Firm__c ='0015E00000jJ6olQAC';
    Update CaseQuick;

}
*/


Public void ShowFirmTeamsDefendant(){
        DefFirmOptions = new List<SelectOption>(); 
        
        Firm_Team__c[] Firm_Team;
        
        if(CaseQuick.Defendant_Firm_Team__c != null){
            Firm_Team = [Select id,Name,Status__c from Firm_Team__c Where Firm__c =:CaseQuick.Defendant_Firm__c AND Status__c ='Active' AND id !=:CaseQuick.Defendant_Firm_Team__c];
            DefFirmOptions.add(new SelectOption(CaseQuick.Defendant_Firm_Team__c , CaseQuick.Defendant_Firm_Team__r.name));
        }
        else{
            Firm_Team = [Select id,Name,Status__c from Firm_Team__c Where Firm__c =:CaseQuick.Defendant_Firm__c AND Status__c ='Active' ];      
        }
        
        for(Firm_Team__c  firm:Firm_Team){       
            DefFirmOptions.add(new SelectOption(firm.id , firm.name));
        }

}

Public void ShowFirmTeamsClaimant(){
        ClaimFirmOptions = new List<SelectOption>(); 
        Firm_Team__c[] Firm_Team;
                
        system.debug('**Claim**'+Firm_Team);
        if(CaseQuick.Claimant_Firm_Team__c != null){
            Firm_Team = [Select id,Name from Firm_Team__c Where Firm__c =:CaseQuick.ClaimantFirm__c AND Status__c ='Active' AND id !=:CaseQuick.Claimant_Firm_Team__c];
            ClaimFirmOptions.add(new SelectOption(CaseQuick.Claimant_Firm_Team__c , CaseQuick.Claimant_Firm_Team__r.name));
        }
        else{
            Firm_Team = [Select id,Name from Firm_Team__c Where Firm__c =:CaseQuick.ClaimantFirm__c AND Status__c ='Active'];
        
        }
        
        for(Firm_Team__c  firm:Firm_Team){       
             ClaimFirmOptions.add(new SelectOption(firm.id , firm.name));
        }

}


Public void ShowFacilitatorContact(){
        FacFirmOptions = new List<SelectOption>(); 
        
        Contact[] Facilitator = [Select id,Firstname,LastName from Contact Where AccountId =:CaseQuick.Facilitator_Firm__c AND Status__c ='Active' AND Role__c= 'Facilitator'];
        
        
        if(CaseQuick.Facilitator_Contact__c != null){
            Facilitator = [Select id,Firstname,LastName from Contact Where AccountId =:CaseQuick.Facilitator_Firm__c AND Status__c ='Active' AND Role__c= 'Facilitator' AND id !=:CaseQuick.Facilitator_Contact__c];        
            FacFirmOptions.add(new SelectOption(CaseQuick.Facilitator_Contact__c , CaseQuick.Facilitator_Contact__r.firstName+' '+CaseQuick.Facilitator_Contact__r.lastName));
        }
        else{
            Facilitator = [Select id,Firstname,LastName from Contact Where AccountId =:CaseQuick.Facilitator_Firm__c AND Status__c ='Active' AND Role__c= 'Facilitator'];
        
        }
        
        for(Contact con:Facilitator){       
            FacFirmOptions.add(new SelectOption(con.id , con.firstName+' '+con.lastName));
        }

}




Public void ShowArbitrationContact(){
        ArbFirmOptions = new List<SelectOption>(); 
        
        Contact[] Arbitrator;
        
        if(CaseQuick.Arbitrator_Contact__c != null){
             Arbitrator = [Select id,Firstname,LastName from Contact Where AccountId =:CaseQuick.Arbitration_Firm__c AND Status__c ='Active' AND Role__c= 'Arbitrator' AND id !=:CaseQuick.Arbitrator_Contact__c ];                
            ArbFirmOptions.add(new SelectOption(CaseQuick.Arbitrator_Contact__c, CaseQuick.Arbitrator_Contact__r.firstName+' '+CaseQuick.Arbitrator_Contact__r.lastName));
        } 
        else{
             Arbitrator = [Select id,Firstname,LastName from Contact Where AccountId =:CaseQuick.Arbitration_Firm__c AND Status__c ='Active' AND Role__c= 'Arbitrator'];        
        }
               
        for(Contact con:Arbitrator){       
            ArbFirmOptions.add(new SelectOption(con.id , con.firstName+' '+con.lastName));
        }
        

}

Public void addDefendentFirm(){
    
    
    
        
       
    try{  
    if(CaseQuick.Defendant_Firm__c != null && CaseQuick.Subject != null ){
            Defendant_Firm__c[] defFirm = [Select id from Defendant_Firm__c where Case__c=:CaseQuick.id];
            
            Schedule_of_Losses__c[] ScheduleLosses = [Select id,Case__c from Schedule_of_Losses__c where Case__c=:CaseQuick.id ];
            
            defFirm[0].Firm__c = CaseQuick.Defendant_Firm__c;
            update defFirm;
            
            
            Defendant_Firm_Schedule_of_Loss__c DefendantSchedule = new Defendant_Firm_Schedule_of_Loss__c();
            DefendantSchedule.Defendant_Firm__c = defFirm[0].id;
            DefendantSchedule.Schedule_of_Losses__c = ScheduleLosses[0].id;
            Insert DefendantSchedule;
            
            CaseQuick.Claimant_Firm_Team__c = CaseMemberHandler.returnTeamId();
            
            update CaseQuick;
        }     
    
    
       }
            
   
    catch(exception e){
    
    }
    
}

Public void ChangeDefendentFirm(){
    
   Defendant_Firm__c[] CurdefFirm = [Select id,Firm_Team__c from Defendant_Firm__c where Case__c=:CaseQuick.id]; 
    
    try{     
            CurdefFirm[0].Firm__c = CaseQuick.Defendant_Firm__c;
            CaseQuick.Defendant_Firm_Team__c = null; 
            update CurdefFirm;
            update CaseQuick;  
            ShowFirmTeamsDefendant();          
    }
    catch(exception e){
    
    }   
}


Public void ChangeDefendentFirmTeam(){

    Defendant_Firm__c[] CurdefFirm = [Select id,Firm_Team__c from Defendant_Firm__c where Case__c=:CaseQuick.id];    
    try{
        
        CurdefFirm[0].Firm_Team__c = DefFirm;
        update CurdefFirm;
        CaseQuick.Defendant_Firm_Team__c = DefFirm;
        update CaseQuick;
        
    }    
    catch(exception e){
        ErrorMsg='true';
        ApexPages.addMessages(e);
    }
}



Public void updateDefTeam(){

    

    Defendant_Firm__c[] CurdefFirm = [Select id,Firm_Team__c from Defendant_Firm__c where Case__c=:CaseQuick.id];

    try{
        CurdefFirm[0].Firm_Team__c = DefFirm;
        CaseQuick.Defendant_Firm_Team__c = DefFirm;
        CaseQuick.status='Pending_Acceptance';
        update CaseQuick;
        update CurdefFirm;
    }    
    catch(exception e){
        ErrorMsg='true';
        ApexPages.addMessages(e);
    }

}


Public void updateClaim(){

    try{
        CaseQuick.Claimant_Firm_Team__c = null;
        update CaseQuick;
        ShowFirmTeamsClaimant();
    }    
    catch(exception e){
        ErrorMsg='true';
        ApexPages.addMessages(e);
    }


}

Public void updateClaimTeam(){

try{
        CaseQuick.Claimant_Firm_Team__c = ClaimFirm;
        update CaseQuick;
    }    
    catch(exception e){
        ErrorMsg='true';
        ApexPages.addMessages(e);
    }


}




Public void AgreeArbitration(){

    CaseQuick.Agree_to_Arbitration_Process__c=true;
        try{
            update CaseQuick;
        }    
        catch(exception e){
            ErrorMsg='true';
            ApexPages.addMessages(e);
        }
}
 
Public void updaterefer(){

    CaseQuick.status='Referred';
    try{
        
        User[] UOwner = [Select id from User where (Profile.Name = 'System Administrator' OR Profile.Name = 'Market Maker') AND Isactive=:true ];
        CaseQuick.OwnerId =  UOwner[0].id;
           
        
        update CaseQuick;
    }    
    catch(exception e){
        ErrorMsg='true';
        ApexPages.addMessages(e);
        system.debug('**Refer Error**'+e);
    }
}
 
Public void AcceptReject(){
    ErrorMsg='';
    
    if(CaseQuick.Defendant_Accept_Reject__c!=null){
        try{
            CaseQuick.Defendant_Accept_Decline_Date__c = system.today();
            if(CaseQuick.Defendant_Accept_Reject__c=='Accept'){
            
                CaseQuick.Status='Negotiating';
                CaseQuick.Stage__c='Negotiation';
                CaseQuick.Generate_Notice_of_Commencement__c = true;
            
                List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id, Accept_Case_New_Arbitration_Date__c From Schedule_of_Losses__c Where Case__c =: CaseQuick.id ]);
            
            
                ScheduleofLosses[0].Accept_Case_New_Arbitration_Date__c = system.today();
                        system.debug('***TEST1**');
             update CaseQuick;
                        system.debug('***TEST2**');
                update ScheduleofLosses;
               system.debug('***ACCEPT**'+CaseQuick.Protocol__r.Mininmum_Schedule__c);
           
              List<Loss_Category__c> LossCategory = new List<Loss_Category__c>([SELECT id,Schedule_of_Losses__c,Loss_Category_Types__r.Name FROM Loss_Category__c where Case__c =:CaseQuick.id]);
                          
              List<Loss_Sub_Categories__c> LossSubCategories = new List<Loss_Sub_Categories__c>([SELECT Id,Arbitration_Referred_By__c,Arbitration_Accepted_Status__c,Past_Future_Financial_Item__c, Sub_Category__c,Defendant_Position__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where Loss_Category__c in:  LossCategory ]);
               List<Merit__c> lstMerit = new List<Merit__c>([Select id,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Related_Case__c =:CaseQuick.id]);
                                   
             if(CaseQuick.Protocol__r.Mininmum_Schedule__c=='Merit and Damages Required'){   
                         for(Loss_Sub_Categories__c  loss:LossSubCategories){
                              loss.Status__c = 'Arbitration Doc Prep';
                              loss.Arbitration_Accepted_Status__c = 'Accepted';
                              loss.Arbitration_Referred_By__c = 'Claimant Handler';
                          }
                          
                         
                         for(Merit__c m:lstMerit){
                             m.Status__c = 'Arbitration Doc Prep';
                             m.Arbitration_Referred_By__c='Claimant Handler';
                             m.Arbitration_Accepted_Status__c ='Accepted';
                         }
                         update lstMerit;
                         update   LossSubCategories;
                         
                         system.debug('***LOSS**'+LossSubCategories[0].Status__c);
             
             } 
             else{
                         for(Loss_Sub_Categories__c  loss:LossSubCategories){
                            if(loss.Status__c == 'Created'){
                              loss.Status__c = 'Negotiating';
                            }  
                          }
                          
                         
                         for(Merit__c m:lstMerit){
                             if(m.Status__c == 'Created'){
                                 m.Status__c = 'Negotiating';
                              }    
                         }
                         update lstMerit;
                         update   LossSubCategories;
             
             }
         }
        else{
                CaseQuick.Status='Rejected';
                CaseQuick.Stage__c='Closed';
                update CaseQuick;
        } 
            
        }    
        catch(exception e){
            ErrorMsg='true';
            ApexPages.addMessages(e);
            system.debug('**Error**'+e);
        }
     }
     else{
         ErrorMsg='Please chose an option!';
     }
     
        
     //   CaseMemberHandler.RemoverCaseTeamRole('Supervisor', CaseQuick.Id);
        
        
}    

Public void Facilitator(){

        try{
                 CaseQuick.Facilitator_Contact__c = null;
                 update CaseQuick;
                ShowFacilitatorContact(); 
        }    
        catch(exception e){
            system.debug('**FAC**'+e);
            ErrorMsg='true';
            ApexPages.addMessages(e);
            
        }
         
       
}
Public void updateFacCon(){
   
  
try{
     CaseQuick.Facilitator_Contact__c = FacCon;
        update CaseQuick;
    }    
    catch(exception e){
        ErrorMsg='true';
        ApexPages.addMessages(e);
         system.debug('**FAC**'+e);
    }

}

Public void Arbitrator(){

        try{
            
            update CaseQuick;
            ShowArbitrationContact();
        }    
        catch(exception e){
            ErrorMsg='true';
            ApexPages.addMessages(e);
           
        }
}
Public void updateArbCon(){

    
try{
        CaseQuick.Arbitrator_Contact__c = ArbCon;
        update CaseQuick;
    }    
    catch(exception e){
        ErrorMsg='true';
        ApexPages.addMessages(e);
    }

}



Public void CancelCase(){
        
        system.debug('***SAVE**');
        try{
            
            CaseQuick.Status='Cancelled';
            CaseQuick.Stage__c='Closed';
            CaseQuick.Closed_Date__c=system.today();
            update CaseQuick;
            
            CaseTeamMember[] lstExistCaseTeamMember = [Select MemberId,TeamRoleId,ParentId From CaseTeamMember where ParentId =:CaseQuick.id  ];   
    
            Set<string> Set_Con = new Set<String>();
            
            for(CaseTeamMember con:lstExistCaseTeamMember){
                Set_Con.add(con.MemberId);
            }
            
            if(Set_Con.size()>0){
                CaseNotificationHandler.NotifyCancelled(Set_Con,'Cancelled',CaseQuick.Id);
            }
             
        }    
        catch(exception e){
            ErrorMsg='true';
            //ApexPages.addMessages(e);
            system.debug('**ERROR**'+e);
        }
       
        
}


Public void ClaimantSubmitSOL(){

        try{
            CaseQuick.Submit_Schedule_of_Losses__c=true;
            update CaseQuick;
             
        }    
        catch(exception e){
            ErrorMsg='true';
            ApexPages.addMessages(e);
        }
}


Public void ShowActions(){
    ShowActions = true;
    
}

Public void ShowArbitrator(){
    ShowArbitrator = true;
    ShowActions = true;
    
}
Public void ShowFacilitator(){
    ShowFacilitator = true;
    ShowActions = true;
    
}
Public void ShowDefendant(){
    ShowDefendant= true;
    ShowActions = true;
   
}
Public void ShowClaimant(){
    ShowClaimant = true;
    ShowActions = true;
    
}

Public void HideActions(){
    ShowActions = false;
    ShowArbitrator = false;
    ShowFacilitator = false;
    ShowDefendant = false;
    ShowClaimant= false;
}

/*
Public void DefendantSubmitSOL(){

        try{
            CaseQuick.Submit_Schedule_of_Losses_Defendant__c = true;
            update CaseQuick;             
        }    
        catch(exception e){
            ErrorMsg='true';
            ApexPages.addMessages(e);
        }
}
*/

Public void ClaimantFinalise(){
            
       
        try{
           CaseQuick.Payment_Obligation_Email_Sent__c=true;
            CaseQuick.Claimant_Confirms_Case_Settled__c = true;
            CaseQuick.Generate_Arbitration_Document__c=true;
            CaseQuick.Closed_Date__c=system.today();
            
            update CaseQuick;
            
            ghostscriptAPI.generateFinalAwardonclose(CaseQuick.id);
        }    
        catch(exception e){
            ErrorMsg='true';
            ApexPages.addMessages(e);
            system.debug('**ERror**'+e);
        }
        
}


Public void ArbitratorReset(){


  //CaseQuick.Invite_Arbitrator__c = false; 
    
    User[] ArbUser = [Select id From User where ContactId =: CaseQuick.Arbitrator_Contact__c];
    
    CaseQuick.Arbitration_Firm__c=null;
    CaseQuick.Arbitrator_Contact__c=null;
    CaseQuick.Arbitrator_Accept_Decline__c = null;
        CaseQuick.Arbitrator_Email__c = null;
        CaseQuick.Arbitration_Accept_Date__c = null;
    
     update CaseQuick;
    
   if(ArbUser.size()>0){ 
       Set<String> Set_CaseId = new Set<String>();
        
      Set<String> UserId = new Set<String>();
      Set_CaseId.Add(CaseQuick.id); 
      
      for(User us:ArbUser){
            UserId.Add(us.id);
      }
        
        CaseMemberHandler.RemoverCaseTeamRole('Arbitrator', Set_CaseId, UserId);
    }
    
    
    
    
  } 
   
    





}