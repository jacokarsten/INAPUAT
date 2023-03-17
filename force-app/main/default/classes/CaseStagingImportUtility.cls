Public Class CaseStagingImportUtility{
    @InvocableMethod
    
    
    Public static void ProcessImportedData (List<Id> ids){
        
        Map <Id, Id> StageCaseMap = new Map<id, id>();
        Map <Id, id> StageNewIncidentMap = new Map<id, Id>();
        Map <Id, Case> StageNewCaseMap = new Map<id, Case>();
        Map <Id, id> StageNewSOLMap = new Map<id, id>();
        Map <id, Id> CaseClaimaintMap = New Map<id, id>();
        Map <id,Id> CaseSQLMap = new Map<id, id>();
        List<Case> NewCaseList = New List<Case>();
        List<Case> NewCaseListUpdate = New List<Case>();
        List<Case_Staging_Table__c> CaseStagingList = new List<Case_Staging_Table__c>();
        List<Case_Staging_Table__c> CaseStagingUpdateList = New List<Case_staging_Table__c>(); 
        List<Incident_Information__c> NewIncidentList = New List<Incident_Information__c>();
        List<Claimant_Information__c> NewClaimantList = New List<Claimant_Information__c>();
        List<Defendant_Information__c> NewDefendantList = New List<Defendant_Information__c>();
        List<Defendant_Firm__c> NewDefendantFirmList = New List<Defendant_Firm__c>();
        List<Schedule_of_Losses__c> NewScheduleOfLossesList = New List<Schedule_of_Losses__c>();
        List<Merit__c> NewMeritList = New List<Merit__c>();
        List<Loss_Category__c> NewPFL = New List<Loss_Category__c>();
        List<Loss_Category__c> NewPSLA = New List<Loss_Category__c>();
        List<Loss_Category__c> NewFFL = New List<Loss_Category__c>();
        List<Loss_Category__c> NewLOCE = New List<Loss_Category__c>();
        List<Loss_Category__c> NewDOLM = New List<Loss_Category__c>();
        List<Loss_Category__c> NewBereavement = New List<Loss_Category__c>();
        List<Loss_Category__c> NewLegalCosts = New List<Loss_Category__c>();
        List<Loss_Category__c> NewLC = New List<Loss_Category__c>();
        
        For (Case_Staging_Table__c cst : [SELECT Case_Source__c,Protocol_Code__c,
                                          Claimant_Firm_ID__c, Defendant_Firm_ID__c,  
                                          Incident_Description__c,
                                          Incident_Date__c,
                                          Address_Line_1__c, Address_Line_2__c,Incident_City__c ,Incident_Post_Code__c,Incident_Country__c,
                                          Claimant_First_Name__c, Claimant_Last_Name__c, Claimant_Date_Of_Birth__c ,Claimant_Vehicle_Registration_Number__c,
                                          Defendant_First_Name__c, Defendant_Last_Name__c, 
                                          Defendant_Date_of_Birth__c ,
                                          Defendant_Vehicle_Registration_Number__c,
                                          Merit_Claimant_Position__c,
                                          Mapped_Protocol__c, Mapped_Claimant_Firm__c,Mapped_Defendant_Firm__c , Mapped_Status_Detail__c ,
                                          Mapped_Firm_Team__c 
                                          FROM Case_Staging_Table__c where Id =: Ids]){
                                              
                                              CaseStagingList.add(cst);                           
                                              
                                              /* Create Incident */
                                              Incident_Information__c newIncident = new Incident_Information__c();
                                              newIncident.Incident_Date__c = cst.Incident_Date__c;
                                              newIncident.City2__c = cst.Incident_City__c ;
                                              newIncident.Postal_Code__c = cst.Incident_Post_Code__c;
                                              newIncident.Country__c = cst.Incident_Country__c; 
                                              newIncident.Description__c = cst.Incident_Description__c  ;
                                              newIncident.Address_Line_1__c = cst.Address_Line_1__c; 
                                              newIncident.Address_Line_2__c = cst.Address_Line_2__c;
                                              NewIncident.Case_Staging__c  = cst.id;
                                              NewIncidentList.add( newIncident);
                                              
                                          }
        if (NewIncidentList.size() > 0){
            insert NewIncidentList;
        }
        
        for(Incident_Information__c inc: NewIncidentList){   
            System.Debug('## Incident : '  + inc.id + ' , ' + inc.Case_Staging__c     + ' ##');                     
            StageNewIncidentMap.put (inc.Case_Staging__c , inc.id);                 
        }
        
        /* Create New Cases relating to Case Staging table */
        For (Case_Staging_Table__c cst :  CaseStagingList){                                           
            Case NewCase = New Case();
            NewCase.Case_Source__c = cst.Case_Source__c;
            NewCase.Protocol__c = cst.Mapped_Protocol__c;
            NewCase.ClaimantFirm__c = cst.Mapped_Claimant_Firm__c;
            /*NewCase.Claimant_Firm_Team__c = cst.Mapped_Firm_Team__c;*/
            NewCase.Defendant_Firm__c = cst.Mapped_Defendant_Firm__c;
            NewCase.Case_Staging__c  = cst.id;
            NewCase.Origin = 'Bulk Upload';
            
            String Incident_Id = '';
            Incident_Id = StageNewIncidentMap.get(cst.id);
            System.Debug('## Incident_ID : ' + Incident_Id + ' ##');                              
            NewCase.Incident_Information__c = Incident_id;        
            NewCaseList.add(NewCase);                          
        }
        
        /* Insert new cases */
        if (NewCaseList.size() > 0){
            insert NewCaseList;
            System.debug ('### NewCaseList ###'); 
            
        }
        
        /* Insert Update Case Staging records with new related cases */    
        for (case c: NewCaseList){
            StageNewCaseMap.put(c.Case_Staging__c, c);  
            Case_Staging_Table__c  newcsu = new Case_Staging_Table__c(); 
            newcsu.id = c.Case_Staging__c;
            newcsu.Related_New_Case__c = c.id; 
            CaseStagingUpdateList.add(newcsu);         
        }
        
        if (CaseStagingUpdateList.size() > 0){
            update CaseStagingUpdateList;
        }  
        
        /* Add related Claimants, Defendants */
        For (Case_Staging_Table__c cst :  CaseStagingList){ 
        
            Case UpdateCase = New Case();
            UpdateCase = StageNewCaseMap.get(cst.id);
            System.debug('#$$$# UpdateCase '  + UpdateCase.id + ' #$$$#');
            UpdateCase.Claimant_Firm_Team__c = cst.Mapped_Firm_Team__c;
            System.debug('#$$$# Firm Team '  + cst.Mapped_Firm_Team__c + ' #$$$#');
            NewCaseListUpdate.add(UpdateCase);
            
            
        
        
            Claimant_Information__c NewClaimant = new Claimant_Information__c(); 
            NewClaimant.Case__c = StageNewCaseMap.get(cst.id).id;
            
            System.Debug('#$$# New Claimant Case__c ' + NewClaimant.Case__c + ' #$$#');
            NewClaimant.Claimant_First_Name__c = cst.Claimant_First_Name__c;
            System.Debug('#$$# New Claimant First Name ' + NewClaimant.Claimant_First_Name__c + ' #$$#');
            NewClaimant.Claimant_Last_Name__c = cst.Claimant_Last_Name__c;  
            System.Debug('#$$# New Claimant Last Name ' + NewClaimant.Claimant_Last_Name__c + ' #$$#');
            NewClaimant.Claimant_Date_Of_Birth__c  = cst.Claimant_Date_Of_Birth__c;
            System.Debug('#$$# New Claimant DOB ' + NewClaimant.Claimant_Date_Of_Birth__c + ' #$$#');
            NewClaimant.Claimant_Vehicle_Registration_Number__c = cst.Claimant_Vehicle_Registration_Number__c;
            System.Debug('#$$# New Claimant Vehicle Reg No' + NewClaimant.Claimant_Vehicle_Registration_Number__c  + ' #$$#');     
            NewClaimantList.add(NewClaimant);
            
            Defendant_Information__c NewDefendant  = new Defendant_Information__c(); 
            NewDefendant.Case__c = StageNewCaseMap.get(cst.id).id;
            NewDefendant.Defendant_First_Name__c = cst.Defendant_First_Name__c;
            NewDefendant.Defendant_Last_Name__c = cst.Defendant_Last_Name__c;  
            NewDefendant.Defendant_Date_of_Birth__c  = cst.Defendant_Date_of_Birth__c; 
            NewDefendant.Defendant_Vehicle_Registration_Number__c = cst.Defendant_Vehicle_Registration_Number__c;
            NewDefendantList.Add(NewDefendant);
            
            Defendant_Firm__c NewDefendantFirm = New Defendant_Firm__c();
            NewDefendantFirm.Case__c = StageNewCaseMap.get(cst.id).id;
            NewDefendantFirm.Firm__c = cst.Mapped_Defendant_Firm__c; 
            NewDefendantFirmList.add(NewDefendantFirm);    
            
            Schedule_of_Losses__c NewScheduleOfLosses = New Schedule_of_Losses__c();
            NewScheduleOfLosses.Case__c = StageNewCaseMap.get(cst.id).id;
            Id CaseId = StageNewCaseMap.get(cst.id).id;
            Id ClaimaintId = CaseClaimaintMap.get(caseid);
            NewScheduleOfLosses.Claimant_Information__c = Claimaintid;
            NewScheduleOfLossesList.add(NewScheduleOfLosses);  
                
       }  
       
       If (NewCaseListUpdate.size() > 0){
          System.debug('#$$$# '  + NewCaseListUpdate.size() + '#$$$#');
          update NewCaseListUpdate;
       } 
       
       if (NewClaimantList.size() > 0){
           insert NewClaimantList;
       }         
       for( Claimant_Information__c cl : NewClaimantList){
           System.debug('Claimant_Information__c.Id: ' + cl.Id);
           CaseClaimaintMap.put(cl.case__c, cl.id);
       }
       if (NewDefendantList.size() > 0){
           insert NewDefendantList;
       }    
       if (NewDefendantFirmList.size() > 0){
           insert NewDefendantFirmList;
       }  
       if (NewScheduleofLossesList.size() > 0){
           insert NewScheduleofLossesList;
       }
       for( Schedule_of_Losses__c SOL : NewScheduleofLossesList){
           System.debug('Schedule_of_Losses__c.Id: ' + SOL.Id);
           CaseSQLMap.put(SOL.Case__c, SOL.id);
       }
       
       
       For (Case_Staging_Table__c cst :  CaseStagingList){  
            Merit__c NewMerit = New Merit__c();
            NewMerit.Related_Case__c = StageNewCaseMap.get(cst.id).id;
            NewMerit.Name = 'Defendant Liability';
            Id Case_id = StageNewCaseMap.get(cst.id).id;
            Id SQLId = CaseSQLMap.get(Case_id);
            NewMerit.Schedule_of_Losses__c = SQLId;
            NewMerit.Claimant_Position__c = cst.Merit_Claimant_Position__c;
            NewMeritList.add(NewMerit);
            
            Loss_Category__c NewHeadOfLossPFL = New Loss_Category__c();
            NewHeadOfLossPFL.Case__c = StageNewCaseMap.get(cst.id).id;
            NewHeadOfLossPFL.Head_of_Loss_Type__c = 'Past Financial Losses';
            NewHeadOfLossPFL.Schedule_of_Losses__c = SQLId;
            NewLC.add(NewHeadOfLossPFL);
            
            Loss_Category__c NewHeadOfLossPSLA = New Loss_Category__c();
            NewHeadOfLossPSLA.Case__c = StageNewCaseMap.get(cst.id).id;
            NewHeadOfLossPSLA.Head_of_Loss_Type__c = 'Pain, Suffering & Loss of Amenities';
            NewHeadOfLossPSLA.Schedule_of_Losses__c = SQLId;
            NewLC.add(NewHeadOfLossPSLA);
            
            Loss_Category__c NewHeadOfLossFFL = New Loss_Category__c();
            NewHeadOfLossFFL.Case__c = StageNewCaseMap.get(cst.id).id;
            NewHeadOfLossFFL.Head_of_Loss_Type__c = 'Future Financial Losses';
            NewHeadOfLossFFL.Schedule_of_Losses__c = SQLId;
            NewLC.add(NewHeadOfLossFFL);
            
            Loss_Category__c NewHeadOfLossLOCE = New Loss_Category__c();
            NewHeadOfLossLOCE.Case__c = StageNewCaseMap.get(cst.id).id;
            NewHeadOfLossLOCE.Head_of_Loss_Type__c = 'Loss of Congenial Employment';
            NewHeadOfLossLOCE.Schedule_of_Losses__c = SQLId;
            NewLC.add(NewHeadOfLossLOCE);
            
            Loss_Category__c NewHeadOfLossDOLM = New Loss_Category__c();
            NewHeadOfLossDOLM.Case__c = StageNewCaseMap.get(cst.id).id;
            NewHeadOfLossDOLM.Head_of_Loss_Type__c = 'Disadvantage on Labour Market';
            NewHeadOfLossDOLM.Schedule_of_Losses__c = SQLId;
            NewLC.add(NewHeadOfLossDOLM);
            
            Loss_Category__c NewHeadOfLossBereavement = New Loss_Category__c();
            NewHeadOfLossBereavement.Case__c = StageNewCaseMap.get(cst.id).id;
            NewHeadOfLossBereavement.Head_of_Loss_Type__c = 'Bereavement';
            NewHeadOfLossBereavement.Schedule_of_Losses__c = SQLId;
            NewLC.add(NewHeadOfLossBereavement);
            
            Loss_Category__c NewHeadOfLossLegalCosts = New Loss_Category__c();
            NewHeadOfLossLegalCosts.Case__c = StageNewCaseMap.get(cst.id).id;
            NewHeadOfLossLegalCosts.Head_of_Loss_Type__c = 'Legal Costs';
            NewHeadOfLossLegalCosts.Schedule_of_Losses__c = SQLId;
            NewLC.add(NewHeadOfLossLegalCosts); 
       
       } 
       
       if (NewMeritList.size() > 0){
            insert NewMeritList;
       }
       if (NewLC.size() > 0){
            insert NewLC;    
       }                
    }
 }