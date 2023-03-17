Public Class CaseReferalHandler{



public static void UpdatetoDocPrepStatus(Set<String> Set_CaseID){
    
       system.debug('**Set_CaseID**'+Set_CaseID); 
        
     List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,Unilateral_referral_date__c,Doc_Prep_Start_Date__c,Defendant_Accept_Decline__c,Claimant_Accept_Decline__c,Claimaint_Arbitration_Submitted__c,Defendant_Arbitration_Submitted__c, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c 
                         From Schedule_of_Losses__c Where Case__c in: Set_CaseID 
                         AND Bilateral_referral_date_passed__c=:true
                         AND Unilateral_Arbitration_Overlap__c =: false
                         AND Unilateral_referral_date_passed__c =:true
                         AND Doc_Prep_Start_Date__c=:null]);
        
        
      List<Loss_Category__c> LossCategory =  new List<Loss_Category__c>([SELECT id,Schedule_of_Losses__c,Loss_Category_Types__r.Name FROM Loss_Category__c where Schedule_of_Losses__c in:ScheduleofLosses]);
      List<Loss_Sub_Categories__c> LossSubCategories  = new List<Loss_Sub_Categories__c>([SELECT Id,Arbitration_Referred_By__c,Arbitration_Accepted_Status__c,Past_Future_Financial_Item__c, Sub_Category__c,Defendant_Position__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c WHERE (Status__c = 'Negotiating' OR Status__c = 'Referred to Arbitration' ) AND Loss_Category__c in:  LossCategory ]);
      List<Merit__c> lstMerit = new List<Merit__c>([Select id,Status__c,Arbitration_Accepted_Status__c,Defendant_Position__c,Arbitration_Referred_By__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Schedule_of_Losses__c in: ScheduleofLosses and (Status__c='Negotiating' OR Status__c='Referred to Arbitration')]);
      
      
        
      for(Schedule_of_Losses__c s:ScheduleofLosses){
              s.Doc_Prep_Start_Date__c = system.today();
              s.Defendant_Accept_Decline__c=true;
              s.Claimant_Accept_Decline__c=true;
              s.Claimaint_Arbitration_Submitted__c=true;
              s.Defendant_Arbitration_Submitted__c=true;                     
      }  
      
      for(Loss_Sub_Categories__c c:LossSubCategories){
          c.Status__c='Arbitration Doc Prep';
          c.Arbitration_Accepted_Status__c ='Accepted';
      }
      update LossSubCategories;
      
      
      for(Merit__c m:lstMerit){
          m.Arbitration_Accepted_Status__c   = 'Accepted';
          m.Status__c = 'Arbitration Doc Prep';
      }   
      
      update lstMerit;
      
      update ScheduleofLosses;
        
}

public static void UpdatetoFinalOffersStatus(Set<String> Set_CaseID){
    
    system.debug('**Set_CaseID**'+Set_CaseID); 
        
     List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,Invite_Arbitrator__c,Doc_Prep_End_Date__c,Defendant_Accept_Decline__c,Claimant_Accept_Decline__c,Claimaint_Arbitration_Submitted__c,Defendant_Arbitration_Submitted__c, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c 
                         From Schedule_of_Losses__c Where Case__c in: Set_CaseID 
                        
                         AND Bilateral_referral_date_passed__c=:True
                         AND Doc_Prep_Date_passed__c =:true
                         AND Final_Offers_Start_Date__c =: null
                         ]);
        
        
      List<Loss_Category__c> LossCategory =  new List<Loss_Category__c>([SELECT id,Schedule_of_Losses__c,Loss_Category_Types__r.Name FROM Loss_Category__c where Schedule_of_Losses__c in:ScheduleofLosses]);
      List<Loss_Sub_Categories__c> LossSubCategories  = new List<Loss_Sub_Categories__c>([SELECT Id,Arbitration_Referred_By__c,Arbitration_Accepted_Status__c,Past_Future_Financial_Item__c, Sub_Category__c,Defendant_Position__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c WHERE (Status__c = 'Arbitration Doc Prep' ) AND Loss_Category__c in:  LossCategory ]);
      List<Merit__c> lstMerit = new List<Merit__c>([Select id,Status__c,Arbitration_Accepted_Status__c,Defendant_Position__c,Arbitration_Referred_By__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Schedule_of_Losses__c in: ScheduleofLosses and Status__c='Arbitration Doc Prep']);
      
      for(Loss_Sub_Categories__c c:LossSubCategories){
          c.Status__c='Arbitration Final Offers';
      }
      update LossSubCategories;
      
      
      for(Merit__c m:lstMerit){
          m.Status__c = 'Arbitration Final Offers';
      }   
      
      update lstMerit;
        
      for(Schedule_of_Losses__c s:ScheduleofLosses){
          
           
              s.Claimant_Confirm_Documents_Uploaded__c=true;
              s.Defendant_Confirm_Documents_uploaded__c=true; 
              s.Final_Offers_Start_Date__c = system.today(); 
              s.Invite_Arbitrator__c = true;    
          
      }  
      
      update ScheduleofLosses;
      
      
      
}


public static void UpdatetoArbitratingStatus(Set<String> Set_CaseID){
    
    system.debug('**Set_CaseID**'+Set_CaseID); 
     List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id,Defendant_Accept_Decline__c,Claimant_Accept_Decline__c,Claimaint_Arbitration_Submitted__c,Defendant_Arbitration_Submitted__c, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c 
                         From Schedule_of_Losses__c Where Case__c in: Set_CaseID 
                         AND Bilateral_referral_date_passed__c=:True
                         AND Doc_Prep_Date_passed__c =:true
                         AND Final_Offers_Date_passed__c =:true
                         AND Arbitration_Start_Date__c =: null
                         ]);
        
        
      List<Loss_Category__c> LossCategory =  new List<Loss_Category__c>([SELECT id,Schedule_of_Losses__c,Loss_Category_Types__r.Name FROM Loss_Category__c where Schedule_of_Losses__c in:ScheduleofLosses]);
      List<Loss_Sub_Categories__c> LossSubCategories  = new List<Loss_Sub_Categories__c>([SELECT Id,Arbitration_Referred_By__c,Arbitration_Accepted_Status__c,Past_Future_Financial_Item__c, Sub_Category__c,Defendant_Position__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c WHERE (Status__c = 'Arbitration Final Offers' ) AND Loss_Category__c in:  LossCategory ]);
      List<Merit__c> lstMerit = new List<Merit__c>([Select id,Status__c,Arbitration_Accepted_Status__c,Defendant_Position__c,Arbitration_Referred_By__c, Arbitrator_Award__c,Related_Case__c, Claimant_Position__c, name, Schedule_of_Losses__c From Merit__c where Schedule_of_Losses__c in: ScheduleofLosses and Status__c='Arbitration Final Offers']);
      
      for(Loss_Sub_Categories__c c:LossSubCategories){
          c.Status__c='Arbitrating';
      }
      update LossSubCategories;
      
      
      for(Merit__c m:lstMerit){
          m.Status__c = 'Arbitrating';
      }   
      
      update lstMerit;
        
        
      for(Schedule_of_Losses__c s:ScheduleofLosses){
          s.Claimant_Final_Offer_Confirmed__c=true;
          s.Defendant_Final_Offer_Confirmed__c  =true;
          s.Arbitration_Start_Date__c = system.today(); 
               
      }  
      
      update ScheduleofLosses;
      
      
      
        
}


}