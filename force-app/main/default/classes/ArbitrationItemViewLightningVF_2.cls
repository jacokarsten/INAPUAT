public without sharing class ArbitrationItemViewLightningVF_2 {
    
   
   Public String Claimant {get;set;}
   Public String Defendant {get;set;}
   Public String Arbitrator {get;set;}
   Public String NewItem {get;set;}
   Public String UpdateItem {get;set;}
   Public String ViewItems {get;set;}
   Public String ViewInd {get;set;}
   Public String CreateNew {get;set;} 
   Public String RefertoArb {get;set;}
   
    
   Public Boolean StageSubmit {get;set;}    
   Public Boolean StageLoadFiles {get;set;} 
   
   Public Boolean UserVisible {get;set;} 
   Public Boolean StageFinalise {get;set;}  
    
   Public String LOGGEDINUSER {get;set;} 
   Public Static String TestLoggedinUser; 
   
   Public Decimal TotalClaimant {get;set;}
   Public Decimal ProtocolTotal {get;set;}
    
    public ArbitrationItemViewLightningVF_2(ApexPages.StandardController controller) {

    }


    Public Case CurrentCase {get;set;}
   
    Public String sobjectName;
    Public List<ScheduleofLoss> lstScheduleofLoss {get;set;}
    
    Public List<LossCategory> lstLossCategory {get;set;}
    
    
    Public String DisplayMsg {get;set;}

    Public String AccountId {get;set;}
    
    Public Id StartRecId {get;set;}


  public ArbitrationItemViewLightningVF_2()
  
  {
      
     Id LossItemId = apexpages.currentpage().getparameters().get('Recid');
      
      system.debug('**LOSSITEM***'+LossItemId);
      
       StartRecId = apexpages.currentpage().getparameters().get('id');
      
      
      String sobjectName;
          Schema.SObjectType sobjectType =    StartRecId.getSObjectType();
          sobjectName = sobjectType.getDescribe().getName();
        //Id AccID=StartRecId;
       // Case CurrentCase;
        
        if(sobjectName == 'Case'){
            CurrentCase = new Case();
            CurrentCase=[Select id,Protocol__r.Cap_on_Amount__c, Status,AccountId,  Claimant_Firm_Team__c,Defendant_Firm_Team__c from Case where id=:StartRecId]; 
                 
        }
        system.debug('**IN*');
        Map<String,String> Map_UserRights;
        
        
        LOGGEDINUSER = UserAccessRights.ProfileName(CurrentCase.id);
        
      if(test.isrunningtest()){
          TestLoggedinUser = LOGGEDINUSER;
       } 
        showUserRights(CurrentCase.id);
        
        ProtocolTotal = CurrentCase.Protocol__r.Cap_on_Amount__c;
        
        generateLossitemList(CurrentCase.id);
        DetermineStage();
        system.debug('**RefreshAwardDoc*'+RefreshAwardDoc);
        
        
        
        
        
        UserVisible = true;
        if(lstScheduleofLoss.size()>0 && RefreshAwardDoc==false){
            
            //populateCaseFiles();
            //   CaseFilesSelectedlist = populateCaseFiles('Selected','');
            //   CaseFileslist = populateCaseFiles('All','');
              
              CaseFilesSelectedlist = GeneralSelectedFiles();
              lstFileCategory= SelectAllCaseFiles();
               
               DisplayMsg='';
               UserVisible = true;
        }
        else{
            
            DisplayMsg = 'Arbitration is not allowed yet!';
            system.debug('**LOSSNULL*');
            showAwardDocument();
            
            if(RefreshAwardDoc!=null && RefreshAwardDoc==True){
                
                 DisplayMsg = '';
            }
            
            
        } 
        
        system.debug('**LOGGEDINUSER*'+LOGGEDINUSER+'**ShowSubmitAward**'+ShowSubmitAward);
        if(LOGGEDINUSER == 'Arbitrator' && (ShowSubmitAward==Null || ShowSubmitAward==false)){
            UserVisible=false;
            system.debug('**UserVisible*'+UserVisible);
        }
        
        
                   
           
  }
   
   
  Public Boolean  ReferallItems {get;set;}
  
         Public Boolean  ShowSubmitItems {get;set;}
         Public Boolean  ShowConfirmItems {get;set;}
         Public Boolean  ShowUpdateDocument {get;set;}
         Public Boolean  ShowConfirmDocument {get;set;}
         Public Boolean  ShowConfirmFinal {get;set;}
         Public Boolean  ShowPreviewAward {get;set;} 
         Public Boolean  ShowSubmitAward {get;set;}   

          
          
         Public Boolean  SubmitItems {get;set;}
         Public Boolean  ConfirmItems {get;set;}
         Public Boolean  UpdateDocument {get;set;}
         Public Boolean  ConfirmDocument {get;set;}
         Public Boolean  ConfirmFinal {get;set;}
         Public Boolean  PreviewAward {get;set;} 
         Public Boolean  SubmitAward {get;set;}   
 
 
 
 Public void  showUserRights(ID CaseID){
        Map<String,String> Map_UserRights;
        
        Map_UserRights=UserAccessRights.UserRightsLossItems(CaseID);
        
        system.debug('**Map_UserRights**'+Map_UserRights);
        
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
 
 
 Public void DetermineStage(){
      
      if(lstScheduleofLoss.size()>0){      
            SubmitAward=false;
            PreviewAward=false; 
            ConfirmFinal =false;
            ConfirmDocument =false;
            UpdateDocument=false;
            ReferallItems=false;
                ConfirmItems = false;
                SubmitItems = false;
            RefreshAwardDoc=false;
            
            ShowSubmitItems = false;
            ShowConfirmItems = false;
            ShowUpdateDocument = false;
            ShowConfirmDocument = false;
             ShowConfirmFinal = false;
             
            Boolean LoggedUser=false; 
            
   
               if(LOGGEDINUSER == 'Claimant Handler' || LOGGEDINUSER == 'Defendant Handler'){
                   LoggedUser=true;
               }      
            
            //Claimant_Accept_Decline__c Defendant_Accept_Decline__c
            if(LOGGEDINUSER == 'Claimant Handler' && lstScheduleofLoss[0].Claimaint_Arbitration_Submitted==false){
                
                ReferallItems=true;
                ShowSubmitItems = true;
                SubmitItems = false;
                
            }
            else if(LOGGEDINUSER == 'Claimant Handler' && lstScheduleofLoss[0].Claimaint_Arbitration_Submitted==true ){  //Remove Accept/Decline && lstScheduleofLoss[0].Claimant_Accept_Decline==false
                ReferallItems=false;                                  
                SubmitItems = true;
                
                //Remove Accept/Decline -- ConfirmItems = false;
            }
          /* Remove Accept/Decline
            else if(LOGGEDINUSER == 'Claimant Handler' && lstScheduleofLoss[0].Claimant_Accept_Decline==true){
                ReferallItems=false;
                ConfirmItems = true;
                SubmitItems = true;
            }
         
            
            if(LOGGEDINUSER == 'Claimant Handler' && lstScheduleofLoss[0].Claimaint_Arbitration_Submitted==true && lstScheduleofLoss[0].Claimant_Accept_Decline==false && lstScheduleofLoss[0].Defendant_Arbitration_Submitted==true){            
                ShowConfirmItems = true;            
            }
            else if(LOGGEDINUSER == 'Defendant Handler' && lstScheduleofLoss[0].Defendant_Arbitration_Submitted==true && lstScheduleofLoss[0].Defendant_Accept_Decline==false && lstScheduleofLoss[0].Claimaint_Arbitration_Submitted==true){            
                ShowConfirmItems = true;            
            }
       */
            
            if(LOGGEDINUSER == 'Defendant Handler' && lstScheduleofLoss[0].Defendant_Arbitration_Submitted==false){
                ReferallItems=true;
                ShowSubmitItems = true;
                SubmitItems = false;
                
            }
            if(LOGGEDINUSER == 'Defendant Handler' && lstScheduleofLoss[0].Defendant_Arbitration_Submitted==true ){ //Remove Accept/Decline && lstScheduleofLoss[0].Defendant_Accept_Decline==false
                ReferallItems=false;
                SubmitItems = true;
                //Remove Accept/Decline -- ConfirmItems = false;               
                               
            }
            
            
            if(LOGGEDINUSER == 'Defendant Handler' && lstScheduleofLoss[0].Defendant_Accept_Decline==true && lstScheduleofLoss[0].Claimant_Accept_Decline==false){
                ReferallItems=false;
                //Remove Accept/Decline -- ConfirmItems = true;
                SubmitItems = true;
            }
             
            
            if(LoggedUser && lstScheduleofLoss[0].Defendant_Arbitration_Submitted==true && lstScheduleofLoss[0].Claimaint_Arbitration_Submitted==true){
                ReferallItems=false;
                //Remove Accept/Decline -- ConfirmItems = true;
                SubmitItems = true;
                
                ShowUpdateDocument = true;
                ShowConfirmDocument = true;
                
                UpdateDocument=false;
                ConfirmDocument =false;
            }
            
            if(LOGGEDINUSER == 'Claimant Handler' && lstScheduleofLoss[0].Claimant_Confirm_Documents){
                UpdateDocument=false;
                ConfirmDocument =true;
                
                ShowUpdateDocument = false;
                ShowConfirmDocument = false;
            }
            if(LOGGEDINUSER == 'Defendant Handler' && lstScheduleofLoss[0].Defendant_Confirm_Documents){
                UpdateDocument=false;
                ConfirmDocument =true;
                
                ShowUpdateDocument = false;
                ShowConfirmDocument = false;
            }
            
            if(LoggedUser && lstScheduleofLoss[0].Claimant_Confirm_Documents && lstScheduleofLoss[0].Defendant_Confirm_Documents){
                ConfirmFinal =false;
                
                ConfirmDocument =true;
                ConfirmItems = true;
                SubmitItems = true;
                ShowConfirmFinal = true;
            }
            
            
            
            if(LOGGEDINUSER == 'Claimant Handler' && lstScheduleofLoss[0].Claimant_Final_Offer){
                ConfirmFinal =true;
                ShowConfirmFinal = false;
                 
            }
            if(LOGGEDINUSER == 'Defendant Handler' && lstScheduleofLoss[0].Defendant_Final_Offer){
                ConfirmFinal =true;
                ShowConfirmFinal = false;
                 
            }
            if(LOGGEDINUSER=='Arbitrator'&&lstScheduleofLoss[0].Claimant_Final_Offer && lstScheduleofLoss[0].Defendant_Final_Offer){
                
                
                ConfirmFinal =true;
                
                ConfirmDocument =true;
                ConfirmItems = true;
                SubmitItems = true;
                
                
                SubmitAward=false;
                
                
                ShowPreviewAward = true;
                ShowSubmitAward = true;
            }      
            if(lstScheduleofLoss[0].Arbitrators_Award){
                SubmitAward=true;
                ShowPreviewAward = false;
                ShowSubmitAward = false;                            
            }   
            if(LOGGEDINUSER=='Arbitrator' && lstScheduleofLoss[0].Arbitrators_Award){
                RefreshAwardDoc=true;                           
            }
      }      
 } 
    

 Public void generateLossitemList(ID CaseID){
          
     List<Loss_Category__c> LossCategory;  
     List<Loss_Sub_Categories__c> LossSubCategories;
          
          //system.debug('**StartRecId**'+StartRecId);
          
      lstScheduleofLoss = new  List<ScheduleofLoss>(); 
  
      //lstScheduleofLoss ScheduleofLoss 
        
        List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c,
         Claimant_Accept_Decline__c, Defendant_Accept_Decline__c,Arbitrators_Award_Finalised__c,  Claimant_Final_Offer_Confirmed__c,Defendant_Final_Offer_Confirmed__c,Claimant_Confirm_Documents_Uploaded__c, 
         Defendant_Confirm_Documents_uploaded__c,Name,Case__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c Where Case__c =: CaseID AND No_referral_date_passed__c=:True]);
        
          LossCategory = new List<Loss_Category__c>([SELECT id,Total_Claimant_Position__c,Rationale__c,Schedule_of_Losses__c,Head_of_Loss_Type__c FROM Loss_Category__c where Case__c =:CaseID]);
          LossSubCategories = new List<Loss_Sub_Categories__c>([SELECT Id,Arbitrated_by__c,Loss_Type__c,Arbitrator_Rationale__c,Arbitration_Referred_By__c,Arbitration_Accepted_Status__c,Past_Future_Financial_Item__c, Sub_Category__c,Defendant_Position__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c WHERE (Status__c = 'Negotiating' OR Status__c = 'Referred to Arbitration' OR Status__c ='Arbitration Doc Prep' OR Status__c ='Arbitration Final Offers' OR Status__c ='Arbitrating' OR Status__c ='Arbitrated') AND Loss_Category__c in:  LossCategory AND Arbitrated_by__c=:null]);
          List<Merit__c> lstMerit = new List<Merit__c>([Select id,Arbitrator_Rationale__c,Status__c,Arbitration_Accepted_Status__c,Defendant_Position__c,Arbitration_Referred_By__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Related_Case__c =:CaseID AND (Status__c = 'Negotiating' OR Status__c = 'Referred to Arbitration' OR Status__c ='Arbitration Doc Prep' OR Status__c ='Arbitration Final Offers' OR Status__c ='Arbitrating' OR Status__c ='Arbitrated') AND Arbitrated_by__c=:null]);
          
          Loss_Category_Files__c[] lstCategoryFiles = [Select File_Comments__c,LossCategoryId__c,Loss_Sub_Category__r.Loss_Type__c,   File_Name__c,File_Url__c From Loss_Category_Files__c where     Loss_Sub_Category__c in:  LossSubCategories];
          
            
          List<LossItem> lstLossItems;
           
     
     system.debug('**Cat**'+LossCategory);
     system.debug('**Sub**'+LossSubCategories);
     
    
    
    for(Schedule_of_Losses__c s:ScheduleofLosses){
    
    ScheduleofLoss Schedule = new ScheduleofLoss();
    Schedule.TotalDefendant=0;
    Schedule.TotalClaimant=0;
    lstLossCategory = new List<LossCategory>();
    
    Boolean LoggedUser=false;
    
    if(LOGGEDINUSER == 'Claimant Handler' || LOGGEDINUSER == 'Defendant Handler'){
       LoggedUser=true;
   }
  Map<String,List<CaseFiles>> Map_LossFile = new Map<String,List<CaseFiles>>(); 
   
  if(LossSubCategories.size()>0 ){
  
   Map_LossFile = HeadOfLossSelectedFiles();   
    List<CaseFiles> lstLossFiles;
        for(Loss_Category__c p:LossCategory){
        
           if(p.Schedule_of_Losses__c == s.id){ 
              LossCategory Category = new LossCategory(); 
              lstLossItems = new List<LossItem>();     
              Category.ClaimantPosition =0;
              
              Schedule.TotalClaimant = Schedule.TotalClaimant + p.Total_Claimant_Position__c;
                   for(Loss_Sub_Categories__c c:LossSubCategories){
                   
                       if(c.Loss_Category__c==p.id){
                                   
                                //Schedule.TotalDefendant=Schedule.TotalDefendant+c.Sum_Defendent_Position__c;
                                   
                                if((c.Status__c == 'Referred to Arbitration') || (c.Status__c == 'Arbitration Doc Prep') || (c.Status__c =='Arbitration Final Offers') || (c.Status__c =='Arbitrating') || (c.Status__c =='Arbitrated') || (c.Status__c== 'Negotiating' && (s.Claimaint_Arbitration_Submitted__c ==false || s.Defendant_Arbitration_Submitted__c==false))){   
                                     system.debug('**IN1**');
                                    
                                     LossItem Items = new LossItem();
                                    // Items.PastFutureLosses = c.Past_Future_Financial_Losses__r.Name;
                                    
                                     Items.Type = c.RecordType.DeveloperName;
                                     Items.ClaimantPosition = c.Claimant_Position__c;
                                     Items.ArbitratorsPosition =c.Arbitrator_Award__c;
                                     Items.DefendantPosition = c.Defendant_Position__c;
                                     
                                     Items.ClaimantRWE = Claimant;
                                     Items.ArbitratorRWE = Arbitrator;
                                     Items.DefendantRWE =  Defendant; 
                                      
                                     Items.PastFutureFinancialLosses =  c.Loss_Type__c; 
                                                        
                                     Items.ItemName = c.Name;
                                     Items.Stage= c.Stage__c;
                                     Items.Status= c.Status__c;
                                     Items.CatId = p.id;
                                     Items.RecId = c.id;
                                     Items.ArbitratedBy = c.Arbitrated_by__c;
                                     
                                      Items.ArbitrationAcceptedStatus = c.Arbitration_Accepted_Status__c;
                                      Items.ArbitrationReferredBy = c.Arbitration_Referred_By__c;
                                     Items.ArbitrationRationale = c.Arbitrator_Rationale__c;
                                      
                                          
                                    if((s.Claimaint_Arbitration_Submitted__c == false && LOGGEDINUSER == 'Claimant Handler') || (s.Defendant_Arbitration_Submitted__c ==false && LOGGEDINUSER == 'Defendant Handler') ){
                                         if(c.Arbitration_Referred_By__c == LOGGEDINUSER && (c.Arbitration_Accepted_Status__c==null || s.Bilateral_referral_date_passed__c==true)){
                                                  
                                                  Items.StageCancelSubmit=true;                                  
                                          }
                                          else if(LoggedUser && c.Arbitration_Accepted_Status__c==null && c.Arbitration_Referred_By__c == null){
                                              Items.StageSubmit= true;
                                          }
                                          else if(LoggedUser && c.Arbitration_Accepted_Status__c==null && c.Arbitration_Referred_By__c != null){
                                              Items.StageAccept = true;
                                              Items.StageReject = true;
                                              
                                          }
                                          else if(LoggedUser && c.Arbitration_Accepted_Status__c=='Accepted' && c.Arbitration_Referred_By__c != LOGGEDINUSER){
                                              Items.StageAccept = false;
                                              Items.StageReject = true;
                                          }
                                          else if(LoggedUser && c.Arbitration_Accepted_Status__c=='Declined' && c.Arbitration_Referred_By__c != LOGGEDINUSER){
                                              Items.StageAccept = true;
                                              Items.StageReject = false;
                                          }
                                          
                                          if(s.Bilateral_referral_date_passed__c==true){
                                              
                                              Items.StageAccept = false;
                                              Items.StageReject = false;
                                          }
                                           
                                   }
                                   else{
                                     
                                     if((s.Claimaint_Arbitration_Submitted__c == true && LOGGEDINUSER == 'Claimant Handler') || (s.Defendant_Arbitration_Submitted__c ==true && LOGGEDINUSER == 'Defendant Handler')){
                                         system.Debug('**STATUS**'+c.Arbitration_Accepted_Status__c+'**USER**'+c.Arbitration_Referred_By__c);
                                         
                                          if(c.Arbitration_Accepted_Status__c==null && c.Arbitration_Referred_By__c != LOGGEDINUSER){
                                              Items.StageAccept = true;
                                              Items.StageReject = true;
                                              
                                          }
                                     
                                     
                                     }  
                                   
                                   
                                     if(c.Arbitration_Referred_By__c != Null){    
                                          Items.StageSubmit= false;
                                          if(c.Arbitration_Referred_By__c == LOGGEDINUSER && s.Claimaint_Arbitration_Submitted__c==false){
                                              Items.StageCancelSubmit=True;                                  
                                          }
                                          else{
                                              Items.StageCancelSubmit=false;
                                          }     
                                      }
                                      else{
                                          Items.StageSubmit= true;
                                          Items.StageCancelSubmit=false;
                                      }
                                    
                                 }      
                                      
                                      
                                         
                                     lstLossItems.Add(Items);
                                   
                                   
                                   
                                     Category.ClaimantPosition = Category.ClaimantPosition+c.Claimant_Position__c;
                                     
                                   }  
                                 } 
                    } 
                   // lstDocuments = new List<Documentlist> ();
                    lstLossFiles = new List<CaseFiles>(); 
                    if(Map_LossFile.get(p.id) != null){
                        lstLossFiles = Map_LossFile.get(p.id);
                    }
                    /*
                    for(Loss_Category_Files__c file:lstCategoryFiles){
                        if(file.LossCategoryId__c==p.id){
                        
                          lstLossFiles = Map_LossFile.get(file.id); //populateCaseFiles('Loss',file.id);  
                            
                            //Documentlist doc = new Documentlist();
                            //doc.LossItem = file.Loss_Sub_Category__r.Loss_Type__c;
                            //doc.DocumentName  = file.File_Name__c;
                            //doc.DocumentType  = '';
                            //doc.DocumentLink = file.File_Url__c;
                            //lstDocuments.add(doc);
                            
                        }    
                            
                        //DocumentName DocumentType DocumentLink
                    }
                    */
                    
             if(lstLossItems.size()>0){       
                 //Category.lstDocuments = lstDocuments;
                 if(lstLossFiles.size()>0){       
                     Category.lstLossFiles = lstLossFiles;
                     Category.DocumentCount=1;
                 }
                 else{
                     Category.DocumentCount=0;
                 }
                 Category.CategoryId = p.id; 
                 Category.lstLossItems = lstLossItems;
                 Category.ArbitrationRationale=p.Rationale__c;
                 Category.CategoryName = p.Head_of_Loss_Type__c;
                 lstLossCategory.Add(Category); 
             }
             
           }                               
         }
      } 
     if(lstMerit.size()>0){ 
        
         List<Merit> lstMeritSched = new List<Merit> ();
         for(Merit__c m:lstMerit){
             
             if(m.Schedule_of_Losses__c ==s.id){
               if((m.Status__c == 'Referred to Arbitration') || (m.Status__c == 'Arbitration Doc Prep') || (m.Status__c =='Arbitration Final Offers') || (m.Status__c =='Arbitrating') || (m.Status__c =='Arbitrated') || (m.Status__c== 'Negotiating' && (s.Claimaint_Arbitration_Submitted__c ==false || s.Defendant_Arbitration_Submitted__c==false))){ 
                 Merit Mer = new Merit();
                 Mer.MeritName  =m.name;
                 Mer.MeritId =m.id;
                 Mer.ClaimantPosition =m.Claimant_Position__c;
                 Mer.DefendantPosition =m.Defendant_Position__c;
                 Mer.Status=m.Status__c;
                 Mer.ArbitratorsPosition=m.Arbitrator_Award__c;
                 Mer.ArbitrationReferredBy = m.Arbitration_Referred_By__c;
                 Mer.ArbitrationAcceptedStatus = m.Arbitration_Accepted_Status__c;
                 Mer.ArbitrationRationale = m.Arbitrator_Rationale__c;
                 
                 system.debug('***MER1**');
                     if((s.Claimaint_Arbitration_Submitted__c == false && LOGGEDINUSER == 'Claimant Handler') || (s.Defendant_Arbitration_Submitted__c ==false && LOGGEDINUSER == 'Defendant Handler')){
                               
                               system.debug('***MER2**'+m.Arbitration_Referred_By__c +'****** '+ m.Arbitration_Accepted_Status__c);
                               
                                         if(m.Arbitration_Referred_By__c == LOGGEDINUSER && (m.Arbitration_Accepted_Status__c==null || s.Bilateral_referral_date_passed__c==true)){
                                               Mer.StageCancelSubmit=true;                                 
                                          }
                                          else if(LoggedUser && m.Arbitration_Accepted_Status__c==null && m.Arbitration_Referred_By__c == null){
                                              
                                              Mer.StageSubmit= true;
                                          }
                                          else if(LoggedUser && m.Arbitration_Accepted_Status__c==null && m.Arbitration_Referred_By__c != null){
                                              Mer.StageAccept = true;
                                              Mer.StageReject = true;
                                              
                                          }
                                          else if(LoggedUser && m.Arbitration_Accepted_Status__c=='Accepted' && m.Arbitration_Referred_By__c != LOGGEDINUSER ){
                                              Mer.StageAccept = false;
                                              Mer.StageReject = true;
                                          }
                                          else if(LoggedUser && m.Arbitration_Accepted_Status__c=='Declined' && m.Arbitration_Referred_By__c != LOGGEDINUSER ){
                                              Mer.StageAccept = true;
                                              Mer.StageReject = false;
                                          }
                                          
                                          if(s.Bilateral_referral_date_passed__c==true){
                                              
                                               Mer.StageAccept = false;
                                               Mer.StageReject = false;
                                          }
                                          
                                           
                                   }
                  else{
                                       
                           if((s.Claimaint_Arbitration_Submitted__c == true && LOGGEDINUSER == 'Claimant Handler') || (s.Defendant_Arbitration_Submitted__c ==false && LOGGEDINUSER == 'Defendant Handler')){
                                         
                                         if(LoggedUser && m.Arbitration_Accepted_Status__c==null && m.Arbitration_Referred_By__c !=  LOGGEDINUSER){
                                              Mer.StageAccept = true;
                                              Mer.StageReject = true;
                                              
                                          }
                                     
                                     
                           }              
                                       
                          if(m.Arbitration_Referred_By__c != Null){    
                                          Mer.StageSubmit= false;
                                 if(m.Arbitration_Referred_By__c == LOGGEDINUSER && s.Claimaint_Arbitration_Submitted__c==false){
                                              Mer.StageCancelSubmit=True;                                  
                                  }
                                  else{
                                              Mer.StageCancelSubmit=false;
                                  }     
                          }
                          else{
                                          Mer.StageSubmit= true;
                                          Mer.StageCancelSubmit=false;
                          }
                                    
                 }      
                 
                 
                 
                 
                 
                 
                     lstMeritSched.Add(Mer);
                }     
                 
             }
         }
         
         Schedule.lstMeritSched = lstMeritSched;
     }    
         
         Schedule.ScheduleId = s.id;
         
       Schedule.Claimant_Accept_Decline =   s.Claimant_Accept_Decline__c;  
       Schedule.Defendant_Accept_Decline =  s.Defendant_Accept_Decline__c;
         Schedule.Defendant_Arbitration_Submitted = s.Defendant_Arbitration_Submitted__c;
         Schedule.Claimaint_Arbitration_Submitted = s.Claimaint_Arbitration_Submitted__c;
         
         Schedule.Claimant_Confirm_Documents = s.Claimant_Confirm_Documents_Uploaded__c;
         Schedule.Defendant_Confirm_Documents = s.Defendant_Confirm_Documents_uploaded__c;
         
          Schedule.Claimant_Final_Offer = s.Claimant_Final_Offer_Confirmed__c;
         Schedule.Defendant_Final_Offer = s.Defendant_Final_Offer_Confirmed__c;
         Schedule.Arbitrators_Award = s.Arbitrators_Award_Finalised__c;
         
         Schedule.NOREFERAL = s.No_referral_date_passed__c; 
         Schedule.BILATERALREFER = s.Bilateral_referral_date_passed__c;
         Schedule.UNILATERALREFER = s.Unilateral_referral_date_passed__c;
         
         TotalClaimant = Schedule.TotalClaimant;
        
         Schedule.ScheduleName = s.Name;
         Schedule.lstLossCategory = lstLossCategory;
         lstScheduleofLoss.Add(Schedule); 
         
         
         
        } 
         
         
      
     
      
        
     
 }


//-----------------------------------Actions

Public void UpdateItem(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
    String StrAMnt = apexpages.currentpage().getparameters().get('Amount');
    Decimal ItemAmount;
    if(StrAMnt != null && StrAMnt !=''){  
        system.debug('**AMNT**'+apexpages.currentpage().getparameters().get('Amount'));  
        ItemAmount = Decimal.valueof(apexpages.currentpage().getparameters().get('Amount'));
    }
    DisplayMsg ='';
    
   Loss_Sub_Categories__c[]  LossSubCategories  = [SELECT Id,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where id =:  RecId];
         
    for(ScheduleofLoss sched:lstScheduleofLoss){
    
            for(LossCategory cat:sched.lstLossCategory){
            
                for(LossItem item:cat.lstLossItems){
                    
                        if(LossSubCategories[0].id == item.RecId){
                            if(LOGGEDINUSER == 'Claimant Handler'){
                                LossSubCategories[0].Claimant_Position__c = item.ClaimantPosition=ItemAmount;
                            }
                            LossSubCategories[0].Arbitrator_Award__c = item.ArbitratorsPosition;
                            if(LOGGEDINUSER == 'Defendant Handler'){
                                LossSubCategories[0].Defendant_Position__c = item.DefendantPosition;
                            }
                            
                            
                            
                            if(item.ClaimantPosition == item.DefendantPosition){
                                LossSubCategories[0].Arbitration_Referred_By__c =null;
                                LossSubCategories[0].Arbitration_Accepted_Status__c = null;
                            }
                        }
                }
            }
    
    }
    
   try{   
        update LossSubCategories;
   }     
   catch(exception e){
   
        DisplayMsg = e.getMessage();
   }
    
   if(DisplayMsg ==''){ 
    generateLossitemList(CurrentCase.id);
   } 
    
    
}




Public Loss_Sub_Categories__c NewLossItem {get;set;}
Public void SaveItem(){

    Insert NewLossItem;

}




Public String LossArbitrationRationale {get;set;}
Public String ItemArbitrationRationale {get;set;}
Public String ItemId {get;set;}
Public String LossId {get;set;}


Public void InitateRationale(){
 
    String LossRecId = apexpages.currentpage().getparameters().get('RecId');
    
    Loss_Sub_Categories__c[]  LossSubCategories  = [SELECT Id,Defendant_Rationale__c,Claimant_Rationale__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where id =:  LossRecId];
    List<Loss_Category__c> LossCategory = new List<Loss_Category__c>([SELECT id,Schedule_of_Losses__c,Head_of_Loss_Type__c FROM Loss_Category__c where id =:LossRecId]);
     List<Merit__c> lstMerit = new List<Merit__c>([Select id,Status__c,Arbitration_Accepted_Status__c,Defendant_Position__c,Arbitration_Referred_By__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where id =:LossRecId]);
               
    for(ScheduleofLoss sched:lstScheduleofLoss){
    
            for(LossCategory cat:sched.lstLossCategory){
                        
                if(LossRecId ==cat.CategoryId ){        
                        ItemArbitrationRationale =  cat.ArbitrationRationale;
                        ItemId = cat.CategoryId;
                }
                else if(LossCategory.size()==0){   
                        if(cat.lstLossItems != null){    
                            for(LossItem item:cat.lstLossItems){
                        
                                if(LossRecId == item.RecId){
                                    ItemArbitrationRationale =  item.ArbitrationRationale;
                                     
                                    ItemId = item.RecId; 
                                }
                            }
                        }    
                 }                  
                       
            } 
            if(sched.lstMeritSched != null){          
                for(Merit merit:sched.lstMeritSched){
                           if(LossRecId == merit.MeritId){
                                ItemArbitrationRationale =  merit.ArbitrationRationale;                                
                                ItemId = merit.MeritId; 
                            }           
                                     
               }  
           }    
    }
}

Public void UpdateRationale(){
     
   List<Loss_Category__c> LossCategory = new List<Loss_Category__c>([SELECT id,Rationale__c,Schedule_of_Losses__c,Head_of_Loss_Type__c FROM Loss_Category__c where id =:ItemId]);
   Loss_Sub_Categories__c[]  LossSubCategories  = [SELECT Id,Arbitrator_Rationale__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where id =:  ItemId];
   List<Merit__c> lstMerit = new List<Merit__c>([Select id,Status__c,Arbitrator_Rationale__c,Arbitration_Accepted_Status__c,Defendant_Position__c,Arbitration_Referred_By__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where id =:  ItemId]);
                   
    
    system.debug('**ItemId**'+ItemId);     
    for(ScheduleofLoss sched:lstScheduleofLoss){
    
            for(LossCategory cat:sched.lstLossCategory){
            
               if(ItemId == cat.CategoryId){     
                         LossCategory[0].Rationale__c = ItemArbitrationRationale;
               }
               
               else if(LossCategory.size()==0){ 
                 if(cat.lstLossItems != null){ 
                     for(LossItem item:cat.lstLossItems){
                        
                            if(ItemId == item.RecId){
                            
                                system.debug('**IN ITEM**');
                                LossSubCategories[0].Arbitrator_Rationale__c = ItemArbitrationRationale;
                              
                               
                             }
                          }
                      }      
               } 
                
               
            }
          if(sched.lstMeritSched != null){  
            for(Merit merit:sched.lstMeritSched){
                       if(ItemId == merit.MeritId){
                           lstMerit[0].Arbitrator_Rationale__c = ItemArbitrationRationale;                                                             
                        }           
            }  
          }   
    }
    update LossCategory;
     update LossSubCategories;
     update lstMerit;
    generateLossitemList(StartRecId);
    
}




Public void ReferItem(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
    Loss_Sub_Categories__c[]  LossSubCategories  = [SELECT Id,Arbitration_Referred_By__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where id =:  RecId];
     
   for(ScheduleofLoss sched:lstScheduleofLoss){
    
            for(LossCategory cat:sched.lstLossCategory){
             
                   for(LossItem item:cat.lstLossItems){
                    
                        if(RecId == item.RecId){
                            item.StageSubmit=false;
                            item.ArbitrationReferredBy = LOGGEDINUSER;
                            LossSubCategories[0].Arbitration_Referred_By__c= LOGGEDINUSER;
                            item.StageCancelSubmit=True;  
                            item.Status =  'Referred to Arbitration';                               
                            LossSubCategories[0].status__c = 'Referred to Arbitration'; 
                            
                            if(Sched.BILATERALREFER==true){
                                item.ArbitrationAcceptedStatus = 'Accepted';
                                LossSubCategories[0].Arbitration_Accepted_Status__c= 'Accepted';
                                item.Status =  'Arbitration Doc Prep';                               
                                LossSubCategories[0].status__c = 'Arbitration Doc Prep';
                                
                                item.StageReject=false;
                                item.StageAccept=False;
                            }
                             
                        }
            }
    }
  }        
 update LossSubCategories;  
  
}
Public void ReferAllItems(){

    String ShedId = apexpages.currentpage().getparameters().get('ShedId');
       
         List<Loss_Sub_Categories__c>  LossSubCategories = new List<Loss_Sub_Categories__c>([SELECT Id,Arbitration_Referred_By__c,Arbitration_Accepted_Status__c,Past_Future_Financial_Item__c, Sub_Category__c,Defendant_Position__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c WHERE (Status__c = 'Negotiating' OR Status__c = 'Referred to Arbitration' ) AND Case__c =:  CurrentCase.id AND Arbitrated_by__c=:null]);
         List<Merit__c> lstMerit = new List<Merit__c>([Select id,Status__c,Arbitration_Accepted_Status__c,Defendant_Position__c,Arbitration_Referred_By__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Related_Case__c =:CurrentCase.id]);
        
         system.debug('**LC**'+LossSubCategories+'*****'+CurrentCase.id);
   for(ScheduleofLoss sched:lstScheduleofLoss){
    
            for(LossCategory cat:sched.lstLossCategory){
             
                   for(LossItem item:cat.lstLossItems){
                    
                         if(item.ArbitrationReferredBy =='' || item.ArbitrationReferredBy ==null){
                            item.StageSubmit=false;
                            item.ArbitrationReferredBy = LOGGEDINUSER;                            
                            item.StageCancelSubmit=True;  
                            item.Status =  'Referred to Arbitration';                               
                               
                         }
                        if(Sched.BILATERALREFER==true){
                                item.ArbitrationAcceptedStatus = 'Accepted';                                 
                                item.Status =  'Arbitration Doc Prep';                               
                                item.StageReject=false;
                                item.StageAccept=False;
                        } 
                         
                }
            }
            if(sched.lstMeritSched != null){          
                for(Merit merit:sched.lstMeritSched){
                      if(merit.ArbitrationReferredBy=='' || merit.ArbitrationReferredBy==null){             
                          lstMerit[0].Status__c = 'Referred to Arbitration';
                          lstMerit[0].Arbitration_Referred_By__c = LOGGEDINUSER; 
                           merit.Status = 'Referred to Arbitration'; 
                           merit.ArbitrationReferredBy=   LOGGEDINUSER;  
                           merit.StageCancelSubmit = true;
                           merit.StageSubmit  = false;         
                      }  
                      if(Sched.BILATERALREFER==true){
                                merit.ArbitrationAcceptedStatus = 'Accepted';                                 
                                merit.Status =  'Arbitration Doc Prep'; 
                                lstMerit[0].Status__c = 'Arbitration Doc Prep';  
                                lstMerit[0].Arbitration_Accepted_Status__c ='Accepted';                              
                                merit.StageReject=false;
                                merit.StageAccept=False;
                      } 
                                     
               }  
           }    
  }  
  
  for(Loss_Sub_Categories__c  loss:LossSubCategories){ 
      if(loss.Arbitration_Referred_By__c=='' || loss.Arbitration_Referred_By__c ==null){    
        loss.Arbitration_Referred_By__c= LOGGEDINUSER;                            
        loss.status__c = 'Referred to Arbitration';
      } 
      if(lstScheduleofLoss[0].BILATERALREFER==true){          
          loss.Arbitration_Accepted_Status__c= 'Accepted';
          loss.Arbitration_Referred_By__c= LOGGEDINUSER;                               
          loss.status__c = 'Arbitration Doc Prep';
      } 
  }      
  
  
 update  lstMerit;      
 update LossSubCategories;  
  
}


Public void CancelReferItem(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
    Loss_Sub_Categories__c[]  LossSubCategories  = [SELECT Id,Arbitration_Referred_By__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where id =:  RecId];
     
   for(ScheduleofLoss sched:lstScheduleofLoss){
    
            for(LossCategory cat:sched.lstLossCategory){
             
                   for(LossItem item:cat.lstLossItems){
                    
                        if(RecId == item.RecId){
                            item.StageSubmit=True; 
                            item.ArbitrationReferredBy = '';
                            LossSubCategories[0].Arbitration_Referred_By__c= null;
                            item.StageCancelSubmit=false;  
                            item.Status =  'Negotiating';                               
                            LossSubCategories[0].status__c = 'Negotiating';  
                            item.ArbitrationAcceptedStatus = ''; 
                            LossSubCategories[0].Arbitration_Accepted_Status__c= '';
                        }
            }
    }
  }        
 update LossSubCategories;  
  
  
}

/*

Public void SubmitItems(){

   String ShedId = apexpages.currentpage().getparameters().get('ShedId');
   Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Name,Case__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c Where id =: ShedId];
        
   Boolean LoggedUser=false; 
   
   if(LOGGEDINUSER == 'Claimant Handler' || LOGGEDINUSER == 'Defendant Handler'){
       LoggedUser=true;
   }
  
      
   for(ScheduleofLoss sched:lstScheduleofLoss){
         
         if(sched.ScheduleId==ShedId){   
            if(LOGGEDINUSER == 'Claimant Handler'){
                ScheduleofLosses[0].Claimaint_Arbitration_Submitted__c=true;
                sched.Claimaint_Arbitration_Submitted=true;
            }
            else if(LOGGEDINUSER == 'Defendant Handler'){
                ScheduleofLosses[0].Defendant_Arbitration_Submitted__c=true;
                sched.Defendant_Arbitration_Submitted=true;
            }
            
            if((ScheduleofLosses[0].Defendant_Arbitration_Submitted__c==true && LOGGEDINUSER == 'Defendant Handler') || (LOGGEDINUSER == 'Claimant Handler' && ScheduleofLosses[0].Claimaint_Arbitration_Submitted__c==true)){
                    for(LossCategory cat:sched.lstLossCategory){
                     
                           for(LossItem item:cat.lstLossItems){
                              
                                item.StageCancelSubmit=false;     
                                item.StageSubmit=False;
                               
                            }
                    }
           }         
       }
  
    }
    
    Update ScheduleofLosses;
     system.debug('***CurrentCase***'+CurrentCase);
      generateLossitemList(CurrentCase.id);
     
    DetermineStage();
}

*/





Public Boolean AllItemsResponded {get;set;}



Public void SubmitItems(){
    
   String ShedId = apexpages.currentpage().getparameters().get('ShedId');
   Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Name,Case__c,Arbitration_Start_Date__c,Final_Offers_Duration__c,Doc_Prep_Duration__c,Claimant_Accept_Decline__c,Defendant_Accept_Decline__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c Where id =: ShedId];
   Loss_Sub_Categories__c[]  LossSubCategories;
    List<Merit__c> lstMerit;
    
   system.debug('**ShedId**'+ShedId);
       
   Boolean LoggedUser=false;
   Boolean OppositionBacktoReferal=false; 
   
   if(LOGGEDINUSER == 'Claimant Handler' || LOGGEDINUSER == 'Defendant Handler'){
       LoggedUser=true;
   }
   
   AllItemsResponded=false;
    
   Integer TotalItems=0,TotalDeclined=0;   
   for(ScheduleofLoss sched:lstScheduleofLoss){
         
         if(sched.ScheduleId==ShedId){ 
           
            if(LOGGEDINUSER == 'Claimant Handler'){
                    if(sched.lstLossCategory != null){
                            for(LossCategory cat:sched.lstLossCategory){                     
                                       for(LossItem item:cat.lstLossItems){
                                           if(item.ArbitrationReferredBy=='Defendant Handler' && item.ArbitrationAcceptedStatus ==null){
                                              system.debug('**Confirm1**');
                                              AllItemsResponded=true; 
                                           }
                                           if(item.ArbitrationReferredBy=='Claimant Handler' && item.ArbitrationAcceptedStatus ==null){
                                               
                                              OppositionBacktoReferal = true; 
                                           }
                                       }
                            }
                    }  
                    if(sched.lstMeritSched != null){   
                        for(Merit merit:sched.lstMeritSched){                                
                                   if(merit.ArbitrationReferredBy=='Defendant Handler' && merit.ArbitrationAcceptedStatus ==null){
                                          system.debug('**Confirm2**');
                                          AllItemsResponded=true; 
                                   } 
                                   if(merit.ArbitrationReferredBy=='Claimant Handler' && merit.ArbitrationAcceptedStatus ==null){
                                       OppositionBacktoReferal = true;
                                   }
                                                                                                      
                        }
                    }    
                        system.debug('**Confirm3**'+AllItemsResponded);
                        if(AllItemsResponded==false){          
                            ScheduleofLosses[0].Claimaint_Arbitration_Submitted__c=true;
                            sched.Claimaint_Arbitration_Submitted=true;
                        }
                        if(OppositionBacktoReferal == true){
                            ScheduleofLosses[0].Defendant_Arbitration_Submitted__c=false;
                            sched.Defendant_Arbitration_Submitted=false;
                        }
                            
            }
            else if(LOGGEDINUSER == 'Defendant Handler'){
                      if(sched.lstLossCategory != null){
                          for(LossCategory cat:sched.lstLossCategory){
                                 
                                       for(LossItem item:cat.lstLossItems){
                                           if(item.ArbitrationReferredBy=='Claimant Handler' && item.ArbitrationAcceptedStatus ==null){
                                              AllItemsResponded=true; 
                                           }
                                           if(item.ArbitrationReferredBy=='Defendant Handler' && item.ArbitrationAcceptedStatus ==null){
                                               
                                              OppositionBacktoReferal = true; 
                                           }
                                       }
                            }
                        }
                     if(sched.lstMeritSched != null){         
                        for(Merit merit:sched.lstMeritSched){                                
                                   if(merit.ArbitrationReferredBy=='Claimant Handler' && merit.ArbitrationAcceptedStatus ==null){
                                          AllItemsResponded=true; 
                                   }
                                   if(merit.ArbitrationReferredBy=='Defendant Handler' && merit.ArbitrationAcceptedStatus ==null){
                                       OppositionBacktoReferal = true;
                                   }                                                                    
                        }
                     }   
                        system.debug('**Confirm3**'+AllItemsResponded);
                        if(AllItemsResponded==false){                      
                            ScheduleofLosses[0].Defendant_Arbitration_Submitted__c=true;
                            sched.Defendant_Arbitration_Submitted=true;
                        }  
                        if(OppositionBacktoReferal == true){
                            ScheduleofLosses[0].Claimaint_Arbitration_Submitted__c=false;
                            sched.Claimaint_Arbitration_Submitted=false;
                        }  
            }
        //Check if all declined  
           if(sched.lstLossCategory != null){
               for(LossCategory cat:sched.lstLossCategory){                     
                          for(LossItem item:cat.lstLossItems){
                              TotalItems++;
                               if(item.ArbitrationAcceptedStatus =='Declined'){
                                 TotalDeclined++;            
                               }
                          }
               }
           }
           if(sched.lstMeritSched != null){     
               for(Merit merit:sched.lstMeritSched){ 
                     TotalItems++;                                 
                     if(merit.ArbitrationAcceptedStatus =='Declined'){
                          TotalDeclined++;  
                     }                                                                    
               }   
           }
           if(TotalItems==TotalDeclined){
               ScheduleofLosses[0].Defendant_Arbitration_Submitted__c=false; 
               ScheduleofLosses[0].Claimaint_Arbitration_Submitted__c=false;
               ScheduleofLosses[0].Defendant_Arbitration_Submitted__c=false;
               ScheduleofLosses[0].Claimaint_Arbitration_Submitted__c=false;
               
               LossSubCategories = [SELECT Id,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where Loss_Category__r.Schedule_of_Losses__c =:  ShedId AND Status__c!='Arbitrated' AND Status__c!='Settled' AND Arbitrated_by__c=:null];
               for(Loss_Sub_Categories__c  item:LossSubCategories){
                  item.Refer_to_Arbitration__c = false;
                  item.Arbitration_Accepted_Status__c='';
                  item.Arbitration_Referred_By__c='';
               }
               update LossSubCategories; 
               
               lstMerit = new List<Merit__c>([Select id,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Schedule_of_Losses__c =:  ShedId AND Status__c !='Arbitrated' AND Status__c !='Settled'  AND Arbitrated_by__c=:null]);
    
                  for(Merit__c merit:lstMerit){           
                          merit.Arbitration_Referred_By__c =''; 
                          merit.Arbitration_Accepted_Status__c='';     
                  }
      
                  update lstMerit; 

           
           }            
           else if(ScheduleofLosses[0].Defendant_Arbitration_Submitted__c==true && ScheduleofLosses[0].Claimaint_Arbitration_Submitted__c==true){
                    for(LossCategory cat:sched.lstLossCategory){
                     
                           for(LossItem item:cat.lstLossItems){
                            
                                if(LOGGEDINUSER == item.ArbitrationReferredBy){
                                    item.StageAccept=false;
                                    item.StageReject=false;
                                }
                                else if(LOGGEDINUSER != item.ArbitrationReferredBy && LoggedUser){
                                    item.StageReject=True;
                                    item.StageAccept=True;
                                }    
                                item.StageCancelSubmit=false;     
                                item.StageSubmit=False;
                               
                            }
                    }
                    ScheduleofLosses[0].Doc_Prep_Start_Date__c = system.today();   
                   // ScheduleofLosses[0].Final_Offers_Start_Date__c =  ScheduleofLosses[0].Doc_Prep_Start_Date__c + integer.valueof(ScheduleofLosses[0].Doc_Prep_Duration__c) +1; 
                  //  ScheduleofLosses[0].Arbitration_Start_Date__c = ScheduleofLosses[0].Final_Offers_Start_Date__c +  integer.valueof(ScheduleofLosses[0].Final_Offers_Duration__c)+1;   
              }         
       }     
  }
  
  Update ScheduleofLosses;
  
   
  //if(ScheduleofLosses[0].Defendant_Accept_Decline__c==true && ScheduleofLosses[0].Claimant_Accept_Decline__c==true){

  if(ScheduleofLosses[0].Defendant_Arbitration_Submitted__c==true && ScheduleofLosses[0].Claimaint_Arbitration_Submitted__c==true){
          
         
        LossSubCategories = [SELECT Id,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where Loss_Category__r.Schedule_of_Losses__c =:  ShedId AND Arbitration_Accepted_Status__c=:'Accepted' AND Status__c='Referred to Arbitration' AND Arbitrated_by__c=:null];
       
       system.debug('***ARB DOC PREP***'+LossSubCategories); 
       for(Loss_Sub_Categories__c  item:LossSubCategories){
          
          item.Status__c ='Arbitration Doc Prep';
      } 
     update LossSubCategories;
   
      lstMerit = new List<Merit__c>([Select id,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Schedule_of_Losses__c =:  ShedId AND Status__c='Referred to Arbitration' AND Arbitrated_by__c=:null AND Arbitration_Accepted_Status__c=:'Accepted']);
    
      for(Merit__c merit:lstMerit){
           
          merit.Status__c ='Arbitration Doc Prep';
      
      }
      
      update lstMerit; 
   
  } 
 system.debug('***AllItemsResponded***'+AllItemsResponded);
 
   if(AllItemsResponded==false){ 
   generateLossitemList(CurrentCase.id);
  
   DetermineStage();
   CaseFilesSelectedlist = GeneralSelectedFiles();
   lstFileCategory= SelectAllCaseFiles();
  }
}


Public void AcceptArbitration(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
    Loss_Sub_Categories__c[]  LossSubCategories  = [SELECT Id,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where id =:  RecId];
     
   for(ScheduleofLoss sched:lstScheduleofLoss){
    
            for(LossCategory cat:sched.lstLossCategory){
             
                   for(LossItem item:cat.lstLossItems){
                    
                        if(RecId == item.RecId){
                            
                            item.ArbitrationAcceptedStatus = 'Accepted';
                            LossSubCategories[0].Arbitration_Accepted_Status__c= 'Accepted';
                            item.StageReject=True;
                            item.StageAccept=False;  
                           
                            if(item.Status =='Negotiating' || sched.Claimaint_Arbitration_Submitted==false ||  sched.Defendant_Arbitration_Submitted==false){
                                if(ShowConfirmDocument){
                                    LossSubCategories[0].Status__c ='Arbitration Doc Prep';
                                    item.Status ='Arbitration Doc Prep'; 
                                }
                                else{
                                    LossSubCategories[0].Status__c ='Referred to Arbitration';
                                    item.Status ='Referred to Arbitration';
                                }                               
                            }
                            else if(ShowConfirmDocument){
                                    LossSubCategories[0].Status__c ='Arbitration Doc Prep';
                                    item.Status ='Arbitration Doc Prep'; 
                            }                               
                              
                        }
            }
    }
  }
 system.debug('**Claimant***'+Claimant); 
        
 update LossSubCategories;  
 generateLossitemList(CurrentCase.id);
}


Public void DeclineArbitration(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
    Loss_Sub_Categories__c[]  LossSubCategories  = [SELECT Id,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where id =:  RecId];
     
    for(ScheduleofLoss sched:lstScheduleofLoss){
    
            for(LossCategory cat:sched.lstLossCategory){
             
                   for(LossItem item:cat.lstLossItems){
                    
                        if(RecId == item.RecId){
                            
                            item.ArbitrationAcceptedStatus = 'Declined';
                            LossSubCategories[0].Arbitration_Accepted_Status__c= 'Declined';
                            LossSubCategories[0].Status__c ='Negotiating';
                            item.Status ='Negotiating';
                            
                            item.StageReject=False;
                            item.StageAccept=True;                                 
                              
                        }
            }
    }
  }
  
        
 update LossSubCategories;  
 generateLossitemList(CurrentCase.id);
}

Public void DocumentRefresh(){
        generateLossitemList(CurrentCase.id);
        DetermineStage();
        //populateCaseFiles();
        
        //   CaseFilesSelectedlist = populateCaseFiles('Selected','');
        //   CaseFileslist = populateCaseFiles('All','');
        
        
        CaseFilesSelectedlist = GeneralSelectedFiles();
        lstFileCategory= SelectAllCaseFiles();
}

Public void ConfirmDocumentUpload(){

   Loss_Sub_Categories__c[]  LossSubCategories; 
   List<Merit__c> lstMerit;
   
   String ShedId = apexpages.currentpage().getparameters().get('ShedId');
   Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Final_Offers_Start_Date__c,Claimant_Confirm_Documents_Uploaded__c,Name,Case__c,Defendant_Confirm_Documents_uploaded__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c Where id =: ShedId];
   
   Boolean LoggedUser=false;
   if(LOGGEDINUSER == 'Claimant Handler' || LOGGEDINUSER == 'Defendant Handler'){
       LoggedUser=true;
   }
   
   AllItemsResponded=false;
    
   Integer TotalItems=0,TotalDeclined=0; 
      
   for(ScheduleofLoss sched:lstScheduleofLoss){
        
        /*
        if(LOGGEDINUSER == 'Claimant Handler'){
              sched.Claimant_Confirm_Documents=true; 
              ScheduleofLosses[0].Claimant_Confirm_Documents_Uploaded__c=true;  
        }    
        else if(LOGGEDINUSER == 'Defendant Handler'){
               sched.Defendant_Confirm_Documents=true; 
               ScheduleofLosses[0].Defendant_Confirm_Documents_uploaded__c=true;  
        } 
        */
        if(LOGGEDINUSER == 'Claimant Handler'){
                    if(sched.lstLossCategory != null){
                            for(LossCategory cat:sched.lstLossCategory){                     
                                       for(LossItem item:cat.lstLossItems){
                                           if(item.ArbitrationReferredBy=='Defendant Handler' && item.ArbitrationAcceptedStatus ==null){
                                              system.debug('**Confirm1**');
                                              AllItemsResponded=true; 
                                           }
                                       }
                            }
                    }  
                    if(sched.lstMeritSched != null){   
                        for(Merit merit:sched.lstMeritSched){                                
                                   if(merit.ArbitrationReferredBy=='Defendant Handler' && merit.ArbitrationAcceptedStatus ==null){
                                          system.debug('**Confirm2**');
                                          AllItemsResponded=true; 
                                   }                                                                    
                        }
                    }    
                        system.debug('**Confirm3**'+AllItemsResponded);
                        if(AllItemsResponded==false){          
                            sched.Claimant_Confirm_Documents=true; 
                            ScheduleofLosses[0].Claimant_Confirm_Documents_Uploaded__c=true;  
                        }
                            
            }
            else if(LOGGEDINUSER == 'Defendant Handler'){
                      if(sched.lstLossCategory != null){
                          for(LossCategory cat:sched.lstLossCategory){
                                 
                                       for(LossItem item:cat.lstLossItems){
                                           if(item.ArbitrationReferredBy=='Claimant Handler' && item.ArbitrationAcceptedStatus ==null){
                                              AllItemsResponded=true; 
                                           }
                                       }
                            }
                        }
                     if(sched.lstMeritSched != null){         
                        for(Merit merit:sched.lstMeritSched){                                
                                   if(merit.ArbitrationReferredBy=='Claimant Handler' && merit.ArbitrationAcceptedStatus ==null){
                                          AllItemsResponded=true; 
                                   }                                                                    
                        }
                     }   
                        system.debug('**Confirm3**'+AllItemsResponded);
                        if(AllItemsResponded==false){                      
                            sched.Defendant_Confirm_Documents=true; 
                            ScheduleofLosses[0].Defendant_Confirm_Documents_uploaded__c=true;
                        }    
            }
        //Check if all declined  
           if(sched.lstLossCategory != null){
               for(LossCategory cat:sched.lstLossCategory){                     
                          for(LossItem item:cat.lstLossItems){
                              TotalItems++;
                               if(item.ArbitrationAcceptedStatus =='Declined'){
                                 TotalDeclined++;            
                               }
                          }
               }
           }
           if(sched.lstMeritSched != null){     
               for(Merit merit:sched.lstMeritSched){ 
                     TotalItems++;                                 
                     if(merit.ArbitrationAcceptedStatus =='Declined'){
                          TotalDeclined++;  
                     }                                                                    
               }   
           }
           if(TotalItems==TotalDeclined){
               ScheduleofLosses[0].Defendant_Arbitration_Submitted__c=false; 
               ScheduleofLosses[0].Claimaint_Arbitration_Submitted__c=false;
               ScheduleofLosses[0].Defendant_Confirm_Documents_uploaded__c=false;
               ScheduleofLosses[0].Claimant_Confirm_Documents_Uploaded__c=false;
               
               LossSubCategories = [SELECT Id,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where Loss_Category__r.Schedule_of_Losses__c =:  ShedId AND Status__c!='Arbitrated' AND Status__c!='Settled' AND Arbitrated_by__c=:null];
               for(Loss_Sub_Categories__c  item:LossSubCategories){
                  item.Refer_to_Arbitration__c = false;
                  item.Arbitration_Accepted_Status__c='';
                  item.Arbitration_Referred_By__c='';
               }
               update LossSubCategories; 
               
               lstMerit = new List<Merit__c>([Select id,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Schedule_of_Losses__c =:  ShedId AND Status__c !='Arbitrated' AND Status__c !='Settled'  AND Arbitrated_by__c=:null]);
    
                  for(Merit__c merit:lstMerit){           
                          merit.Arbitration_Referred_By__c =''; 
                          merit.Arbitration_Accepted_Status__c='';     
                  }
      
                  update lstMerit; 

                Update ScheduleofLosses;
           }            
             
   }  

  //  Update ScheduleofLosses;
     system.debug('***CurrentCase***'+CurrentCase);
  
    
   
  if(ScheduleofLosses[0].Claimant_Confirm_Documents_Uploaded__c==true && ScheduleofLosses[0].Defendant_Confirm_Documents_uploaded__c==true){
            
        LossSubCategories = [SELECT Id,Refer_to_Arbitration__c,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where Loss_Category__r.Schedule_of_Losses__c =:  ShedId AND  Status__c='Arbitration Doc Prep' AND Arbitrated_by__c=:null]; //Arbitration_Accepted_Status__c=:'Accepted' AND
       for(Loss_Sub_Categories__c  item:LossSubCategories){
  
          item.Status__c ='Arbitration Final Offers';
          
          
      } 
   update LossSubCategories;
   
   lstMerit = new List<Merit__c>([Select id,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Schedule_of_Losses__c =:  ShedId AND Status__c='Arbitration Doc Prep' AND Arbitrated_by__c=:null]);
    
      for(Merit__c merit:lstMerit){
           
          merit.Status__c ='Arbitration Final Offers';
      
      }
      
      ScheduleofLosses[0].Final_Offers_Start_Date__c=system.today();
      update lstMerit;
       
  }  
  
  Update ScheduleofLosses;
      generateLossitemList(CurrentCase.id);
      DetermineStage();

}

/*
Public void ConfirmFinalOffers(){

   String ShedId = apexpages.currentpage().getparameters().get('ShedId');
   Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Arbitration_Start_Date__c,Name,Case__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c Where id =: ShedId];
              
   for(ScheduleofLoss sched:lstScheduleofLoss){
        if(LOGGEDINUSER == 'Claimant Handler'){
              sched.Claimant_Confirm_Documents=true; 
              ScheduleofLosses[0].Claimant_Confirm_Documents_Uploaded__c=true;  
        }    
        else if(LOGGEDINUSER == 'Defendant Handler'){
               sched.Defendant_Confirm_Documents=true; 
               ScheduleofLosses[0].Defendant_Confirm_Documents_uploaded__c=true;  
        }      
   }  

    
    
    
    
    Loss_Sub_Categories__c[]  LossSubCategories;
   
  if(ScheduleofLosses[0].Claimant_Confirm_Documents_Uploaded__c==true && ScheduleofLosses[0].Defendant_Confirm_Documents_uploaded__c==true){
          system.debug('***ARBITRATING***');
            
        LossSubCategories = [SELECT Id,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where Loss_Category__r.Schedule_of_Losses__c =:  ShedId  AND Status__c='Arbitration Final Offers' AND Arbitrated_by__c=:null]; //AND Arbitration_Accepted_Status__c=:'Accepted'
       for(Loss_Sub_Categories__c  item:LossSubCategories){
  
          item.Status__c ='Arbitrating';
      } 
      
      List<Merit__c> lstMerit = new List<Merit__c>([Select id,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Schedule_of_Losses__c =:  ShedId AND Status__c='Arbitration Final Offers' AND Arbitrated_by__c=:null]);
    
      for(Merit__c merit:lstMerit){
            
          merit.Status__c ='Arbitrating';
      
      }
      
      ScheduleofLosses[0].Arbitration_Start_Date__c=system.today();
      update lstMerit; 
   
  } 
  Update ScheduleofLosses; 
  update LossSubCategories;
    
    
    
    generateLossitemList(CurrentCase.id);
  
    DetermineStage();

}
*/


Public void ShowSubmitAward(){

   String ShedId = apexpages.currentpage().getparameters().get('ShedId');
   Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Arbitration_Start_Date__c,Name,Case__c,Claimant_Final_Offer_Confirmed__c,Defendant_Final_Offer_Confirmed__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c Where id =: ShedId];
              
   for(ScheduleofLoss sched:lstScheduleofLoss){
        if(LOGGEDINUSER == 'Claimant Handler'){
              sched.Claimant_Final_Offer=true; 
              ScheduleofLosses[0].Claimant_Final_Offer_Confirmed__c=true;  
        }    
        else if(LOGGEDINUSER == 'Defendant Handler'){
               sched.Defendant_Final_Offer=true; 
               ScheduleofLosses[0].Defendant_Final_Offer_Confirmed__c=true;  
        }      
   }  

    
   system.debug('***CurrentCase***'+CurrentCase);
   
   
   
   
  if(ScheduleofLosses[0].Defendant_Final_Offer_Confirmed__c==true && ScheduleofLosses[0].Claimant_Final_Offer_Confirmed__c==true){
            
       Loss_Sub_Categories__c[] LossSubCategories = [SELECT Id,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where Loss_Category__r.Schedule_of_Losses__c =:  ShedId  AND Status__c='Arbitration Final Offers' AND Arbitrated_by__c=:null]; //AND Arbitration_Accepted_Status__c=:'Accepted'
       for(Loss_Sub_Categories__c  item:LossSubCategories){
  
          item.Status__c ='Arbitrating';
      } 
    update LossSubCategories;
    
       List<Merit__c> lstMerit = new List<Merit__c>([Select id,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Schedule_of_Losses__c =:  ShedId AND Status__c='Arbitration Final Offers' AND Arbitrated_by__c=:null]);
    
      for(Merit__c merit:lstMerit){
            
          merit.Status__c ='Arbitrating';
      
      }
      ScheduleofLosses[0].Arbitration_Start_Date__c=system.today();
      update lstMerit;  
    
    
  }  
 Update ScheduleofLosses;
   
   
   generateLossitemList(CurrentCase.id);
  
  DetermineStage();

}
  
  
  
Public void ShowArbitratorsAward(){

   String ShedId = apexpages.currentpage().getparameters().get('ShedId');
   Schedule_of_Losses__c[] ScheduleofLosses = [Select id,Name,Case__c,Defendant_Final_Offer_Confirmed__c,Claimant_Final_Offer_Confirmed__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c Where id =: ShedId];
   
   Boolean ArbitrationFail=false;
   for(ScheduleofLoss sched:lstScheduleofLoss){
        if(sched.lstLossCategory != null){ 
         for(LossCategory cat:sched.lstLossCategory){
             if(cat.lstLossItems != null){ 
                   for(LossItem item:cat.lstLossItems){
                    
                        if(item.Status =='Arbitrating' && item.ArbitratedBy==null && (item.ArbitratorsPosition == null || item.ArbitratorsPosition <0)){                                                             
                              ArbitrationFail=true;
                               
                        }
                }
             }   
          } 
         }
         if(sched.lstMeritSched != null){ 
          for(Merit merit:sched.lstMeritSched){                                
                   if(merit.Status =='Arbitrating' && (merit.ArbitratorsPosition == null || merit.ArbitratorsPosition <0)){
                                   ArbitrationFail=true; 
                                  
                   }                                                                    
          }  
         }    
    }
   
   
   
  if(ArbitrationFail==false){
              
               for(ScheduleofLoss sched:lstScheduleofLoss){       
                   sched.Arbitrators_Award=true; 
                   ScheduleofLosses[0].Arbitrators_Award_Finalised__c=true;  
               }  
            
            
              if(ScheduleofLosses[0].Defendant_Final_Offer_Confirmed__c==true && ScheduleofLosses[0].Claimant_Final_Offer_Confirmed__c==true){
                        
                   Loss_Sub_Categories__c[] LossSubCategories = [SELECT Id,Arbitration_Date__c,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c where Loss_Category__r.Schedule_of_Losses__c =:  ShedId  AND Status__c='Arbitrating' AND Arbitrated_by__c=:null]; //AND Arbitration_Accepted_Status__c=:'Accepted'
                   for(Loss_Sub_Categories__c  item:LossSubCategories){
                      item.Arbitrated_by__c = UserInfo.getUserId();   
                      item.Status__c ='Arbitrated';
                      item.Arbitration_Date__c = system.today();
                   } 
                  update LossSubCategories;
                  
                  List<Merit__c> lstMerit = new List<Merit__c>([Select id,Arbitration_Date__c,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Schedule_of_Losses__c =:  ShedId AND Status__c='Arbitrating' AND Arbitrated_by__c=:null]);
                
                  for(Merit__c merit:lstMerit){
                      merit.Arbitrated_by__c = UserInfo.getUserId();   
                      merit.Status__c ='Arbitrated';
                      merit.Arbitration_Date__c = system.today();
                  
                  }
                  
                  update lstMerit;
                  
              }  
            
            
              // Case[] CaseDoc = [Select Generate_Arbitration_Document__c from Case Where id=:ScheduleofLosses[0].Case__c];
               //CaseDoc[0].Generate_Arbitration_Document__c = true;
               //Update CaseDoc;
                
                Update ScheduleofLosses;
               system.debug('***CurrentCase***'+CurrentCase);
               generateLossitemList(CurrentCase.id);
              
              DetermineStage();
              
              ghostscriptAPI.generateInterimAwardonclose(CurrentCase.id);
              
             // CaseNotificationHandler.NotifyTeamMembersRegistration(CurrentCase.Claimant_Firm_Team__c,'Claimant',CurrentCase.Id,'ArbitratorSubmits' );
             // CaseNotificationHandler.NotifyTeamMembersRegistration(CurrentCase.Defendant_Firm_Team__c,'Defendent',CurrentCase.Id,'ArbitratorSubmits' ); 
    }
}           
  
 Public CaseFiles AwardFile {get;set;}
Public Boolean DisplayAwardDoc {get;set;}
Public Boolean RefreshAwardDoc {get;set;}

Public void displayArbitrationAwardDoc(){

    
    if(GenerateArbDocAPI()=='OK'){
           showAwardDocument();
           DisplayAwardDoc = true;  
           RefreshAwardDoc = false;  
    }
    else{
        DisplayAwardDoc = false;
        //Display Error;
    
    }
}

Public string GenerateArbDocAPI(){
    return ghostscriptAPI.awardgeneratedoc(CurrentCase.id,'INTERIM');

}


Public void showAwardDocument(){
     system.debug('**OK-IN**'); 
        ContentDocumentLink[] DocumentLink = [SELECT LinkedEntityId,ContentDocumentId FROM ContentDocumentLink where LinkedEntityId =:CurrentCase.id  ];
         
         Set<String> set_docId = new Set<String>();
         for(ContentDocumentLink doc:DocumentLink){
             set_docId.add(doc.ContentDocumentId);    
         }
          
         Date todayDate= system.today();     
         ContentVersion[] Content = [SELECT Case_Id__c,Document_Source__c,ContentDocumentId,Submitted_for_Arbitration_By__c,FileType,INAP_Doc_Type__c,Loss_Item_ID__c,Sharing_Permissions__c,Title FROM ContentVersion where ContentDocumentId in:set_docId AND Title like 'ArbIn%' AND createdbyId =:UserInfo.getUserId() AND createddate>=:  todayDate];
            
         system.debug('**Content**'+Content+'**Set**'+set_docId+'**Case**'+CurrentCase.id);   
         for(ContentVersion con:Content){
              AwardFile = new CaseFiles();           
              AwardFile.DocumentId = con.ContentDocumentId;    
              AwardFile.DocumentType  = con.INAP_Doc_Type__c;
              AwardFile.DocumentName = con.Title;
              AwardFile.DocumentLink ='https://inap5-k3.cs108.force.com/' +con.ContentDocumentId; 
             
         }


}
 
      


   
//----------------------MERITS

Public void UpdateMerit(){
    
    DisplayMsg ='';
    String RecId = apexpages.currentpage().getparameters().get('RecId');
    String MerPerc = apexpages.currentpage().getparameters().get('MerPerc');
    
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
                      else if(LOGGEDINUSER == 'Arbitrator'){
                          lstMerit[0].Arbitrator_Award__c = merit.ArbitratorsPosition = decimal.valueof(MerPerc);
                          system.Debug('**ARBMERIT**'+lstMerit[0].Arbitrator_Award__c);
                      }  
                      
                      
                      if(merit.DefendantPosition == merit.ClaimantPosition){
                          lstMerit[0].Arbitration_Referred_By__c = null; 
                          lstMerit[0].Arbitration_Accepted_Status__c   ='';
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
    system.debug('**Claimant-Before**'+Claimant);
    showUserRights(StartRecId);
    system.debug('**Claimant-After**'+Claimant);
   } 
    
    
}

Public void ReferMerit(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
    
    List<Merit__c> lstMerit = new List<Merit__c>([Select id,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where id =:RecId]);
     
     system.Debug('**lstScheduleofLoss**'+lstScheduleofLoss);
     for(ScheduleofLoss sched:lstScheduleofLoss){     
         for(Merit merit:sched.lstMeritSched){   
         
                  system.Debug('**RecId**'+RecId+'**lstMerit**'+lstMerit+'*****'+LOGGEDINUSER);         
                  lstMerit[0].Status__c = 'Referred to Arbitration';
                  lstMerit[0].Arbitration_Referred_By__c = LOGGEDINUSER; 
                   merit.Status = 'Referred to Arbitration'; 
                  merit.ArbitrationReferredBy=   LOGGEDINUSER;  
                   merit.StageCancelSubmit = true;
                  merit.StageSubmit  = false;                                          
             if(Sched.BILATERALREFER==true){
                                merit.ArbitrationAcceptedStatus = 'Accepted';
                                lstMerit[0].Arbitration_Accepted_Status__c ='Accepted';                                 
                                merit.Status =  'Arbitration Doc Prep'; 
                                lstMerit[0].Status__c = 'Arbitration Doc Prep';                               
                                merit.StageReject=false;
                                merit.StageAccept=False;
            } 
        
         }
         
     }  
    
    
    
    update lstMerit;
   // generateLossitemList(StartRecId);
     
}
Public void CancelReferMerit(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
    
    List<Merit__c> lstMerit = new List<Merit__c>([Select id,Arbitration_Accepted_Status__c,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where id =:RecId]);
     
     
     system.Debug('**lstScheduleofLoss**'+lstScheduleofLoss);
     
     for(ScheduleofLoss sched:lstScheduleofLoss){     
         for(Merit merit:sched.lstMeritSched){  
                 
                 system.Debug('**RecId**'+RecId+'**lstMerit**'+lstMerit+'*****'+LOGGEDINUSER);          
                  lstMerit[0].Status__c = 'Negotiating';
                  lstMerit[0].Arbitration_Referred_By__c = null; 
                  merit.Status = 'Negotiating';  
                  merit.ArbitrationReferredBy=   '';     
                  merit.StageCancelSubmit = false;
                  merit.StageSubmit  = true; 
                  merit.ArbitrationAcceptedStatus = ''; 
                  lstMerit[0].Arbitration_Accepted_Status__c   ='';                                
         }
     }  
    
    
    update lstMerit;
   // generateLossitemList(StartRecId);
     
}
Public void DeclineMeritArbitration(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
    
    List<Merit__c> lstMerit = new List<Merit__c>([Select id,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where id =:RecId]);
     
     system.Debug('**lstScheduleofLoss**'+lstScheduleofLoss);
     for(ScheduleofLoss sched:lstScheduleofLoss){     
         for(Merit merit:sched.lstMeritSched){   
         
                            merit.ArbitrationAcceptedStatus = 'Declined';
                            lstMerit[0].Arbitration_Accepted_Status__c= 'Declined';
                            lstMerit[0].Status__c = 'Negotiating';
                            merit.Status = 'Negotiating';
                            merit.StageReject=True;
                            merit.StageAccept=False;                                            
         }
     }  
    
    
    
    update lstMerit;
    generateLossitemList(StartRecId);
     
}
Public void AcceptMeritArbitration(){

    String RecId = apexpages.currentpage().getparameters().get('RecId');
    
    List<Merit__c> lstMerit = new List<Merit__c>([Select id,Arbitration_Referred_By__c,Defendant_Position__c,Status__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where id =:RecId]);
     
     system.Debug('**lstScheduleofLoss**'+lstScheduleofLoss);
     for(ScheduleofLoss sched:lstScheduleofLoss){     
         for(Merit merit:sched.lstMeritSched){   
         
                            merit.ArbitrationAcceptedStatus = 'Accepted';
                            lstMerit[0].Arbitration_Accepted_Status__c= 'Accepted';
                        if(sched.Claimaint_Arbitration_Submitted==false ||  sched.Defendant_Arbitration_Submitted==false){    
                            lstMerit[0].Status__c = 'Referred to Arbitration';
                            merit.Status = 'Referred to Arbitration';
                        }
                        else{
                            lstMerit[0].Status__c = 'Arbitration Doc Prep';
                            merit.Status = 'Arbitration Doc Prep';
                        }    
                            merit.StageReject=True;
                            merit.StageAccept=False;                                        
         }
     }  
 
    update lstMerit;
    generateLossitemList(StartRecId);
     
}
//Files

Public List<CaseFiles> CaseFileslist {get;set;}
Public List<CaseFiles> CaseFilesSelectedlist {get;set;}
Public List<FileCategory> lstFileCategory {get;set;}  
/*
Public List<CaseFiles> populateCaseFiles(String FileType,String LossFileId){
      
     List<CaseFiles> tmpCaseFileslist= new List<CaseFiles>();
     Loss_Category_Files__c[] Loss_CategoryFiles;
     if(LossFileId==''){
         Loss_CategoryFiles = [Select id,File_Url__c,Past_Future_Financial_Item__c,Loss_Sub_Category__r.Loss_Type__c From Loss_Category_Files__c where  CaseId__c=:CurrentCase.id AND (Loss_Sub_Category__r.status__c= 'Arbitration Doc Prep' OR Loss_Sub_Category__r.status__c= 'Arbitration Final Offers' OR Loss_Sub_Category__r.status__c= 'Arbitrating')];        
     }
     else{    
         Loss_CategoryFiles = [Select id,File_Url__c,Past_Future_Financial_Item__c,Loss_Sub_Category__r.Loss_Type__c From Loss_Category_Files__c where  CaseId__c=:CurrentCase.id and id =: LossFileId];
     }
         
    // List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,  Claimant_Final_Offer_Confirmed__c,Defendant_Final_Offer_Confirmed__c,Claimant_Confirm_Documents_Uploaded__c, Defendant_Confirm_Documents_uploaded__c,Name,Case__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c Where Case__c =: CurrentCase.id]);        
    // List<Loss_Category__c>     LossCategory = new List<Loss_Category__c>([SELECT id,Schedule_of_Losses__c  FROM Loss_Category__c where Case__c =:CurrentCase.id]);
        
     
     Map<String,String> Map_files = new Map<String,String>();
     
     for(Loss_Category_Files__c f:Loss_CategoryFiles){     
        
        if(Map_files.get(String.Valueof(f.File_Url__c).right(18))==null){
             system.debug('**Map_files-Loss Item**'+f.Past_Future_Financial_Item__c+'******'+f.File_Url__c);
             
             Map_files.put(String.Valueof(f.File_Url__c).right(18),f.Past_Future_Financial_Item__c);
        }
        else{
             Map_files.put(String.Valueof(f.File_Url__c).right(18), Map_files.get(String.Valueof(f.File_Url__c).right(18))+', '+f.Past_Future_Financial_Item__c );  
            
        } 
         
     }
     
     system.debug('**Map_files**'+Map_files);
     
     ContentDocumentLink[] DocumentLink = [SELECT LinkedEntityId,ContentDocumentId FROM ContentDocumentLink where LinkedEntityId =:CurrentCase.id  ];
     
     Set<String> set_docId = new Set<String>();
     for(ContentDocumentLink doc:DocumentLink){
         set_docId.add(doc.ContentDocumentId);    
     }
          
     ContentVersion[] Content = [SELECT Case_Id__c,Document_Source__c,ContentDocumentId,Submitted_for_Arbitration_By__c,FileType,INAP_Doc_Type__c,Loss_Item_ID__c,Sharing_Permissions__c,Title FROM ContentVersion where ContentDocumentId in:set_docId AND  Ghost_Draft_Doc__c =:false AND Sharing_Permissions__c !='Private'];
        
     system.debug('**Content**'+Content.size()+'**Set**'+set_docId+'**Case**'+CurrentCase.id);   
     Boolean Addtolist;
     for(ContentVersion con:Content){
          CaseFiles CaseFile = new CaseFiles();
       Addtolist = true;
       if(Map_files.get(con.ContentDocumentId)!=null && FileType == 'Selected'){
           Addtolist = false;       
       }
       if((Map_files.get(con.ContentDocumentId)==null && FileType == 'Loss') || (FileType == 'Loss' && con.Submitted_for_Arbitration_By__c==null)){
           Addtolist = false;       
       }
       
       if(Addtolist==true){   
          if(con.Submitted_for_Arbitration_By__c=='Claimant'){
              CaseFile.ClaimantSelect = true;
              CaseFile.ReferedBy='Claimant';
          }
          else if(con.Submitted_for_Arbitration_By__c=='Defendant'){
              CaseFile.DefendantSelect = true;
              CaseFile.ReferedBy='Defendant';
          }
          CaseFile.LossItem =  Map_files.get(con.ContentDocumentId);
          CaseFile.DocumentId = con.ContentDocumentId;    
          CaseFile.DocumentType  = con.INAP_Doc_Type__c;
          CaseFile.DocumentName = con.Title;
          CaseFile.DocumentLink ='/' +con.ContentDocumentId;
          tmpCaseFileslist.Add(CaseFile); 
       }       
     }
     system.debug('**CaseFileslist**'+tmpCaseFileslist);  
     
     return tmpCaseFileslist; 
}

Public Map<String,List<CaseFiles>> populateLossCaseFiles(){
      
     List<CaseFiles> tmpCaseFileslist= new List<CaseFiles>();
     Loss_Category_Files__c[] Loss_CategoryFiles;
    
     Loss_CategoryFiles = [Select id,Loss_Sub_Category__c,File_Url__c,Loss_Sub_Category__r.Loss_Category__c,Loss_Sub_Category__r.Loss_Type__c From Loss_Category_Files__c where  CaseId__c=:CurrentCase.id AND (Loss_Sub_Category__r.status__c= 'Arbitration Doc Prep' OR Loss_Sub_Category__r.status__c= 'Arbitration Final Offers' OR Loss_Sub_Category__r.status__c= 'Arbitrating') ORDER BY Loss_Sub_Category__r.Loss_Category__c ];        
     
         
    // List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,  Claimant_Final_Offer_Confirmed__c,Defendant_Final_Offer_Confirmed__c,Claimant_Confirm_Documents_Uploaded__c, Defendant_Confirm_Documents_uploaded__c,Name,Case__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c Where Case__c =: CurrentCase.id]);        
    // List<Loss_Category__c>     LossCategory = new List<Loss_Category__c>([SELECT id,Schedule_of_Losses__c  FROM Loss_Category__c where Case__c =:CurrentCase.id]);
        
     ContentDocumentLink[] DocumentLink = [SELECT LinkedEntityId,ContentDocumentId FROM ContentDocumentLink where LinkedEntityId =:CurrentCase.id  ];
     
     
     Map<String,String> Map_files = new Map<String,String>();
     
   
     
     system.debug('**Files**'+CurrentCase.id);
     
     
     Set<String> set_docId = new Set<String>();
     for(ContentDocumentLink doc:DocumentLink){
         set_docId.add(doc.ContentDocumentId);    
     }
          
     ContentVersion[] Content = [SELECT Case_Id__c,Document_Source__c,ContentDocumentId,Submitted_for_Arbitration_By__c,FileType,INAP_Doc_Type__c,Loss_Item_ID__c,Sharing_Permissions__c,Title FROM ContentVersion where ContentDocumentId in:set_docId AND  Ghost_Draft_Doc__c =:false AND Sharing_Permissions__c !='Private'];
        
        
     Boolean Addtolist;

    String HeadOfLoss;  
    Map<String,List<CaseFiles>> Map_LossFile = new Map<String,List<CaseFiles>>();
    Set<String> Set_lossId = new Set<String>();
   
    for(Loss_Category_Files__c f:Loss_CategoryFiles){
    
        if(HeadOfLoss != f.Loss_Sub_Category__r.Loss_Category__c){
            
            tmpCaseFileslist= new List<CaseFiles>(); 
            Set_lossId = new Set<String>();  
        }
        HeadOfLoss = f.Loss_Sub_Category__r.Loss_Category__c; 
        if(HeadOfLoss == null || HeadOfLoss == f.Loss_Sub_Category__r.Loss_Category__c){ 
                 
             for(ContentVersion con:Content){
                  
              
              
                 if(!Set_lossId.contains(con.id) && String.Valueof(f.File_Url__c).right(18) == con.ContentDocumentId && con.Submitted_for_Arbitration_By__c!= null){
                       
                       CaseFiles CaseFile = new CaseFiles();
                 
                          if(con.Submitted_for_Arbitration_By__c=='Claimant'){
                              CaseFile.ClaimantSelect = true;
                              CaseFile.ReferedBy='Claimant';
                          }
                          else if(con.Submitted_for_Arbitration_By__c=='Defendant'){
                              CaseFile.DefendantSelect = true;
                              CaseFile.ReferedBy='Defendant';
                          }
                          CaseFile.LossItem =f.Loss_Sub_Category__r.Loss_Type__c; //  Map_files.get(con.ContentDocumentId);
                          CaseFile.DocumentId = con.ContentDocumentId;    
                          CaseFile.DocumentType  = con.INAP_Doc_Type__c;
                          CaseFile.DocumentName = con.Title;
                          CaseFile.DocumentLink ='/' +con.ContentDocumentId;
                          tmpCaseFileslist.Add(CaseFile); 
                          Set_lossId.Add(con.id);
                    
                 }
            } 
            Map_LossFile.put(HeadOfLoss,tmpCaseFileslist);
      }
      
    }            
     system.debug('**CaseFileslist**'+tmpCaseFileslist);  
     
     return Map_LossFile; 
}


Public void SaveCaseFilesSelection(){
    
    
    Set<String> set_docId = new Set<String>();
    
    Map<String,Boolean> Map_claimant = new Map<String,Boolean>();
    Map<String,Boolean> Map_Defendant = new Map<String,Boolean>();
    
    for(CaseFiles doc:CaseFileslist){
         set_docId.add(doc.DocumentId); 
         Map_Defendant.put(doc.DocumentId,doc.DefendantSelect);  
         Map_claimant.put(doc.DocumentId,doc.ClaimantSelect);  
    }
    
    ContentVersion[] Content = [SELECT Case_Id__c,ContentDocumentId,Document_Source__c,Submitted_for_Arbitration_By__c,FileType,INAP_Doc_Type__c,Loss_Item_ID__c,Sharing_Permissions__c,Title FROM ContentVersion where ContentDocumentId in:set_docId AND Sharing_Permissions__c !='Private' AND  Ghost_Draft_Doc__c =:false];
     
   
    for(ContentVersion con:Content){
        
    
          if(Map_claimant.get(con.ContentDocumentId) != null && Map_claimant.get(con.ContentDocumentId)){
              con.Submitted_for_Arbitration_By__c='Claimant'; 
                          
          }
          else if(Map_Defendant.get(con.ContentDocumentId) != null && Map_Defendant.get(con.ContentDocumentId)){
              con.Submitted_for_Arbitration_By__c='Defendant';
             
          }
          else{
              con.Submitted_for_Arbitration_By__c='';
          } 
    }
    
   update Content; 
    system.debug('**MAP***'+ Map_claimant+'**ContentX**'+Content);
   // generateLossitemList(StartRecId);
   CaseFilesSelectedlist = populateCaseFiles('Selected','');
   CaseFileslist = populateCaseFiles('All','');
   generateLossitemList(StartRecId);
}
*/

//-------------------------File Link

Public List<FileCategory> SelectAllCaseFiles(){
      
     List<CaseFiles> tmpCaseFileslist= new List<CaseFiles>();
     Loss_Category_Files__c[] Loss_CategoryFiles;
     
      
     
     Loss_CategoryFiles = [Select id,File_Name__c,Submitted_for_Arbitration_By__c,Linked_by__c ,Loss_Sub_Category__c,Document_Type__c,File_Url__c,Loss_Sub_Category__r.Loss_Category__c,Loss_Sub_Category__r.Loss_Type__c From Loss_Category_Files__c where  CaseId__c=:CurrentCase.id AND  Document_Sharing_Permissions__c !='Private' AND (Loss_Sub_Category__r.status__c= 'Arbitration Doc Prep' OR Loss_Sub_Category__r.status__c= 'Arbitration Final Offers' OR Loss_Sub_Category__r.status__c= 'Arbitrating') ORDER BY Loss_Sub_Category__r.Loss_Category__c,File_Name__c,Loss_Sub_Category__r.Loss_Type__c ];        
     
     Set<String> Set_HeadofLoss = new Set<String>();
     
     for(Loss_Category_Files__c file:Loss_CategoryFiles){
         Set_HeadofLoss.add(file.Loss_Sub_Category__r.Loss_Category__c);
     }
     
         
     List<Loss_Category__c>     LossCategory = new List<Loss_Category__c>([SELECT id,Name,Schedule_of_Losses__c,Head_of_Loss_Type__c  FROM Loss_Category__c where Case__c =:CurrentCase.id AND id in: Set_HeadofLoss]);
        
     ContentDocumentLink[] DocumentLink = [SELECT LinkedEntityId,ContentDocumentId FROM ContentDocumentLink where LinkedEntityId =:CurrentCase.id  ];
     
     
     Map<String,String> Map_files = new Map<String,String>();
     system.debug('**Files**'+CurrentCase.id);
     
     
     Set<String> set_docId = new Set<String>();
     for(ContentDocumentLink doc:DocumentLink){
         set_docId.add(doc.ContentDocumentId);    
     }
          
     ContentVersion[] Content = [SELECT Case_Id__c,Document_Source__c,ContentDocumentId,Submitted_for_Arbitration_By__c, FileType, INAP_Doc_Type__c,Loss_Item_ID__c,Sharing_Permissions__c,Title FROM ContentVersion where ContentDocumentId in:set_docId AND  Ghost_Draft_Doc__c =:false AND Sharing_Permissions__c !='Private' ORDER BY Title];
      
      //General List
      lstFileCategory = new List<FileCategory>();
      
      FileCategory GeneralDocs = new FileCategory(); 
      GeneralDocs.CategoryName = 'General';
     tmpCaseFileslist= new List<CaseFiles>();
     
     CaseFiles CaseFile;
      
      for(ContentVersion con:Content){
                          //CaseFile.LossItem =f.Loss_Sub_Category__r.Loss_Type__c; //  Map_files.get(con.ContentDocumentId);
                          CaseFile = new CaseFiles();
                          CaseFile.DocumentId = con.ContentDocumentId;    
                          CaseFile.DocumentType  = con.INAP_Doc_Type__c;
                          CaseFile.DocumentName = con.Title;
                          CaseFile.DocumentLink ='/' +con.ContentDocumentId;
                          if(con.Submitted_for_Arbitration_By__c=='Both Parties'){
                                  CaseFile.ClaimantSelect = true;
                                  CaseFile.DefendantSelect = true;
                                  CaseFile.ReferedBy='Both Parties';
                          }  
                          
                          else if(con.Submitted_for_Arbitration_By__c=='Claimant Handler'){
                              CaseFile.ClaimantSelect = true;
                              CaseFile.ReferedBy='Claimant Handler';
                          }
                          else if(con.Submitted_for_Arbitration_By__c=='Defendant Handler'){
                              CaseFile.DefendantSelect = true;
                              CaseFile.ReferedBy='Defendant Handler';
                          }
                          tmpCaseFileslist.Add(CaseFile); 

      } 
      GeneralDocs.lstLossFiles = tmpCaseFileslist;
     
     
        
      
     Boolean Addtolist;

    String HeadOfLoss;  
     
    Set<String> Set_lossId = new Set<String>();
   
    List<CaseFilesItemSelection> lstSelection; 
     for(Loss_Category__c    head:LossCategory){    
             
                FileCategory HeadofLossFile = new FileCategory();
            
                
                HeadofLossFile.CategoryName = head.Head_of_Loss_Type__c;
            
                tmpCaseFileslist= new List<CaseFiles>(); 
            
                Set_lossId = new Set<String>();  
            
                HeadOfLoss = head.id;
             
        for(Loss_Category_Files__c f:Loss_CategoryFiles){
    
             
                
            if(HeadOfLoss == f.Loss_Sub_Category__r.Loss_Category__c){ 
                    
                
                   
                if(!Set_lossId.contains(f.File_Url__c)){
                   CaseFile = new CaseFiles(); 
                   //CaseFile.LossItem =f.Loss_Sub_Category__r.Loss_Type__c; //  Map_files.get(con.ContentDocumentId);
                   CaseFile.DocumentId = f.id;    
                   CaseFile.DocumentType  = f.Document_Type__c;
                   CaseFile.DocumentName = f.File_Name__c;
                   CaseFile.DocumentLink = f.File_Url__c;
                   
                   Set_lossId.Add(f.File_Url__c);
                   
                   tmpCaseFileslist.Add(CaseFile);  
                   lstSelection = new List<CaseFilesItemSelection>();
                   CaseFile.lstLossFiles=lstSelection;      
                }      
                       
                CaseFilesItemSelection Selection = new CaseFilesItemSelection();    
                Selection.LossItemName = f.Loss_Sub_Category__r.Loss_Type__c;
                Selection.LinkedBy = f.Linked_by__c;
                Selection.filelinkId = f.id;
                    
                if(f.Submitted_for_Arbitration_By__c=='Both Parties'){
                    Selection.ClaimantSelect = true;
                    Selection.DefendantSelect = true;
                }
                else if(f.Submitted_for_Arbitration_By__c=='Claimant Handler'){
                    Selection.ClaimantSelect = true;
                    Selection.ReferedBy='Claimant Handler';
                }
                else if(f.Submitted_for_Arbitration_By__c=='Defendant Handler'){
                              Selection.DefendantSelect = true;
                              Selection.ReferedBy='Defendant Handler';
                }
                          
                lstSelection.add(Selection);      
                          
                    
            }
             
            
        }
            HeadofLossFile.lstLossFiles = tmpCaseFileslist; 
            lstFileCategory.Add(HeadofLossFile); 
          
          
        } 
        lstFileCategory.Add(GeneralDocs);       
     
     
     return lstFileCategory; 
}

Public List<CaseFiles> GeneralSelectedFiles(){
      
     List<CaseFiles> tmpCaseFileslist= new List<CaseFiles>();
     
     
     ContentDocumentLink[] DocumentLink = [SELECT LinkedEntityId,ContentDocumentId FROM ContentDocumentLink where LinkedEntityId =:CurrentCase.id  ];
     
     Set<String> set_docId = new Set<String>();
     for(ContentDocumentLink doc:DocumentLink){
         set_docId.add(doc.ContentDocumentId);    
     }
          
     ContentVersion[] Content = [SELECT Case_Id__c,Document_Source__c,ContentDocumentId,Submitted_for_Arbitration_By__c, FileType, INAP_Doc_Type__c,Loss_Item_ID__c,Sharing_Permissions__c,Title FROM ContentVersion where ContentDocumentId in:set_docId AND  Ghost_Draft_Doc__c =:false AND Sharing_Permissions__c !='Private' ORDER BY Title];
        
      
     for(ContentVersion con:Content){
          
        
       
       if( con.Submitted_for_Arbitration_By__c!=null && con.Submitted_for_Arbitration_By__c!=''){
              CaseFiles CaseFile = new CaseFiles();
              
              if(con.Submitted_for_Arbitration_By__c=='Both Parties'){
                  CaseFile.ClaimantSelect = true;
                  CaseFile.ReferedBy='Both Parties';
              }              
              else if(con.Submitted_for_Arbitration_By__c=='Claimant Handler'){
                  CaseFile.ClaimantSelect = true;
                  CaseFile.ReferedBy='Claimant Handler';
              }
              else if(con.Submitted_for_Arbitration_By__c=='Defendant Handler'){
                  CaseFile.DefendantSelect = true;
                  CaseFile.ReferedBy='Defendant Handler';
              }
              
              CaseFile.DocumentId = con.ContentDocumentId;    
              CaseFile.DocumentType  = con.INAP_Doc_Type__c;
              CaseFile.DocumentName = con.Title;
              CaseFile.DocumentLink ='/' +con.ContentDocumentId;
              tmpCaseFileslist.Add(CaseFile); 
              
                 
                   
                   
                   
       }       
     }
     system.debug('**CaseFileslist**'+tmpCaseFileslist);  
     
     return tmpCaseFileslist; 
}


Public Map<String,List<CaseFiles>>  HeadOfLossSelectedFiles(){
      
     List<CaseFiles> tmpCaseFileslist= new List<CaseFiles>();
     Loss_Category_Files__c[] Loss_CategoryFiles;
    
     Loss_CategoryFiles = [Select id,Document_Type__c,File_Name__c,Loss_Sub_Category__c,Submitted_for_Arbitration_By__c,File_Url__c,Loss_Sub_Category__r.Loss_Category__c,Loss_Sub_Category__r.Loss_Category__r.Head_of_Loss_Type__c,Loss_Sub_Category__r.Loss_Type__c From Loss_Category_Files__c where Submitted_for_Arbitration_By__c !=: null AND  CaseId__c=:CurrentCase.id AND Document_Sharing_Permissions__c !='Private' AND (Loss_Sub_Category__r.status__c= 'Arbitration Doc Prep' OR Loss_Sub_Category__r.status__c= 'Arbitration Final Offers' OR Loss_Sub_Category__r.status__c= 'Arbitrating') ORDER BY Loss_Sub_Category__r.Loss_Category__c ];        
     
         
    // List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,  Claimant_Final_Offer_Confirmed__c,Defendant_Final_Offer_Confirmed__c,Claimant_Confirm_Documents_Uploaded__c, Defendant_Confirm_Documents_uploaded__c,Name,Case__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c Where Case__c =: CurrentCase.id]);        
    //List<Loss_Category__c>     LossCategory = new List<Loss_Category__c>([SELECT id,Schedule_of_Losses__c  FROM Loss_Category__c where Case__c =:CurrentCase.id]);
        
     ContentDocumentLink[] DocumentLink = [SELECT LinkedEntityId,ContentDocumentId FROM ContentDocumentLink where LinkedEntityId =:CurrentCase.id  ];
     
     
     Map<String,String> Map_files;
   
     
     system.debug('**Files**'+CurrentCase.id);
     
     
     Set<String> set_docId = new Set<String>();
     for(ContentDocumentLink doc:DocumentLink){
         set_docId.add(doc.ContentDocumentId);    
     }
          
     ContentVersion[] Content = [SELECT Case_Id__c,Document_Source__c,ContentDocumentId,Submitted_for_Arbitration_By__c, FileType, INAP_Doc_Type__c,Loss_Item_ID__c,Sharing_Permissions__c,Title FROM ContentVersion where ContentDocumentId in:set_docId AND  Ghost_Draft_Doc__c =:false AND Sharing_Permissions__c !='Private' ORDER BY Title];
        
        
     Boolean Addtolist;

    String HeadOfLoss;  
    Map<String,List<CaseFiles>> Map_LossFile = new Map<String,List<CaseFiles>>();
    Set<String> Set_lossId = new Set<String>();
    
     Map_files = new Map<String,String>();
     for(Loss_Category_Files__c f:Loss_CategoryFiles){
    
           HeadOfLoss = f.Loss_Sub_Category__r.Loss_Category__r.Head_of_Loss_Type__c;  
           if(Map_files.get(HeadofLoss+f.File_Name__c)==null){ 
               Map_files.put(HeadofLoss+f.File_Name__c,f.Loss_Sub_Category__r.Loss_Type__c);
           }
           else{
               Map_files.put(HeadofLoss+f.File_Name__c,Map_files.get(HeadofLoss+f.File_Name__c)+'; '+f.Loss_Sub_Category__r.Loss_Type__c);
           }  
    
    }
    
    for(Loss_Category_Files__c f:Loss_CategoryFiles){
    
        if(HeadOfLoss != f.Loss_Sub_Category__r.Loss_Category__r.Head_of_Loss_Type__c){
            
            tmpCaseFileslist= new List<CaseFiles>(); 
            Set_lossId = new Set<String>();
              
        }
        HeadOfLoss = f.Loss_Sub_Category__r.Loss_Category__r.Head_of_Loss_Type__c; 
        if((HeadOfLoss == null || HeadOfLoss == f.Loss_Sub_Category__r.Loss_Category__r.Head_of_Loss_Type__c) && !Set_lossId.contains(f.File_Url__c)){ 
                           
                 if(f.Submitted_for_Arbitration_By__c!= null){
                       
                       CaseFiles CaseFile = new CaseFiles();
                         
                          if( f.Submitted_for_Arbitration_By__c=='Both Parties'){
                             CaseFile.ClaimantSelect = true;
                             CaseFile.DefendantSelect = true;
                             CaseFile.ReferedBy='Both Parties';
                          }
                          else if(f.Submitted_for_Arbitration_By__c=='Claimant Handler'){
                              CaseFile.ClaimantSelect = true;
                              CaseFile.ReferedBy='Claimant Handler';
                          }
                          else if(f.Submitted_for_Arbitration_By__c=='Defendant Handler'){
                              CaseFile.DefendantSelect = true;
                              CaseFile.ReferedBy='Defendant Handler';
                          }
                         if(HeadOfLoss=='Past Financial Losses' || HeadOfLoss=='Future Financial Losses'){  
                              CaseFile.LossItem =Map_files.get(HeadofLoss+f.File_Name__c);
                         }
                         else{    
                             CaseFile.LossItem=f.Loss_Sub_Category__r.Loss_Type__c;
                         }    
                          CaseFile.DocumentId = f.id;     
                          CaseFile.DocumentType  = f.Document_Type__c;
                          CaseFile.DocumentName = f.File_Name__c; 
                          CaseFile.DocumentLink = f.File_Url__c;
                          tmpCaseFileslist.Add(CaseFile); 
                          Set_lossId.add(f.File_Url__c);
                           
                    
                 }
            
            Map_LossFile.put(f.Loss_Sub_Category__r.Loss_Category__c,tmpCaseFileslist);
      }
      
    }    
    
     system.debug('**CaseFileslist**'+tmpCaseFileslist);  
     
     return Map_LossFile; 
}

Public void SaveAllFilesSelection(){
    
    
    Set<String> set_docId = new Set<String>();
    
    Map<String,Boolean> Map_Genclaimant = new Map<String,Boolean>();
    Map<String,Boolean> Map_GenDefendant = new Map<String,Boolean>();
    Map<String,Boolean> Map_Itemclaimant = new Map<String,Boolean>();
    Map<String,Boolean> Map_ItemDefendant = new Map<String,Boolean>();
    
    

    for(FileCategory file:lstFileCategory){
        
        
        for(CaseFiles doc:file.lstLossFiles){
            if(file.CategoryName == 'General'){
                 set_docId.add(doc.DocumentId); 
                 Map_GenDefendant.put(doc.DocumentId,doc.DefendantSelect);  
                 Map_Genclaimant.put(doc.DocumentId,doc.ClaimantSelect);  
            }
            else{
                for(CaseFilesItemSelection item:doc.lstLossFiles){
                    Map_Itemclaimant.put(item.filelinkId,item.ClaimantSelect);  
                    Map_ItemDefendant.put(item.filelinkId,item.DefendantSelect);
                
                }
            }       
        }
        
    }
    
    ContentVersion[] Content = [SELECT Case_Id__c,ContentDocumentId,Document_Source__c,Submitted_for_Arbitration_By__c, FileType,INAP_Doc_Type__c,Loss_Item_ID__c,Sharing_Permissions__c,Title FROM ContentVersion where ContentDocumentId in:set_docId AND Sharing_Permissions__c !='Private' AND  Ghost_Draft_Doc__c =:false ORDER BY Title];
     
   system.debug('**Map_GenDefendant**'+Map_GenDefendant);
    for(ContentVersion con:Content){
         
          if(Map_Genclaimant.get(con.ContentDocumentId) == true && Map_GenDefendant.get(con.ContentDocumentId) == true){
              con.Submitted_for_Arbitration_By__c='Both Parties'; 
                          
          }    
          else if(Map_Genclaimant.get(con.ContentDocumentId) == true ){
              con.Submitted_for_Arbitration_By__c='Claimant Handler'; 
                          
          }
          else if(Map_GenDefendant.get(con.ContentDocumentId) == true ){
              con.Submitted_for_Arbitration_By__c='Defendant Handler';
             
          }
          else{
              con.Submitted_for_Arbitration_By__c='';
          } 
          
    }
    
    
    Loss_Category_Files__c[] Loss_CategoryFiles;
    
     Loss_CategoryFiles = [Select id,Loss_Sub_Category__c,Document_Type__c,File_Url__c,Loss_Sub_Category__r.Loss_Category__c,Loss_Sub_Category__r.Loss_Type__c From Loss_Category_Files__c where  CaseId__c=:CurrentCase.id AND (Loss_Sub_Category__r.status__c= 'Arbitration Doc Prep' OR Loss_Sub_Category__r.status__c= 'Arbitration Final Offers' OR Loss_Sub_Category__r.status__c= 'Arbitrating') ORDER BY File_Url__c ];        
     
     for(Loss_Category_Files__c f:Loss_CategoryFiles){
          if(Map_Itemclaimant.get(f.Id) == true && Map_ItemDefendant.get(f.Id) == true ){
              f.Submitted_for_Arbitration_By__c='Both Parties';
          }
          else if(Map_Itemclaimant.get(f.Id) == true){
              f.Submitted_for_Arbitration_By__c='Claimant Handler';                           
          }
          else if(Map_ItemDefendant.get(f.Id) == true ){
              f.Submitted_for_Arbitration_By__c='Defendant Handler';             
          }
          else{
              f.Submitted_for_Arbitration_By__c='';
          }
        
     }
    
    update Loss_CategoryFiles;
    
    
   update Content; 
   
    
   // generateLossitemList(StartRecId);
   CaseFilesSelectedlist = GeneralSelectedFiles();
   //CaseFileslist = populateCaseFiles('All','');
   generateLossitemList(StartRecId);
}



//--------------------------

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
  Public Boolean  Claimaint_Arbitration_Submitted {get;set;} 
  Public Boolean  Defendant_Arbitration_Submitted {get;set;} 
  Public Boolean  Defendant_Accept_Decline {get;set;}
  Public Boolean  Claimant_Accept_Decline {get;set;}
  
   
  Public Boolean  Claimant_Confirm_Documents {get;set;}
  Public Boolean  Defendant_Confirm_Documents {get;set;}
  Public Boolean  Defendant_Final_Offer {get;set;}
  Public Boolean  Claimant_Final_Offer {get;set;}
  Public Boolean  Arbitrators_Award {get;set;}
    
  
  Public Boolean  NOREFERAL {get;set;} 
  Public Boolean  BILATERALREFER {get;set;}
  Public Boolean  UNILATERALREFER {get;set;}
  
  
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
  Public String Status {get;set;}
  Public Boolean StageAccept {get;set;}  
  Public Boolean StageCancelSubmit {get;set;} 
  Public String ArbitrationAcceptedStatus {get;set;}
  Public String ArbitrationRationale {get;set;}
    
  Public Boolean StageReject {get;set;} 
  Public Boolean StageSubmit {get;set;} 
}
    
Public Class LossCategory{
  Public String CategoryName {get;set;}
  Public String CategoryId {get;set;}
  Public Decimal ClaimantPosition {get;set;}
  Public String ArbitrationRationale {get;set;}
  Public Decimal DocumentCount {get;set;}
  Public List<LossItem> lstLossItems {get;set;}
  Public List<Documentlist> lstDocuments {get;set;}
  Public List<CaseFiles> lstLossFiles {get;set;}
}

Public Class Documentlist{
    Public String DocumentName {get;set;}
    Public String DocumentType {get;set;}
    Public String LossItem {get;set;}
    Public String DocumentLink {get;set;} 
}


Public Class LossItem{

   Public String ItemName {get;set;}
   Public Decimal ClaimantPosition {get;set;} 
   Public Decimal DefendantPosition {get;set;}
   Public Decimal ArbitratorsPosition {get;set;}
   Public String ClaimantRWE {get;set;} 
   Public String DefendantRWE {get;set;}
   Public String ArbitratorRWE {get;set;}
   Public String ArbitrationRationale {get;set;}
    
   
   Public String PastFutureFinancialLosses {get;set;} 
   Public String SubCategory {get;set;}
   
   Public String Type {get;set;}
   Public String Status {get;set;}
   Public String Stage {get;set;}
   Public String CatId {get;set;}
   Public String RecId {get;set;}
  
    Public String ArbitratedBy {get;set;}
    Public String ArbitrationReferredBy {get;set;} 
    Public String ArbitrationAcceptedStatus {get;set;}
    Public Boolean StageAccept {get;set;}  
    Public Boolean StageCancelSubmit {get;set;}
    
    Public Boolean StageReject {get;set;} 
    Public Boolean StageSubmit {get;set;} 

}
 
 Public Class FileCategory{
     Public String CategoryName {get;set;}
     Public List<CaseFiles> lstLossFiles {get;set;}
 } 
 
 Public Class CaseFiles{
    Public String DocumentName {get;set;}
    Public String DocumentType {get;set;}
    Public String LossItem {get;set;}
    Public String DocumentLink {get;set;}
    Public String DocumentId {get;set;} 
    Public String ReferedBy {get;set;} 
    Public Boolean ClaimantSelect {get;set;}
    Public Boolean DefendantSelect {get;set;}  
    Public List<CaseFilesItemSelection> lstLossFiles {get;set;}  
}
 
Public Class CaseFilesItemSelection{
    Public String LossItemName {get;set;}
    Public String filelinkId {get;set;}
    Public String LinkedBy {get;set;}
    Public String ReferedBy {get;set;}
    
    Public Boolean ClaimantSelect {get;set;}
    Public Boolean DefendantSelect {get;set;} 
}    
 
 
    
    
}