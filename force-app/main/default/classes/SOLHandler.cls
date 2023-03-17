Public Class SOLHandler{



Public static void ResetArbitration(Set<String> set_Case){


         List<Schedule_of_Losses__c> ScheduleofLosses = new List<Schedule_of_Losses__c>([Select id, Bilateral_referral_date_passed__c,No_referral_date_passed__c,Unilateral_referral_date_passed__c,
         Claimant_Accept_Decline__c, Defendant_Accept_Decline__c,Arbitrators_Award_Finalised__c,  Claimant_Final_Offer_Confirmed__c,Defendant_Final_Offer_Confirmed__c,Claimant_Confirm_Documents_Uploaded__c, 
         Defendant_Confirm_Documents_uploaded__c,Arbitrator_Invite_Date__c,Invite_Arbitrator__c,   Arbitration_Start_Date__c,Doc_Prep_Start_Date__c,Final_Offers_Start_Date__c,Name,Case__c,Defendant_Arbitration_Submitted__c,Claimaint_Arbitration_Submitted__c From Schedule_of_Losses__c Where Case__c in: set_Case AND (Unilateral_referral_date_passed__c=:false OR (Unilateral_Arbitration_Overlap__c=:True AND Unilateral_referral_date_passed__c=:true)) AND Arbitrators_Award_Finalised__c=:true]);
         
         Set<String> Set_CaseSOL = new Set<String>();
         
         for(Schedule_of_Losses__c sched:ScheduleofLosses){
             
             sched.Claimant_Final_Offer_Confirmed__c =false;
             sched.Defendant_Final_Offer_Confirmed__c=false;
             sched.Claimant_Confirm_Documents_Uploaded__c=false;
             sched.Defendant_Confirm_Documents_uploaded__c=false;
             sched.Defendant_Arbitration_Submitted__c=false;
             sched.Claimaint_Arbitration_Submitted__c=false;
             sched.Arbitrators_Award_Finalised__c = false;
             sched.Arbitration_Start_Date__c=null;
             sched.Doc_Prep_Start_Date__c = null;
             sched.Final_Offers_Start_Date__c = null;
             sched.Arbitrator_Invite_Date__c= null;
             sched.Invite_Arbitrator__c= false;
             
             Set_CaseSOL.add(sched.Case__c);
         }
         update  ScheduleofLosses;

         List<Case> lst_Case = new List<Case>([Select Arbitrator_Email__c,Arbitration_Accept_Date__c,Arbitration_Firm__c,Arbitrator_Contact__c,Arbitrator_Accept_Decline__c,Invite_Arbitrator__c From Case where id in: Set_CaseSOL]);
        
        Set<String> Set_CaseId = new Set<String>();
        Set<String> Set_Con = new Set<String>();
        Set<String> UserId = new Set<String>();
        
        
        
        for(Case cs:lst_Case){ 
             cs.Arbitration_Firm__c=null;
             cs.Arbitration_Accept_Date__c=null;
             cs.Arbitrator_Accept_Decline__c = null;
             cs.Invite_Arbitrator__c = false;
             cs.Arbitrator_Email__c = null;
             Set_CaseId.Add(cs.id);
             Set_Con.Add(cs.Arbitrator_Contact__c);
             cs.Arbitrator_Contact__c=null;
        }
        update lst_Case; 
        system.debug('***UserId**');
        
        User[] ArbUser = [Select id From User where ContactId in: Set_Con];
        
        for(User us:ArbUser){
            UserId.Add(us.id);
        }
        
        system.debug('***UserId**'+UserId+'**Set_CaseId**'+Set_CaseId+'***Set_CaseSOL**'+Set_CaseSOL+'**Sched**'+ScheduleofLosses);
        CaseMemberHandler.RemoverCaseTeamRole('Arbitrator', Set_CaseId, UserId);
        if(Set_CaseSOL.size()>0){
            resetDeclinedItems(Set_CaseSOL);
        }    
}


Public static void resetDeclinedItems(Set<String> Set_CaseSOL ){

        List<Loss_Sub_Categories__c> LossSubCategories;
         LossSubCategories = new List<Loss_Sub_Categories__c>([SELECT Id,Arbitrated_by__c,Loss_Type__c,Arbitrator_Rationale__c,Arbitration_Referred_By__c,Arbitration_Accepted_Status__c,Past_Future_Financial_Item__c, Sub_Category__c,Defendant_Position__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c WHERE Arbitration_Referred_By__c !=:null AND Arbitration_Accepted_Status__c =:'Declined' AND Loss_Category__r.Case__c in:Set_CaseSOL AND Arbitrated_by__c=:null]);
                 
        
        for(Loss_Sub_Categories__c l:LossSubCategories){
            l.Arbitration_Referred_By__c=''; 
            l.Arbitration_Accepted_Status__c ='';    
        }
        
        update LossSubCategories;

}


}