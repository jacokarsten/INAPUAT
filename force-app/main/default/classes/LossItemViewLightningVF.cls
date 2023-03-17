Public  class LossItemViewLightningVF {
    
    
   Public String Claimant {get;set;}
   Public String Defendant {get;set;}
   Public String Arbitrator {get;set;}
   Public String NewItem {get;set;}
   Public String UpdateItem {get;set;}
   Public String RefertoArb {get;set;}
   Public String ViewItems {get;set;}
   Public String ViewInd {get;set;}
   Public String CreateNew {get;set;} 
   Public List<SelectOption> DefFirmOptions {get;set;}    
   Public String DefFirm {get;set;}
   
   Public Decimal TotalClaimant {get;set;}
   Public Decimal ProtocolTotal {get;set;}
   Public String StartDate {get;set;}
   
    Public String LOGGEDINUSER {get;set;}
    
    
    
    public LossItemViewLightningVF(ApexPages.StandardController controller) {
               system.debug('**REALLY?***');
    }


    Public Case CurrentCase {get;set;}
   
    Public String sobjectName;
    Public List<ScheduleofLoss> lstScheduleofLoss {get;set;}
    
    Public List<LossCategory> lstLossCategory {get;set;}
    
    
    Public String DisplayMsg {get;set;}

    Public String AccountId {get;set;}

  Public Id StartRecId {get;set;}  

  public LossItemViewLightningVF()
  
  {
      
     Id LossItemId = apexpages.currentpage().getparameters().get('Recid');
      
      system.debug('**LOSSITEM***'+LossItemId);
      
      StartRecId = apexpages.currentpage().getparameters().get('id');
      
      DisplayMsg='false';
      String sobjectName;
      
          Schema.SObjectType sobjectType =    StartRecId.getSObjectType();
        sobjectName = sobjectType.getDescribe().getName();
        //Id AccID=StartRecId;
        Case CurrentCase;
        
        if(sobjectName == 'Case'){
            CurrentCase = new Case(); 
            CurrentCase=[Select id, Status,Stage__c,Incident_Information__r.Incident_Date__c,Arbitration_Accept_Date__c,AccountId,Protocol__r.Mininmum_Schedule__c,Protocol__r.Cap_on_Amount__c,Defendant_Accept_Reject__c  from Case where id=:StartRecId];                    
        }
        StartDate = string.valueof(date.valueof(CurrentCase.Incident_Information__r.Incident_Date__c));
        ProtocolTotal = CurrentCase.Protocol__r.Cap_on_Amount__c;
        
        system.debug('**IN*');
       
        
        generateLossitemList(CurrentCase.id);
        LOGGEDINUSER = UserAccessRights.ProfileName(CurrentCase.id);
        
         showUserRights(CurrentCase.id);
        system.debug('**CurrentCaseCon**'+CurrentCase);        
        system.debug('**ViewItems**'+ViewItems);
        
        ShowFirmDefendant(CurrentCase.id);
  }
  
 Public void showUserRights(ID CaseID){
        Map<String,String> Map_UserRights;
        
        Map_UserRights=UserAccessRights.UserRightsLossItems(CaseID);
        
       Case[] CaseRights =[Select id, Status,Stage__c,AccountId,Protocol__r.Mininmum_Schedule__c,Defendant_Accept_Reject__c  from Case where id=:CaseID]; 
        
        
        system.debug('**Map_UserRights**'+Map_UserRights);
        
      if(CaseRights[0].Stage__c != 'Closed'){  
        Claimant =Map_UserRights.get('Claimant');
        Defendant =Map_UserRights.get('Defendant');
        Arbitrator =Map_UserRights.get('Arbitrator');
        NewItem  =Map_UserRights.get('NewItem');
        UpdateItem =Map_UserRights.get('UpdateItem');
        ViewItems =Map_UserRights.get('ViewItems');
        ViewInd =Map_UserRights.get('ViewInd');
        CreateNew=Map_UserRights.get('CreateNew');
        RefertoArb = Map_UserRights.get('Refer');
     }
     else{
        Claimant ='Readonly';
        Defendant ='Readonly';
        Arbitrator ='Readonly';
        NewItem  ='FALSE';
        UpdateItem ='FALSE';
        ViewItems =Map_UserRights.get('ViewItems');
        ViewInd =Map_UserRights.get('ViewInd');
        CreateNew='FALSE';
        RefertoArb ='FALSE';
     
     }
     system.debug('***LOGGEDINUSER**'+LOGGEDINUSER);
     if(CaseRights[0].Defendant_Accept_Reject__c!='Accept'){
         Defendant ='Readonly';
         
         if(LOGGEDINUSER !='Claimant Handler' && LOGGEDINUSER !='Owner'){
            UpdateItem ='FALSE';
         }
     }
 } 
   
 
 Public void ShowFirmDefendant(ID CaseID){
        DefFirmOptions = new List<SelectOption>(); 
        
        Defendant_Firm__c[] CurdefFirm = [Select id,Firm__c,Firm__r.Name from Defendant_Firm__c where Case__c=:CaseID];
        
        
        for(Defendant_Firm__c  firm:CurdefFirm){
            DefFirm = firm.id;
            if(firm.Firm__r.Name != null){       
                DefFirmOptions.add(new SelectOption(firm.id , firm.Firm__r.Name));
            }
        }
        

}
 
    

 Public void generateLossitemList(ID CaseID){
          
          List<Loss_Category__c> LossCategory;  
          List<Loss_Sub_Categories__c> LossSubCategories;
          
         system.debug('**CaseID**'+CaseID);
          
      lstScheduleofLoss = new  List<ScheduleofLoss>(); 
  
  //lstScheduleofLoss ScheduleofLoss 
        
        List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,Name,Case__c From Schedule_of_Losses__c Where Case__c =: CaseID]);
        
          LossCategory = new List<Loss_Category__c>([SELECT id,Schedule_of_Losses__c,Loss_Item_Count__c,Head_of_Loss_Type__c FROM Loss_Category__c where Case__c =:CaseID]);
          LossSubCategories = new List<Loss_Sub_Categories__c>([SELECT Id,Arbitration_Interest__c,Defendant_Interest__c,Interest__c,Loss_Category__r.Head_of_Loss_Type__c ,Defendant_Rationale__c,Claimant_Rationale__c,  Loss_Type__c,Past_Future_Financial_Item__c, Sub_Category__c,Defendant_Position__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where Loss_Category__c in:  LossCategory ]);
          List<Merit__c> lstMerit = new List<Merit__c>([Select id,Arbitration_Referred_By__c,Claimant_Rationale__c,Defendat_Rationale__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Related_Case__c =:CaseID]);
          List<Injury_Codes__c> lstInjuryCodeCat = new List<Injury_Codes__c>([Select ICD_JC_Items__r.name,ICD_JC_Items__r.Block__c,ICD_JC_Items__r.Category__c, Loss_Category__c from Injury_Codes__c where Loss_Category__c in:LossCategory ]);
            
          List<LossItem> lstLossItems;
          List<InjuryCode> lstInjuryCode; 
     
     system.debug('**Cat**'+LossCategory);
     system.debug('**Sub**'+LossSubCategories);
     
  //  if(LossCategory.size()>0 ){
    
    Decimal LegalCosts=0;
    Map<String,integer> Map_files = new Map<String,integer>(); 
    Map_files = CalculateLossCaseFiles();

    for(Schedule_of_Losses__c s:ScheduleofLosses){
    
    ScheduleofLoss Schedule = new ScheduleofLoss();
    Schedule.TotalDefendant=0;
    Schedule.TotalClaimant=0;
    Schedule.TotalArbitration = 0;
    Schedule.TotalMeritAmount = 0;
    
    Schedule.TotalDefendant_NoInt=0;
    Schedule.TotalClaimant_NoInt=0;
    Schedule.TotalArbitration_NoInt = 0;
    Schedule.TotalMeritAmount_NoInt = 0;
    
    lstLossCategory = new List<LossCategory>();
    
        for(Loss_Category__c p:LossCategory){
        
           if(p.Schedule_of_Losses__c == s.id){ 
              LossCategory Category = new LossCategory(); 
              lstLossItems = new List<LossItem>();     
              Category.ClaimantPosition =0;
              Category.DefendantPosition =0;
              Category.ArbitratorAward  = 0;
              Category.MeritAmount = 0;
              
              Category.ClaimantPosition_NoInt =0;
              Category.DefendantPosition_NoInt =0;
              Category.ArbitratorAward_NoInt  = 0;
              Category.MeritAmount_NoInt = 0;
              
              
                   for(Loss_Sub_Categories__c c:LossSubCategories){
                   
                       if(c.Loss_Category__c==p.id){
                         system.debug('**IN1**');
                        
                         LossItem Items = new LossItem();
                        // Items.PastFutureLosses = c.Past_Future_Financial_Losses__r.Name;
                        
                         Items.Type = c.RecordType.DeveloperName;
                         Items.ClaimantPosition = c.Claimant_Position__c;
                         Items.ArbitratorsPosition =c.Arbitrator_Award__c;
                         Items.DefendantPosition = c.Defendant_Position__c;   
                         Items.DefendantRationale = c.Defendant_Rationale__c; 
                         Items.ClaimantRationale  = c.Claimant_Rationale__c;
                         Items.PastFutureFinancialLosses = c.Loss_Type__c; 
                         Items.SubCategory = c.Sub_Category__c;                       
                         Items.ItemName = c.Name;
                         Items.Stage= c.Stage__c;
                         Items.Status= c.Status__c;
                         Items.CatId = p.id;
                         Items.RecId = c.id;
                         Items.Interest = c.Interest__c;
                         if(Map_files.get(c.id)!=null){
                             Items.FileCount=1;
                         }
                         else{
                             Items.FileCount=0;
                         }
                         
                         lstLossItems.Add(Items);
                       
                      // Schedule.TotalDefendant=Schedule.TotalDefendant+c.Sum_Defendent_Position__c;
                       
                       system.Debug('**CP***'+Category.ClaimantPosition+'**INT***'+c.Interest__c);
                       
                         Category.ClaimantPosition = Category.ClaimantPosition+c.Claimant_Position__c;
                         
                         Category.DefendantPosition = Category.DefendantPosition +c.Defendant_Position__c;
                         Category.ArbitratorAward  = Category.ArbitratorAward + c.Arbitrator_Award__c;
                         
                         
                         Category.ClaimantPosition = Category.ClaimantPosition+c.Interest__c;
                         
                         Category.DefendantPosition = Category.DefendantPosition +c.Defendant_Interest__c;
                         Category.ArbitratorAward  = Category.ArbitratorAward + c.Arbitration_Interest__c;
                         
                         Category.ClaimantPosition_NoInt = Category.ClaimantPosition_NoInt +c.Claimant_Position__c;                        
                         Category.DefendantPosition_NoInt = Category.DefendantPosition_NoInt +c.Defendant_Position__c;
                         Category.ArbitratorAward_NoInt  = Category.ArbitratorAward_NoInt + c.Arbitrator_Award__c;
                         
                        
                         if(c.Status__c == 'Arbitrated'){
                             Category.MeritAmount  = Category.MeritAmount + c.Arbitrator_Award__c + c.Arbitration_Interest__c ;
                             Category.MeritAmount_NoInt = Category.MeritAmount_NoInt + c.Arbitrator_Award__c;
                         }
                         else{
                             // if(c.Status__c == 'Settled'){
                             Category.MeritAmount  = Category.MeritAmount + c.Claimant_Position__c+c.Interest__c;
                             Category.MeritAmount_NoInt = Category.MeritAmount_NoInt + c.Claimant_Position__c; 
                         }
                         
                         if(c.Loss_Category__r.Head_of_Loss_Type__c == 'Legal Costs'){
                            
                             if(c.Status__c == 'Arbitrated'){
                                 LegalCosts  = LegalCosts + c.Arbitrator_Award__c;
                             }
                             else{
                                 LegalCosts  = LegalCosts + c.Claimant_Position__c;
                             }
                         }
                         
                       }  
                     } 
             lstInjuryCode = new List<InjuryCode>();          
             for(Injury_Codes__c i:lstInjuryCodeCat){
                 
                   if(i.Loss_Category__c==p.id){                       
                     InjuryCode Injury = new InjuryCode();
                     Injury.CodeName = i.ICD_JC_Items__r.name;
                     Injury.Category = i.ICD_JC_Items__r.Category__c;
                     Injury.Block =  i.ICD_JC_Items__r.Block__c;
                     Injury.CatId= i.Loss_Category__c;
                     Injury.RecId= i.id;
                     lstInjuryCode.Add(Injury);
                   }                   
             }
            
            
            
             Category.LossItemCount = p.Loss_Item_Count__c;
             Category.CategoryId = p.id;               
              
             Category.InjuryCodeCount=lstInjuryCodeCat.size();
             system.debug('***Category.InjuryCodeCount**'+Category.InjuryCodeCount);
             Category.lstInjuryCode = lstInjuryCode;
             
             Category.lstLossItems = lstLossItems;
             Category.CategoryName = p.Head_of_Loss_Type__c;
             lstLossCategory.Add(Category); 
             
             
             
             Schedule.TotalDefendant=Schedule.TotalDefendant+ Category.DefendantPosition;
             Schedule.TotalClaimant = Schedule.TotalClaimant + Category.ClaimantPosition;
             Schedule.TotalArbitration = Schedule.TotalArbitration + Category.ArbitratorAward;
             Schedule.TotalMeritAmount = Schedule.TotalMeritAmount + Category.MeritAmount;
             
             Schedule.TotalDefendant_NoInt=Schedule.TotalDefendant_NoInt + Category.DefendantPosition_NoInt;
             Schedule.TotalClaimant_NoInt = Schedule.TotalClaimant_NoInt + Category.ClaimantPosition_NoInt;
             Schedule.TotalArbitration_NoInt = Schedule.TotalArbitration_NoInt + Category.ArbitratorAward_NoInt;
             Schedule.TotalMeritAmount_NoInt = Schedule.TotalMeritAmount_NoInt + Category.MeritAmount_NoInt;
             
                
           }                               
         }
         List<Merit> lstMeritSched = new List<Merit> ();
         for(Merit__c m:lstMerit){
             
             if(m.Schedule_of_Losses__c ==s.id){
                 Merit Mer = new Merit();
                 Mer.MeritName  =m.name;
                 Mer.MeritId =m.id;
                 Mer.ClaimantPosition =m.Claimant_Position__c;
                 Mer.DefendantPosition =m.Defendant_Position__c;
                 Mer.ArbitratorsPosition=m.Arbitrator_Award__c;
                 Mer.Status=m.Status__c;
                 Mer.ArbitrationReferredBy = m.Arbitration_Referred_By__c;
                 Mer.DefendantRationale = m.Defendat_Rationale__c;
                 Mer.ClaimantRationale = m.Claimant_Rationale__c;
                     
                 lstMeritSched.Add(Mer);
                 
             }
         }
         
         Schedule.lstMeritSched = lstMeritSched;
         Schedule.ScheduleId = s.id;
         Schedule.ScheduleName = s.Name;
         Schedule.lstLossCategory = lstLossCategory;
         
          TotalClaimant = Schedule.TotalClaimant; 
         if(lstMerit[0].Status__c == 'Arbitrated'){
           Schedule.TotalMeritAmount = (Schedule.TotalMeritAmount - LegalCosts) *  (lstMerit[0].Arbitrator_Award__c/100) + LegalCosts;
           Schedule.TotalMeritAmount_NoInt = (Schedule.TotalMeritAmount_NoInt - LegalCosts) *  (lstMerit[0].Arbitrator_Award__c/100) + LegalCosts;
           
         }
         else  if(lstMerit[0].Claimant_Position__c != null){
             Schedule.TotalMeritAmount = (Schedule.TotalMeritAmount - LegalCosts) *  (lstMerit[0].Claimant_Position__c/100) + LegalCosts;
             Schedule.TotalMeritAmount_NoInt = (Schedule.TotalMeritAmount_NoInt - LegalCosts) *  (lstMerit[0].Claimant_Position__c/100) + LegalCosts;
          
         }
           
         lstScheduleofLoss.Add(Schedule); 
         
         
         
        } 
         
      //}   
       
     
    system.debug('**lstScheduleofLoss**'+lstScheduleofLoss+'***SOL**'+ScheduleofLosses);  
     CurrentCase=[Select id,Stage__c, Status,Arbitration_Accept_Date__c,Defendant_Accept_Reject__c,AccountId,Protocol__r.Mininmum_Schedule__c from Case where id=:CaseID]; 
               
     
 }
/*
@RemoteAction 

Public static string UpdateItemValidate(String ItemId,String NewAmount ){

    Loss_Sub_Categories__c[]  LossSubCategories  = [SELECT Id,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where id =:  ItemId];
    String message;
    try{
        LossSubCategories[0].Claimant_Position__c = decimal.valueof(NewAmount);
        update LossSubCategories;
        
        message='true';
    }
    catch(exception e){
        message ='You have exceeded the limit for loss items.';
    }
    
    return message;
}
*/



//-----------------------------------Actions

Public void UpdateItem(){
    
    DisplayMsg ='';
    String RecId = apexpages.currentpage().getparameters().get('RecId');
    String StrAMnt = apexpages.currentpage().getparameters().get('Amount');
    Decimal ItemAmount;
    if(StrAMnt != null && StrAMnt !=''){  
        system.debug('**AMNT**'+apexpages.currentpage().getparameters().get('Amount'));  
        ItemAmount = Decimal.valueof(apexpages.currentpage().getparameters().get('Amount'));
    }
   Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Name,Case__c,Claimant_Accept_Decline__c,Defendant_Final_Offer_Confirmed__c,Claimant_Final_Offer_Confirmed__c,Defendant_Accept_Decline__c,Defendant_Confirm_Documents_uploaded__c,Claimant_Confirm_Documents_Uploaded__c,Defendant_Arbitration_Submitted__c,Unilateral_referral_date_passed__c,Unilateral_Arbitration_Overlap__c,Unilateral_referral_date__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c Where Case__c =: CurrentCase.id];
   
    
   Loss_Sub_Categories__c[]  LossSubCategories  = [SELECT Id,Loss_Category__c,Arbitration_Referred_By__c,Arbitration_Accepted_Status__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where id =:  RecId];
         
    for(ScheduleofLoss sched:lstScheduleofLoss){
    
            for(LossCategory cat:sched.lstLossCategory){
            
                for(LossItem item:cat.lstLossItems){
                    
                        if(LossSubCategories[0].id == item.RecId){
                            if(LOGGEDINUSER == 'Claimant Handler'){
                                LossSubCategories[0].Claimant_Position__c = item.ClaimantPosition = ItemAmount;
                            }
                            LossSubCategories[0].Arbitrator_Award__c = item.ArbitratorsPosition;
                            
                            if(LOGGEDINUSER == 'Defendant Handler'){
                                LossSubCategories[0].Defendant_Position__c = item.DefendantPosition;
                            }
                            
                            
                            system.debug('**ClaimantPosition**'+item.ClaimantPosition);
                            
                            if(item.ClaimantPosition != item.DefendantPosition){
                                item.Status = LossSubCategories[0].Status__c = 'Negotiating';
                                
                                //system.debug('**Sub Id**'+LossSubCategories[0].id+'**Arnitrated By**'+LossSubCategories[0].Arbitrated_by__c+'**STATUS***'+LossSubCategories[0].Arbitration_Accepted_Status__c);
                                /*
                                if(LossSubCategories[0].Arbitration_Referred_By__c != null && LossSubCategories[0].Arbitration_Accepted_Status__c!='Declined'){
                                    item.Status = LossSubCategories[0].Status__c = 'Referred to Arbitration';
                                }
                                */
                                
                                if(CurrentCase.Status != 'Created' && CurrentCase.Status != 'Referred' && CurrentCase.Status != 'Pending Acceptance' && CurrentCase.Protocol__r.Mininmum_Schedule__c=='Merit and Damages Required' || (ScheduleofLosses[0].Defendant_Arbitration_Submitted__c==true && ScheduleofLosses[0].Claimaint_Arbitration_Submitted__c==true && ScheduleofLosses[0].Unilateral_referral_date_passed__c==true && ScheduleofLosses[0].Unilateral_Arbitration_Overlap__c==false)){ //&& CurrentCase.Defendant_Accept_Reject__c=='Accept'
                                           item.Status = LossSubCategories[0].Status__c = 'Arbitration Doc Prep';
                                           LossSubCategories[0].Arbitration_Accepted_Status__c = 'Accepted';
                                 }          
                                
                                if((CurrentCase.Protocol__r.Mininmum_Schedule__c=='Merit and Damages Required' || ScheduleofLosses[0].Unilateral_referral_date_passed__c==true && ScheduleofLosses[0].Unilateral_Arbitration_Overlap__c==false) && ScheduleofLosses[0].Claimant_Confirm_Documents_Uploaded__c==true && ScheduleofLosses[0].Defendant_Confirm_Documents_uploaded__c==true){
                                                item.Status = LossSubCategories[0].Status__c = 'Arbitration Final Offers';
                                                LossSubCategories[0].Arbitration_Accepted_Status__c = 'Accepted';
                                }
                                if((CurrentCase.Protocol__r.Mininmum_Schedule__c=='Merit and Damages Required' || ScheduleofLosses[0].Unilateral_referral_date_passed__c==true && ScheduleofLosses[0].Unilateral_Arbitration_Overlap__c==false) && ScheduleofLosses[0].Defendant_Final_Offer_Confirmed__c==true && ScheduleofLosses[0].Claimant_Final_Offer_Confirmed__c==true){
                                               item.Status = LossSubCategories[0].Status__c = 'Arbitrating';
                                               LossSubCategories[0].Arbitration_Accepted_Status__c = 'Accepted';
                                }
                           }
                     }
                }
            }
    
    }
    
    
    try{   
        update LossSubCategories;
        DisplayMsg ='true';
   }     
   catch(exception e){
       
        DisplayMsg = e.getMessage();
   }
    
   if(DisplayMsg ==''){ 
    generateLossitemList(StartRecId);
   } 
    
    
    
    
}

Public String ItemDefendantRationale {get;set;}
Public String ItemClaimantRationale {get;set;}
Public String ItemStatus {get;set;}
Public String ItemId {get;set;}

Public void InitateRationale(){
 
    String RecId = apexpages.currentpage().getparameters().get('RecId');
           
    for(ScheduleofLoss sched:lstScheduleofLoss){
    
            for(LossCategory cat:sched.lstLossCategory){
            
                for(LossItem item:cat.lstLossItems){
                    
                        if(RecId == item.RecId){
                            ItemDefendantRationale =  item.DefendantRationale;
                            ItemClaimantRationale  =  item.ClaimantRationale;
                            ItemStatus = item.Status;   
                            ItemId = item.RecId; 
                        }
                }
            }
            
           for(Merit merit:sched.lstMeritSched){
                       if(RecId == merit.MeritId){
                            ItemDefendantRationale =  merit.DefendantRationale;
                            ItemClaimantRationale  =  merit.ClaimantRationale; 
                            ItemStatus = merit.Status;  
                            ItemId = merit.MeritId; 
                        }
           
           } 
            
    }
}

Public void UpdateRationale(){
     
   Loss_Sub_Categories__c[]  LossSubCategories  = [SELECT Id,Defendant_Rationale__c,Claimant_Rationale__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where id =:  ItemId];
   List<Merit__c> lstMerit = new List<Merit__c>([Select id,Claimant_Rationale__c,Defendat_Rationale__c,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where id =:  ItemId]);
           
    
    system.debug('**ItemId**'+ItemId);     
    for(ScheduleofLoss sched:lstScheduleofLoss){
    
           if(LossSubCategories.size()>0){ 
                for(LossCategory cat:sched.lstLossCategory){
                
                    for(LossItem item:cat.lstLossItems){
                        
                            if(ItemId == item.RecId){
                            
                             system.debug('**IN ITEM**');
                                LossSubCategories[0].Defendant_Rationale__c =  ItemDefendantRationale;
                                LossSubCategories[0].Claimant_Rationale__c  =  ItemClaimantRationale;   
                               
                            }
                    }
                }
            }
            else if(lstMerit.size()>0){    
                for(Merit merit:sched.lstMeritSched){
                           if(ItemId == merit.MeritId){
                                lstMerit[0].Defendat_Rationale__c = ItemDefendantRationale;
                                lstMerit[0].Claimant_Rationale__c = ItemClaimantRationale; 
                               
                            }
               
               } 
           }    
    }
    if(lstMerit.size()>0){
        update lstMerit;
    }
    else if(LossSubCategories.size()>0){
        update LossSubCategories;
    }
     
    generateLossitemList(StartRecId);
    
}

//----------------Interest

Public void InitateInterest(){
 
    String RecId = apexpages.currentpage().getparameters().get('RecId');
    Loss_Sub_Categories__c[]  LossSubCategories  = [SELECT Id,Status__c,Defendant_Interest__c,Arbitration_Interest__c,Loss_Type__c,Interest__c,Claimant_Position__c ,Interest_Expense_Date__c,Loss_Category__c FROM Loss_Sub_Categories__c where id =:  RecId];
           
    NewLossItem = new Loss_Sub_Categories__c();
    NewLossItem = LossSubCategories[0];
    
    StartDate = string.valueof(NewLossItem.Interest_Expense_Date__c);
}

Public void UpdateInterest(){
    Date d_Start; 
    
    if(StartDate !='' && StartDate!=null){
        d_Start =  Date.newInstance(integer.Valueof(StartDate.Left(4)), integer.Valueof(StartDate.mid(5,2)),integer.Valueof(StartDate.mid(8,2)));
    }
    
    if(d_Start != null){
        NewLossItem.Interest_Expense_Date__c = d_Start; 
    }
    else{
    
    }
    update NewLossItem;
    generateLossitemList(StartRecId);
    
}

Public void RemoveInterest(){
    NewLossItem.Interest_Expense_Date__c=null;
    update NewLossItem;
    generateLossitemList(StartRecId);    
}


//---------


Public Boolean ShowItemCategory {get;set;}
Public Loss_Sub_Categories__c NewLossItem {get;set;}

Public void NewItem(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
    
    Loss_Category__c[] LossCategory = [Select id,Case__c,Head_of_Loss_Type__c,Schedule_of_Losses__c,RecordType.DeveloperName from Loss_Category__c where id=:RecId];
    
    //GetMerit
    Merit__c[] Merit = [Select id from Merit__c Where Schedule_of_Losses__c =: LossCategory[0].Schedule_of_Losses__c limit 1];
    
    
    NewLossItem = new Loss_Sub_Categories__c();
    NewLossItem.Case__c = LossCategory[0].Case__c;    
    NewLossItem.Merit__c = Merit[0].id;
    NewLossItem.Loss_Category__c = LossCategory[0].id;
    ShowItemCategory = false;
    
    
    if(LossCategory[0].Head_of_Loss_Type__c=='Pain, Suffering & Loss of Amenities'){
       NewLossItem.recordTypeId = getRecordTypeIdbyName('Loss_Sub_Categories__c','PSLA'); 
       NewLossItem.Loss_Type__c = 'PSLA';  
    }    
    else if(LossCategory[0].Head_of_Loss_Type__c=='Past Financial Losses'){
           NewLossItem.recordTypeId = getRecordTypeIdbyName('Loss_Sub_Categories__c', 'PFL');
           NewLossItem.Loss_Type__c = 'Other Losses';
           ShowItemCategory = true; 
   }
   else if(LossCategory[0].Head_of_Loss_Type__c=='Future Financial Losses'){
           NewLossItem.recordTypeId = getRecordTypeIdbyName('Loss_Sub_Categories__c', 'FFL'); 
           NewLossItem.Loss_Type__c = 'Other Losses';
           ShowItemCategory = true; 
   }   
    else{ 
           NewLossItem.recordTypeId = getRecordTypeIdbyName('Loss_Sub_Categories__c', 'Total Amount');  
           NewLossItem.Loss_Type__c = LossCategory[0].Head_of_Loss_Type__c;
    }
    
    //if(CurrentCase.Protocol__r.Mininmum_Schedule__c=='Merit and Damages Required'){
          //NewLossItem.Status__c= 'Arbitration Doc Prep';
    //}

}



Public void SaveItem(){
     
   // NewLossItem.Claimant_Position__c=99;
   Decimal ItemAmount = Decimal.valueof(apexpages.currentpage().getparameters().get('Amount'));
   NewLossItem.Claimant_Position__c = ItemAmount;
   
   try{
       
       Schedule_of_Losses__c[] ScheduleLosses = [Select id,Claimant_Final_Offer_Confirmed__c,Defendant_Final_Offer_Confirmed__c,Defendant_Confirm_Documents_uploaded__c,Claimant_Confirm_Documents_Uploaded__c,Case__c,Accept_Case_New_Arbitration_Date__c,Unilateral_referral_date_passed__c from Schedule_of_Losses__c where Case__c=:StartRecId ];
       
       DisplayMsg =''; 
       
       if(ScheduleLosses[0].Claimant_Final_Offer_Confirmed__c==true && ScheduleLosses[0].Defendant_Final_Offer_Confirmed__c==true && ScheduleLosses[0].Unilateral_referral_date_passed__c==true){
                            NewLossItem.Status__c = 'Arbitrating' ;  
                            NewLossItem.Arbitration_Accepted_Status__c = 'Accepted'; 
                            NewLossItem.Arbitration_Referred_By__c = LOGGEDINUSER;                                  
       }
       
       else if((ScheduleLosses[0].Claimant_Confirm_Documents_Uploaded__c ==true && ScheduleLosses[0].Defendant_Confirm_Documents_uploaded__c  ==true && ScheduleLosses[0].Unilateral_referral_date_passed__c==true)){
                            NewLossItem.Status__c ='Final Offers' ;  
                            NewLossItem.Arbitration_Accepted_Status__c = 'Accepted'; 
                            NewLossItem.Arbitration_Referred_By__c = LOGGEDINUSER;                                  
       }
       
       
       else if((CurrentCase.Protocol__r.Mininmum_Schedule__c=='Merit and Damages Required' && CurrentCase.Status=='Arbitrating')  || (ScheduleLosses[0].Unilateral_referral_date_passed__c==true )){
                            NewLossItem.Status__c = 'Arbitration Doc Prep';  
                            NewLossItem.Arbitration_Accepted_Status__c = 'Accepted'; 
                            NewLossItem.Arbitration_Referred_By__c = LOGGEDINUSER;                                  
       }
       else if(CurrentCase.Protocol__r.Mininmum_Schedule__c!='Merit and Damages Required' && CurrentCase.Stage__c=='Negotiation'){
                           NewLossItem.Status__c = 'Negotiating';
       }  
       else{
                            NewLossItem.Status__c= 'Created';                                     
       }
       
           
       Insert NewLossItem;
    
          
        
          
        system.Debug('**NewLossItem***'+NewLossItem.Claimant_Position__c);
        
        
        
       // DefFirm 
        Defendant_Firm_Schedule_of_Loss__c[] Firm_Schedule = [Select Defendant_Firm__c,Schedule_of_Losses__c From Defendant_Firm_Schedule_of_Loss__c where Schedule_of_Losses__c =:ScheduleLosses[0].id AND Defendant_Firm__c=: DefFirm];
        
        
        system.debug('**Sched**'+ScheduleLosses +'**Firm**'+DefFirm);
        
        Defendant_Firm_Loss_Item_Position__c DefendantItem = new Defendant_Firm_Loss_Item_Position__c();
        DefendantItem.Defendant_Firm_Schedule_of_Loss__c = Firm_Schedule[0].id;
        DefendantItem.Loss_Sub_Category__c = NewLossItem.id;
            
        Insert   DefendantItem; 
    
    }     
   catch(exception e){
        system.debug('***ERROR****'+e.getMessage());
        DisplayMsg = e.getMessage();
   }
     
     
    
    if(DisplayMsg ==''){ 
        generateLossitemList(StartRecId);
    } 
    

}


Public Injury_Codes__c NewInjuryCode {get;set;}
Public void NewCode(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
    
    Loss_Category__c[] LossCategory = [Select id,Case__c,Schedule_of_Losses__c,RecordType.DeveloperName from Loss_Category__c where id=:RecId];
   
    NewInjuryCode = new Injury_Codes__c();
    NewInjuryCode.Loss_Category__c = LossCategory[0].id;    
}
Public void SaveCode(){
     
   // NewLossItem.Claimant_Position__c=99;
    Injury_Codes__c[] Injury_Codes = [Select ICD_JC_Items__c from Injury_Codes__c where Loss_Category__c =:NewInjuryCode.Loss_Category__c AND ICD_JC_Items__c =:NewInjuryCode.ICD_JC_Items__c];
    if(Injury_Codes.size()==0){
        Insert NewInjuryCode;
        generateLossitemList(StartRecId);
    }
}    

Public void DeleteCode(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
    Injury_Codes__c[] InjuryCodes = [Select id from Injury_Codes__c where id=:RecId];   
    delete  InjuryCodes;
    
}

Public void DeleteLossitem(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
     Loss_Sub_Categories__c[]  LossSubCategories  = [SELECT Id,Defendant_Position__c,Arbitrator_Award__c FROM Loss_Sub_Categories__c where id =:  RecId];
     
    if(LossSubCategories[0].Defendant_Position__c <=0 && LossSubCategories[0].Arbitrator_Award__c<=0){ 
        
        delete  LossSubCategories;
    }
}


Public void Pagerefresh(){
    system.debug('###Refresh###');
    generateLossitemList(StartRecId);
}
/*
Public void RefertoArbitration(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');

    
   Loss_Sub_Categories__c[]  LossSubCategories  = [SELECT Id,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where id =:  RecId];
         
    for(ScheduleofLoss sched:lstScheduleofLoss){
    
            for(LossCategory cat:sched.lstLossCategory){
            
                for(LossItem item:cat.lstLossItems){
                    
                        if(LossSubCategories[0].id == item.RecId){
                            LossSubCategories[0].Status__c = 'Referred to Arbitration';
                            LossSubCategories[0].Arbitration_Referred_By__c = LOGGEDINUSER;
                        }
                }
            }
    
    }
    
    update LossSubCategories;

}
Public void ReferMerit(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
    
    List<Merit__c> lstMerit = new List<Merit__c>([Select id,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where id =:RecId]);
     system.Debug('**RecId**'+RecId+'**lstMerit**'+lstMerit);
     for(ScheduleofLoss sched:lstScheduleofLoss){     
         for(Merit merit:sched.lstMeritSched){            
                  lstMerit[0].Status__c = 'Referred to Arbitration';
                  lstMerit[0].Arbitration_Referred_By__c = LOGGEDINUSER; 
                   merit.ArbitrationReferredBy=   LOGGEDINUSER;                                         
         }
     }  
    
    
    update lstMerit;

}

*/



//----------------------MERITS

Public void UpdateMerit(){
    
    system.debug('**CurrentCaseMer**'+CurrentCase);
    DisplayMsg = '';
    String RecId = apexpages.currentpage().getparameters().get('RecId');
    
    String MerPerc = apexpages.currentpage().getparameters().get('MerPerc');
    
    Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Unilateral_Arbitration_Overlap__c,Name,Case__c,Claimant_Accept_Decline__c,Unilateral_referral_date_passed__c,Defendant_Final_Offer_Confirmed__c,Claimant_Final_Offer_Confirmed__c,Defendant_Accept_Decline__c,Defendant_Confirm_Documents_uploaded__c,Claimant_Confirm_Documents_Uploaded__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c Where Case__c =: CurrentCase.id];
   
    List<Merit__c> lstMerit = new List<Merit__c>([Select id,Defendant_Position__c,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where id =:RecId]);
     system.Debug('**RecId**'+RecId+'**lstMerit**'+lstMerit);
     for(ScheduleofLoss sched:lstScheduleofLoss){     
         for(Merit merit:sched.lstMeritSched){            
                      
                      if(LOGGEDINUSER == 'Claimant Handler' || LOGGEDINUSER == 'Owner' ){
                            lstMerit[0].Claimant_Position__c = merit.ClaimantPosition = decimal.valueof(MerPerc); 
                      }
                      else if(LOGGEDINUSER == 'Defendant Handler'){                                
                            lstMerit[0].Defendant_Position__c = merit.DefendantPosition = decimal.valueof(MerPerc);
                      }      
                            if(merit.ClaimantPosition != merit.DefendantPosition){
                                merit.Status = lstMerit[0].Status__c = 'Negotiating';
                                
                               // if((CurrentCase.Protocol__r.Mininmum_Schedule__c=='Merit and Damages Required' || (ScheduleofLosses[0].Claimant_Accept_Decline__c==true && ScheduleofLosses[0].Defendant_Accept_Decline__c==true))&& CurrentCase.Defendant_Accept_Reject__c=='Accept'){
                             if(CurrentCase.Status != 'Created' && CurrentCase.Status != 'Referred' && CurrentCase.Status != 'Pending Acceptance' && CurrentCase.Protocol__r.Mininmum_Schedule__c=='Merit and Damages Required' || (ScheduleofLosses[0].Defendant_Arbitration_Submitted__c==true && ScheduleofLosses[0].Claimaint_Arbitration_Submitted__c==true && ScheduleofLosses[0].Unilateral_referral_date_passed__c==true && ScheduleofLosses[0].Unilateral_Arbitration_Overlap__c==false)){ //&& CurrentCase.Defendant_Accept_Reject__c=='Accept'
                                  
                                           merit.Status = lstMerit[0].Status__c = 'Arbitration Doc Prep';
                                           lstMerit[0].Arbitration_Accepted_Status__c='Accepted';
                                           
                                 }          
                                
                               // if((ScheduleofLosses[0].Claimant_Confirm_Documents_Uploaded__c==true && ScheduleofLosses[0].Defendant_Confirm_Documents_uploaded__c==true)){
                                if((CurrentCase.Protocol__r.Mininmum_Schedule__c=='Merit and Damages Required' || ScheduleofLosses[0].Unilateral_referral_date_passed__c==true && ScheduleofLosses[0].Unilateral_Arbitration_Overlap__c==false) && ScheduleofLosses[0].Claimant_Confirm_Documents_Uploaded__c==true && ScheduleofLosses[0].Defendant_Confirm_Documents_uploaded__c==true){
                                               lstMerit[0].Arbitration_Accepted_Status__c='Accepted';    
                                                merit.Status = lstMerit[0].Status__c = 'Arbitration Final Offers';
                                }
                                //if(ScheduleofLosses[0].Defendant_Final_Offer_Confirmed__c==true && ScheduleofLosses[0].Claimant_Final_Offer_Confirmed__c==true){
                                if((CurrentCase.Protocol__r.Mininmum_Schedule__c=='Merit and Damages Required' || ScheduleofLosses[0].Unilateral_referral_date_passed__c==true && ScheduleofLosses[0].Unilateral_Arbitration_Overlap__c==false) && ScheduleofLosses[0].Defendant_Final_Offer_Confirmed__c==true && ScheduleofLosses[0].Claimant_Final_Offer_Confirmed__c==true){                               
                                               lstMerit[0].Arbitration_Accepted_Status__c='Accepted';
                                               merit.Status = lstMerit[0].Status__c = 'Arbitrating';
                                }
                               
                               
                                
                                
                                
                                
                                
                          }        
         }
     }  
    
   
   try{
   
        update lstMerit;
   }     
   catch(exception e){
   
        DisplayMsg = e.getMessage();
   }
    
   if(DisplayMsg ==''){ 
    generateLossitemList(StartRecId);
   } 
    
}



Public List<CaseFiles> CaseFileslist {get;set;}
Public List<Loss_Category_Files__c> Loss_CategoryFiles {get;set;}

Public void populateCaseFiles(){
      
     
     CaseFileslist = new List<CaseFiles>();
     
     String RecId = apexpages.currentpage().getparameters().get('RecId');
     
     Loss_CategoryFiles = [Select id,File_Url__c,File_Name__c,Linked_by__c,Loss_Sub_Category__c,Loss_Sub_Category__r.Loss_Type__c From Loss_Category_Files__c where    Loss_Sub_Category__c =: RecId];
     
   
     Map<String,String> Map_filesCl = new Map<String,String>();
     Map<String,String> Map_filesDef = new Map<String,String>();
     
     Map<String,String> Map_fileLink = new Map<String,String>();
     
     system.debug('**RecId**'+RecId);
     
     for(Loss_Category_Files__c f:Loss_CategoryFiles){     
        if(f.Linked_by__c == 'Claimant Handler' || f.Linked_by__c =='Both Parties'){
            Map_filesCl.put(String.Valueof(f.File_Url__c).right(18),f.Loss_Sub_Category__c ); 
        }
        if(f.Linked_by__c == 'Defendant Handler' || f.Linked_by__c =='Both Parties'){
            Map_filesDef.put(String.Valueof(f.File_Url__c).right(18),f.Loss_Sub_Category__c );
        }
         
            Map_fileLink.put(String.Valueof(f.File_Url__c).right(18),f.id);
         
     }
     
     
     
     ContentDocumentLink[] DocumentLink = [SELECT LinkedEntityId,ContentDocumentId FROM ContentDocumentLink where LinkedEntityId =:CurrentCase.id   ];
     
     Set<String> set_docId = new Set<String>();
     for(ContentDocumentLink doc:DocumentLink){
         set_docId.add(doc.ContentDocumentId);    
     }
          
     ContentVersion[] Content = [SELECT Case_Id__c,Document_Source__c,ContentDocumentId,Submitted_for_Arbitration_By__c,FileType,Uploaded_By__c,INAP_Doc_Type__c,Loss_Item_ID__c,Sharing_Permissions__c,Title FROM ContentVersion where ContentDocumentId in:set_docId AND  Ghost_Draft_Doc__c =:false AND (Sharing_Permissions__c='Shared' OR  (Sharing_Permissions__c ='Private' AND Uploaded_By__c=:LOGGEDINUSER)) Order By Title,Sharing_Permissions__c ASC];  //AND Sharing_Permissions__c !='Private'
       
     for(ContentVersion con:Content){
          
          
          CaseFiles CaseFile = new CaseFiles();
     
          if(Map_filesCl.get(con.ContentDocumentId)!=null){                                      
              CaseFile.LossItemSelectClaimant= true;
          }
          
          if(Map_filesDef.get(con.ContentDocumentId)!=null){                                      
              CaseFile.LossItemSelectDefendant = true;
          }
          
            
          if(Map_fileLink.get(con.ContentDocumentId) != null){
              CaseFile.FileLink = Map_fileLink.get(con.ContentDocumentId); 
          }
          CaseFile.Uploadedby = con.Uploaded_By__c;
          CaseFile.SharingStatus = con.Sharing_Permissions__c;           
          CaseFile.LossItem =  RecId;
          CaseFile.DocumentId = con.ContentDocumentId;    
          CaseFile.DocumentType  = con.INAP_Doc_Type__c;
          CaseFile.DocumentName = con.Title;
          CaseFile.DocumentLink ='/s/contentdocument/' +con.ContentDocumentId;
          CaseFileslist.Add(CaseFile); 
              
     }
     
    
}

Public void SaveCaseFilesSelection(){
    
    Map<String,String> Map_Add = new Map<String,String>();
    Set<String> Set_Remove = new Set<String>();
    Set<String> Set_Update = new Set<String>(); 
    
    
    List<Loss_Category_Files__c> Lst_LossfileAdd = new List<Loss_Category_Files__c>();
    List<Loss_Category_Files__c> Lst_LossfileRemove = new List<Loss_Category_Files__c>(); 
    Map<String,String> Map_updateLink = new Map<String,String>();
   
    for(CaseFiles CaseFile:CaseFileslist){  
    
          
        if(CaseFile.LossItemSelectDefendant == true || CaseFile.LossItemSelectClaimant==true){
        
          if(CaseFile.FileLink ==null){
              Loss_Category_Files__c Loss_file = new Loss_Category_Files__c();
              Loss_file.Loss_Sub_Category__c = CaseFile.LossItem;
              Loss_file.File_Url__c = CaseFile.DocumentLink;
               Loss_file.CaseId__c = CurrentCase.id;
              Loss_file.Document_Type__c = CaseFile.DocumentType;
              Loss_file.File_Name__c = CaseFile.DocumentName;
              Loss_file.Document_Sharing_Permissions__c = CaseFile.SharingStatus;
              
              if(CaseFile.LossItemSelectDefendant == true && CaseFile.LossItemSelectClaimant==true){
                  Loss_file.Linked_by__c='Both Parties';
              }
              else if(CaseFile.LossItemSelectClaimant==true){
                  Loss_file.Linked_by__c='Claimant Handler';
              }
              else if(CaseFile.LossItemSelectDefendant==true){
                  Loss_file.Linked_by__c='Defendant Handler';
              }
              
              Lst_LossfileAdd.Add(Loss_file);
          } 
          else{
              
              if(CaseFile.LossItemSelectDefendant == true && CaseFile.LossItemSelectClaimant==true){
                  Map_updateLink.put(CaseFile.DocumentLink,'Both Parties');
              }
              else if(CaseFile.LossItemSelectClaimant==true){
                  Map_updateLink.put(CaseFile.DocumentLink,'Claimant Handler');
              }
              else if(CaseFile.LossItemSelectDefendant==true){
                  Map_updateLink.put(CaseFile.DocumentLink,'Defendant Handler');
              }
              Set_Update.Add(CaseFile.lossItem);
          
          }
        }
        else{
            if(CaseFile.FileLink !=null){
              Set_Remove.Add(CaseFile.FileLink);
          } 
            
        }                                
     }
  
   if(Lst_LossfileAdd.size()>0){
       Insert Lst_LossfileAdd;  
   }
   
   system.debug('**Map_updateLink***'+Map_updateLink);
   if(Map_updateLink.size()>0){
       Loss_CategoryFiles = [Select id,File_Url__c,Linked_by__c,Loss_Sub_Category__c,Loss_Sub_Category__r.Loss_Type__c From Loss_Category_Files__c where Loss_Sub_Category__c in: Set_Update AND   File_Url__c in: Map_updateLink.keyset()];
     
       for(Loss_Category_Files__c loss:Loss_CategoryFiles){
          system.debug('**updateLink***'+Map_updateLink.get(loss.File_Url__c));
          loss.Linked_by__c = Map_updateLink.get(loss.File_Url__c);
       
       }  
       
       update Loss_CategoryFiles;
   }
   
   if(Set_Remove.size()>0){
       Lst_LossfileRemove =[Select id from Loss_Category_Files__c where id in:Set_Remove];
       delete Lst_LossfileRemove;
       
   } 
    
   generateLossitemList(StartRecId);
}

Public Map<String,integer> CalculateLossCaseFiles(){
      
     
     Loss_Category_Files__c[] Loss_CategoryFiles;
    
     Loss_CategoryFiles = [Select id,Loss_Sub_Category__c,File_Url__c,Loss_Sub_Category__r.Loss_Category__c,Loss_Sub_Category__r.Loss_Type__c From Loss_Category_Files__c where  CaseId__c=:StartRecId  ];        
     
   
     Map<String,integer> Map_files = new Map<String,integer>();
    
    for(Loss_Category_Files__c f:Loss_CategoryFiles){        
        Map_files.put(f.Loss_Sub_Category__c,1);       
    }            
     
     
     return Map_files; 
}








public static Id getRecordTypeIdbyName(String objectName, String strRecordTypeName)
    {
        return  Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosByName().get(strRecordTypeName).getRecordTypeId();
    }

    public static String getRecordTypeNameById(String objectName, Id strRecordTypeId)
    {
        return Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosById().get(strRecordTypeId).getDeveloperName();
    }


Public Class ScheduleofLoss{
  Public String ScheduleName {get;set;}
  Public String ScheduleId {get;set;}
    
    Public Decimal TotalClaimant {get;set;}
    Public Decimal TotalDefendant {get;set;} 
    Public Decimal TotalArbitration {get;set;}
    Public Decimal TotalMeritAmount {get;set;}
    
    Public Decimal TotalClaimant_NoInt {get;set;}
    Public Decimal TotalDefendant_NoInt {get;set;} 
    Public Decimal TotalArbitration_NoInt {get;set;}
    Public Decimal TotalMeritAmount_NoInt {get;set;} 
    
  Public List<LossCategory> lstLossCategory {get;set;}
  Public List<Merit> lstMeritSched {get;set;}
  
}

Public Class Merit{
  Public String MeritName {get;set;} 
  Public String MeritId {get;set;}
  Public Decimal ClaimantPosition {get;set;}
  Public Decimal DefendantPosition {get;set;}
  Public Decimal ArbitratorsPosition {get;set;}
  Public String ArbitrationReferredBy {get;set;} 
    Public String DefendantRationale {get;set;}
   Public String ClaimantRationale {get;set;}
  Public String Status {get;set;}
}
    
Public Class LossCategory{
  Public String CategoryName {get;set;}
  Public String CategoryId {get;set;}
  
  Public Decimal ClaimantPosition {get;set;}
  Public Decimal DefendantPosition {get;set;}
  Public Decimal ArbitratorAward {get;set;}
  Public Decimal MeritAmount {get;set;}
  
  Public Decimal ClaimantPosition_NoInt  {get;set;}  
  Public Decimal DefendantPosition_NoInt  {get;set;}
  Public Decimal ArbitratorAward_NoInt {get;set;}
  Public Decimal MeritAmount_NoInt  {get;set;}
   
  
  Public Decimal LossItemCount {get;set;}
  Public Decimal InjuryCodeCount {get;set;}
  Public List<LossItem> lstLossItems {get;set;}
  Public List<InjuryCode> lstInjuryCode {get;set;}
}

Public Class LossItem{

   Public String ItemName {get;set;}
    Public Decimal ClaimantPosition {get;set;} 
    Public Decimal DefendantPosition {get;set;}
   Public Decimal ArbitratorsPosition {get;set;}
    Public String PastFutureFinancialLosses {get;set;} 
   Public String SubCategory {get;set;}
   
   Public String Type {get;set;}
   Public String Status {get;set;}
   Public String Stage {get;set;}
   Public String CatId {get;set;}
   Public String RecId {get;set;}
   
   Public String DefendantRationale {get;set;}
   Public String ClaimantRationale {get;set;}
   Public Decimal Interest {get;set;}
   Public Decimal FileCount {get;set;}

}
 
Public Class InjuryCode{

   Public String CodeName {get;set;} 
   Public String Category {get;set;} 
   Public String Block {get;set;}   
   Public String CatId {get;set;}
   Public String RecId {get;set;}

} 
 
 Public Class CaseFiles{
    Public String DocumentName {get;set;}
    Public String DocumentType {get;set;}
    Public String LossItem {get;set;}
    Public String DocumentLink {get;set;}
    Public String DocumentId {get;set;} 
    Public String ReferedBy {get;set;}
    Public String SharingStatus {get;set;} 
    Public String Uploadedby {get;set;}
    Public String FileLink {get;set;}  
    Public Boolean LossItemSelectClaimant {get;set;} 
    Public Boolean LossItemSelectDefendant {get;set;}
    
    
       
}
 
 
    
    
}