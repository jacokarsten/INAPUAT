Public Class NotifyDefendantFINALAWARDCase{


@invocablemethod

Public static void finalawardamountemail(List<id> CaseId){
    
    Case[]  CaseQuick = [Select id,Invite_Arbitrator__c,Status,Settled_Status_Count__c ,Arbitrator_Contact__c ,Arbitration_Completed_Count__c ,Arbitration_Negotiation_Count__c,Settlement_Negotiation_Status_Count__c,Submit_Schedule_of_Losses__c,Submit_Case__c,Defendent_rejection_reason__c ,Stage__c,Defendant_Agree_to_Arbitration_Process__c,Defendant_Accept_Reject__c ,Submit_Schedule_of_Losses_Defendant__c,Arbitration_Firm__c,Agree_to_Arbitration_Process__c, Claimant_Firm_Team__c,ClaimantFirm__c,Claimant_Minimum_Personal_Details__c,Defendant_Minimum_Personal_Details__c,Facilitator_Firm__c,Facilitator_Contact__c,Defendant_Firm_Team__c,Defendant_Firm__c,Total_Obligation__c,Protocol__r.Mininmum_Schedule__c,Merit_Minimum_Requirements__c from Case Where id in:CaseId]; //CQuick.Id
 
    for(Case   c:CaseQuick){ 
        CaseNotificationHandler.NotifyTeamMembersRegistration(c.Defendant_Firm_Team__c,'Defendant',c.id,'Final');
        CaseNotificationHandler.NotifyTeamMembersRegistration(c.Claimant_Firm_Team__c,'Claimant',c.id,'Final');
    }    


}


Public static decimal calculatefinalamount(String CaseId){
        
        
        List<Loss_Category__c>  LossCategory = new List<Loss_Category__c>([SELECT id,Rationale__c,Loss_Item_Count__c,Total_Arbitration_Award__c,AwardDocName__c,Total_Claimant_Position__c,Confirm_Case_Settlement__c,Settled_Status_Count__c,Schedule_of_Losses__c,Loss_Category_Types__c,Loss_Category_Types__r.Name FROM Loss_Category__c where Case__c =:CaseId]);
        List<Loss_Sub_Categories__c>  LossSubCategories = new List<Loss_Sub_Categories__c>([SELECT Id,Arbitrator_Rationale__c,  Loss_Type__c,Loss_Category__r.Loss_Category_Types__r.Name,Arbitration_Referred_By__c,Arbitration_Accepted_Status__c,Past_Future_Financial_Item__c, Sub_Category__c,Defendant_Position__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c WHERE (Status__c = 'Arbitrated' OR Status__c = 'Settled' ) AND Loss_Category__c in:  LossCategory ]);
                
       
      
      Decimal TotalDamages=0,TotalArbitrated=0,TotalSettled=0,TotalLegalCosts=0,Merit=0;
      
       for(Loss_Category__c c:LossCategory){                 
                 
          if(c.Confirm_Case_Settlement__c > 0 && c.Settled_Status_Count__c==0){
                     
                  if(c.AwardDocName__c =='isforlegalcosts'){
                      TotalLegalCosts = c.Total_Arbitration_Award__c;
                      system.debug('***LEGAL**');
                  }   
                    system.debug('***ONE**');  
          } 
          else if(c.Confirm_Case_Settlement__c == 0 && c.Settled_Status_Count__c > 0){
                   
                 if(c.AwardDocName__c =='isforlegalcosts'){
                      TotalLegalCosts = c.Total_Claimant_Position__c;
                      system.debug('***LEGAL2**');
                  } 
          }                
          if(c.Loss_Item_Count__c==0){
                    
                     
                     if(c.AwardDocName__c =='isforlegalcosts'){
                          TotalLegalCosts = 0;
                          system.debug('***LEGAL3**');
                     } 
            
            }     
            for(Loss_Sub_Categories__c  l:LossSubCategories){
                            
                       if(l.Loss_Category__c == c.id){
                       
                            if(l.Status__c == 'Arbitrated'){
                                  
                                 TotalArbitrated = TotalArbitrated + l.Arbitrator_Award__c;
                                 system.debug('***ARB**');
                            }
                             else if(l.Status__c == 'Settled'){
   
                                  system.debug('***LOSS_Sett**');
                                 TotalSettled = TotalSettled+l.Claimant_Position__c;
                             }
                             
                            
                         } 
             }
                 
          
       } 
      For (Merit__c mer : [SELECT Agree_to_Settle__c,Arbitrator_Rationale__c,Arbitrator_Award__c,Claimant_Position__c,CreatedDate,Defendant_Position_Max__c,Defendant_Position__c,Claimant_Rationale__c,Status__c,Submit_Claimant__c,Submit_Defendant__c FROM Merit__c 
                             where Related_Case__c =: Caseid  ]){
           if(mer.Status__c=='Settled'){                  
              
              Merit =  mer.Defendant_Position__c;
           }
           else if(mer.Status__c=='Arbitrated'){
 //CHANGE
                 Merit =  mer.Arbitrator_Award__c;
           }
           
                       
        }  
  
      TotalDamages=(TotalArbitrated+TotalSettled-TotalLegalCosts)*(Merit/100);// +TotalLegalCosts;
         
return TotalDamages;
}




}