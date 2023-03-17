Public Class ghostscriptUtility{


/*00001034
00001191
*/

 public static String GetNoticeofCommencementXML(String GDCaseId){
     String output = ''; 
     String CaseId = ''; 
     String ClaimantFirmId = '';
     String ClaimantFirmTeamId = '';
     String ClaimantFirmName = '';
     String DefendantFirmId = '';
     String DefendantFirmTeamId = '';
     String DefendantFirmName = '';
     List<Case> caseupdate = new List<Case>();
     List<GhostDraftLog__c> GDNewLog = new List<GhostDraftLog__c>();
     
     output =  '<?xml version="1.0" encoding="utf-8"?>';
     output += '<INAP xmlns="http://ghostdraft.korbitec.com/server/model/INAP-1.2">';
     
     output += '<Case>';
     
     for (Case c: [SELECT Id,  CaseNumber, Arbitrator_Contact__c,Defendant_Firm_Team__c, Incident_Information__c, ClaimantFirm__c, Claimant_Firm_Name__c, Claimant_Firm_Team__c, Defendant_Firm__c , Defendant_Firm_Name__c FROM Case WHERE  Id =: GDCaseId Limit 1]){
          Caseid = c.id;
          ClaimantFirmId = c.ClaimantFirm__c;
          ClaimantFirmTeamId = c.Claimant_Firm_Team__c; 
          DefendantFirmId = c.Defendant_Firm__c;
          DefendantFirmTeamId = c.Defendant_Firm_Team__c;
          DefendantFirmName = c.Defendant_Firm_Name__c;
          output += '<CaseIdentifier>#' + c.CaseNumber + '</CaseIdentifier>';
          output += '<AcceptanceDate>' +FormatDatetime(system.today()) +'T00:00:00</AcceptanceDate>';
     }
     output += '</Case>';
     output += GetNoticeofCommencementTeamXML( caseid, 'Claimant' , ClaimantFirmId, ClaimantFirmTeamId );
     output += GetNoticeofCommencementTeamXML( caseid, 'Defendant' , DefendantFirmId, DefendantFirmTeamId );
     
     output += '</INAP>';
              
     GhostDraftlog__c GD = new GhostDraftlog__c();
     GD.Case__c = Caseid;
     GD.XML__c = output;
     GDNewLog.add(GD);
     
     if (GDNewLog.size() > 0){
        //Insert GDNewLog; 
     }
     
         
     return output;      
 }
    
  
    
 Public static String GetNoticeofCommencementTeamXML( String Caseid, String FirmType , String Firmid, String FirmTeamId ){
        String output = '';
        output += '<'+ FirmType + 'Firm>';
        
        
        
        for (Firm_Team_Roles__c  FTR : [Select Contact__c,Contact__r.Firstname, Contact__r.LastName,  Firm_Team__c, Roles__c From Firm_Team_Roles__c Where Firm_Team__c =: FirmTeamId AND Roles__c='Case Handler' limit 1]){
            output += '<Handler>';
            output += '<Name>';
            output += '<FirstName>'+ FTR.Contact__r.Firstname + '</FirstName>';
            output += '<Title></Title>';
            output += '<LastName>'+FTR.Contact__r.LastName +'</LastName>';
            output += '</Name>';
            output += '</Handler>';
         } 
      
      
         
         for ( Account  FT : [SELECT Id, Name , BillingPostalCode,BillingStreet FROM Account where id = : Firmid  Limit 1]){
            output += '<FullName>' + FT.Name + '</FullName>';
            output += '<PhysicalAddress>';
           if(FT.BillingStreet !=null){
                output += '<Line1>' + FT.BillingStreet + '</Line1>';
           }
           else{
               output += '<Line1></Line1>';
           }
           
           if(FT.BillingPostalCode != null){
               output += '<PostalCode>' + FT.BillingPostalCode + '</PostalCode>';
           }
           else{
               output += '<PostalCode></PostalCode>';
           }
            
            
            output += '</PhysicalAddress>';
         }   
            
      
        if (FirmType == 'Claimant'){
             output += '<Claimant>';
             output += '<Name>';
             for (Claimant_Information__c CI : [Select id, Claimant_First_Name__c, Claimant_Last_Name__c, Case__c from Claimant_Information__c 
                                        where case__c =: CaseId Limit 1]){
                 output += '<FirstName>'+ CI.Claimant_First_Name__c + '</FirstName>';
                 output += '<LastName>'+ CI.Claimant_Last_Name__c + '</LastName>';
             }
             output += '</Name>';
             output += '</Claimant>';           
        }
        if (FirmType == 'Defendant'){
             output += '<Defendant>';
             output += '<Name>';
             for (Defendant_Information__c DI : [Select id, Defendant_First_Name__c, Defendant_Last_Name__c, Case__c from Defendant_Information__c 
                                        where case__c =: CaseId Limit 1]){
                 output += '<FirstName>'+ DI.Defendant_First_Name__c + '</FirstName>';
                 output += '<LastName>'+ DI.Defendant_Last_Name__c + '</LastName>';
             }
             output += '</Name>';
             output += '</Defendant>';           
         }
      output += '</'+ FirmType + 'Firm>';
     return output;              
 }
        
 
 
 Public static string FormatDatetime (Datetime RequestDate) {
     String formatedDt = '';
     if (RequestDate != null){
        formatedDt = RequestDate.formatGMT('yyyy-MM-dd');
     }
    return formatedDt  ;
 }
     
 Public static Double FormatNumber (Double var) {
    Double result = 0;
    If (result != null){
       result = var;
    } 
 return result;
 }
    
 Public static String FormatText(String var) {
    String Result = '';
     if(String.isNotBlank(var)) {
        Result = var;  
    }
    else {
        Result = '';
    }
    return Result;
 }
  
    /*
  Public static String FormatText (String var) {
    String result = '';
      If (result != null || result = 'null' ){
       result = var;
     } 
 return result;
 }
*/
    
    
public static Map<String,String> GetARBITRALXML_2(String GDCaseId) {

        String DocType;
        
        String output = '';
        Set<Id> caseSetIds = new Set<Id>();
        String CaseId = ''; 
        Set<id> HeadofLossSetIds = new Set<id>();
        Integer HoLCount = 0;
        String ArbitratorId = '';
        String IncidentId = '';
        String HeadofLossId = '';
        String Rationale = '';
        
        String ClaimantFirmId = '';
     String ClaimantFirmTeamId = '';
     String ClaimantFirmName = '';
     String DefendantFirmId = '';
     String DefendantFirmTeamId = '';
     String DefendantFirmName = '';
        
        
        Map<String, String> lscMap = new Map<String, String>();
        Map<Id, Loss_Category__c > HeadofLossMap = new Map<Id, Loss_Category__c >();
        List<Case> caseupdate = new List<Case>();
        List<GhostDraftLog__c> GDNewLog = new List<GhostDraftLog__c>();

        String CurrentHeadofLossId = '';
     
        
        
        
    output += '<?xml version="1.0" encoding="utf-8"?>';
    output += '<INAP xmlns="http://ghostdraft.korbitec.com/server/model/INAP-1.2">';
       
          
        /* Set Case Header information */      
        Case CaseDoc = [SELECT Id,Status,  CaseNumber,Defendant_Firm_Team__c,ClaimantFirm__c,Defendant_Firm_Name__c,Claimant_Firm_Team__c,Defendant_Firm__c,Claimant_Firm_Name__c, Arbitrator_Contact__c, Incident_Information__c FROM Case WHERE  Id =: GDCaseId Limit 1];
          caseSetIds.add(CaseDoc.id); 
          Caseid = CaseDoc.id; 
          Arbitratorid  = CaseDoc.Arbitrator_Contact__c ;
          IncidentId = CaseDoc.Incident_Information__c;
          ClaimantFirmId = CaseDoc.ClaimantFirm__c;
          ClaimantFirmTeamId = CaseDoc.Claimant_Firm_Team__c; 
          DefendantFirmId = CaseDoc.Defendant_Firm__c;
          DefendantFirmName = CaseDoc.Defendant_Firm_Name__c;
          DefendantFirmTeamId = CaseDoc.Defendant_Firm_Team__c;
   
    
    output +=  '<Arbitration><AgreementDate>'+FormatDatetime(system.today()) +'T00:00:00</AgreementDate>';
         output +=  '<AwardDate>'+ FormatDatetime(system.today()) +'T00:00:00</AwardDate>';


    /*Set the Arbitrator Name */
        for (Contact con: [Select id,title,firstname,lastname, Name from Contact where id =: ArbitratorId Limit 1]) {
          output += '<Arbitrator><Name><Title>Mr</Title><FirstName>'+con.firstname+'</FirstName><LastName>'+con.lastname+'</LastName></Name></Arbitrator>';
        }
   output += '</Arbitration>';
   
   
  
    
        List<Loss_Category__c>  LossCategory = new List<Loss_Category__c>([SELECT id,Rationale__c,Loss_Item_Count__c,Total_Arbitration_Award__c,AwardDocName__c,Total_Claimant_Position__c,Confirm_Case_Settlement__c,Settled_Status_Count__c,Schedule_of_Losses__c,Loss_Category_Types__c,Loss_Category_Types__r.Name FROM Loss_Category__c where Case__c =:GDCaseId]);
        List<Loss_Sub_Categories__c>  LossSubCategories = new List<Loss_Sub_Categories__c>([SELECT Id, Interest_Expense_Date__c,Interest_Rate__c,Case__r.Closed_Date__c,Arbitration_Interest__c,Interest__c,Arbitrated_by__r.FirstName,Arbitrated_by__r.LastName,Arbitrator_Rationale__c,Arbitration_Date__c,  Loss_Type__c,Loss_Category__r.Loss_Category_Types__r.Name,Arbitration_Referred_By__c,Arbitration_Accepted_Status__c,Past_Future_Financial_Item__c, Sub_Category__c,Defendant_Position__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c WHERE (Status__c = 'Arbitrated' OR Status__c = 'Settled' ) AND Loss_Category__c in:  LossCategory ]);
                
      output += '<HeadsofLoss>';
      output += '<Items>';
      
      Decimal TotalDamages=0,TotalArbitrated=0,TotalSettled=0,TotalLegalCosts=0,Merit=0;
      
       for(Loss_Category__c c:LossCategory){ 
                 output += '<Loss>'; 
                 
                 
          if(c.Confirm_Case_Settlement__c > 0 && c.Settled_Status_Count__c==0){
                   //output += '<ArbitrationAwardDate>2019-06-10T00:00:00</ArbitrationAwardDate><Arbitrator><Name><LastName>Arb Last Name 1</LastName><FirstName>Arb First Name 1</FirstName></Name></Arbitrator>';
                  /* 
                    output += '<ArbitrationAmount>'+c.Total_Arbitration_Award__c+'</ArbitrationAmount>';
                    output += '<SettlementAmount>0</SettlementAmount>';
                   */
                     
                     output += '<isarbitrated>true</isarbitrated>';
                     output += '<issettled>false</issettled>';
                     output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled>';
                  if(c.AwardDocName__c =='isforlegalcosts'){
                      TotalLegalCosts = c.Total_Arbitration_Award__c;
                  }   
                      
          } 
          else if(c.Confirm_Case_Settlement__c == 0 && c.Settled_Status_Count__c > 0){
                /*
                  output += '<ArbitrationAmount>0</ArbitrationAmount>';
                     output += '<SettlementAmount>'+c.Total_Claimant_Position__c+'</SettlementAmount>';
                */
                
                 output += '<isarbitrated>false</isarbitrated>';
                 output += '<issettled>true</issettled>';
                 output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled>'; 
                 if(c.AwardDocName__c =='isforlegalcosts'){
                      TotalLegalCosts = c.Total_Claimant_Position__c;
                  } 
          }
          else if(c.Confirm_Case_Settlement__c > 0  && c.Settled_Status_Count__c > 0){             
                  
                 output += '<isarbitrated>false</isarbitrated>';
                 output += '<issettled>false</issettled>';
                 output += '<isarbitratedandpartiallysettled>true</isarbitratedandpartiallysettled>';
                 /* 
                 output += '<ArbitrationAmount>'+c.Total_Arbitration_Award__c+'</ArbitrationAmount>';
                output += '<SettlementAmount>'+c.Total_Claimant_Position__c+'</SettlementAmount>';  
                */ 
          }
                 
            if(c.Loss_Item_Count__c==0){
                   /*
                     output += '<ArbitrationAmount>0</ArbitrationAmount>';
                    output += '<SettlementAmount>0</SettlementAmount>';
                    */
                     output += '<isarbitrated>false</isarbitrated>';
                     output += '<issettled>false</issettled>';
                     output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled>'; 
                     
                     if(c.AwardDocName__c =='isforlegalcosts'){
                          TotalLegalCosts = 0;
                     } 
            
            }     
                
                 output += '<LossTypes>'+c.AwardDocName__c+'</LossTypes>';
           /*
            if(c.Rationale__c !=null){     
                 output += '<Rationale>'+c.Rationale__c +'</Rationale>';
            }
            else{
                output += '<Rationale></Rationale>';
            }    
          */   
            Boolean NoClaim;      
             
             NoClaim = true;
            
             output += '<Sub-Losses>';
             output += '<Items>';
             for(Loss_Sub_Categories__c  l:LossSubCategories){
                            
                       if(l.Loss_Category__c == c.id){
                       
                            NoClaim = false; 
                                     
                            output += '<Sub-Loss>';
                            
                            if(l.Status__c == 'Arbitrated'){ //2019-06-10T00:00:00
//CHANGE
                                  output += '<ArbitrationAwardDate>'+FormatDatetime(l.Arbitration_Date__c) +'T00:00:00</ArbitrationAwardDate><Arbitrator><Name><LastName>'+l.Arbitrated_by__r.FirstName+'</LastName><FirstName>'+l.Arbitrated_by__r.LastName+'</FirstName></Name></Arbitrator>';
                                  output += '<isarbitrated>true</isarbitrated><isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled><issettled>false</issettled>';

                                 output += '<ArbitrationAmount>'+l.Arbitrator_Award__c+'</ArbitrationAmount>';
                                 output += '<SettlementAmount>0</SettlementAmount>';
                                 TotalArbitrated = TotalArbitrated + l.Arbitrator_Award__c;
                            }
                             else if(l.Status__c == 'Settled'){
                               output += '<isarbitrated>false</isarbitrated><isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled><issettled>true</issettled>';

                                 output += '<ArbitrationAmount>0</ArbitrationAmount>';
                                 output += '<SettlementAmount>'+l.Claimant_Position__c+'</SettlementAmount>';
                                 TotalSettled = TotalSettled+l.Claimant_Position__c;
                             }
                            output += '<Category>'+l.Loss_Type__c+'</Category>';
                            
                            if(l.Arbitrator_Rationale__c !=null){
                                output += '<Rationale>'+l.Arbitrator_Rationale__c+'</Rationale>';
                            }
                            else{
                                output += '<Rationale></Rationale>';
                            }
                            
                       //     output += '<Interest>';
                            if(l.Interest_Expense_Date__c == null){
                                output += '<hasinterest>false</hasinterest>';
                            }
                            else{
                                output += '<hasinterest>true</hasinterest>';
                                output += '<InterestRate_hasinterest>'+ l.Interest_Rate__c  +'</InterestRate_hasinterest>';
                                output += '<InterestStartDate_hasinterest>'+FormatDatetime(l.Interest_Expense_Date__c) +'T00:00:00</InterestStartDate_hasinterest>';
                                if(l.Case__r.Closed_Date__c != null){
                                    output += '<InterestEndDate_hasinterest>'+FormatDatetime(l.Case__r.Closed_Date__c) +'T00:00:00</InterestEndDate_hasinterest>';
                                }
                                else{
                                    output += '<InterestEndDate_hasinterest>'+FormatDatetime(system.today()) +'T00:00:00</InterestEndDate_hasinterest>';
                                }
                                
                                if(l.Arbitration_Interest__c>0){
                                    output += '<InterestAmount_hasinterest>'+l.Arbitration_Interest__c+'</InterestAmount_hasinterest>';
                                }
                                else{
                                    output += '<InterestAmount_hasinterest>'+l.Interest__c +'</InterestAmount_hasinterest>';
                                }
                                
                            }
                     //       output += '</Interest>';
                            
                            output += '</Sub-Loss>';
                            
                         }
  
                 }
                 output += '</Items>';
           output += '</Sub-Losses>';      
             
           
               
         
          if( NoClaim == false){       
              output += '<isnoclaim>false</isnoclaim>';  
          }
          else{
              output += '<isnoclaim>true</isnoclaim>';
          }    
        
                
        
                output += '</Loss>';        
                 
       } 
       
                output += '</Items>';
        output += '</HeadsofLoss>';
        output += '<Merits>';
        
        For (Merit__c mer : [SELECT Arbitration_Date__c,Arbitrated_by__r.FirstName,Arbitrated_by__r.LastName,Agree_to_Settle__c,Arbitrator_Rationale__c,Arbitrator_Award__c,Claimant_Position__c,CreatedDate,Defendant_Position_Max__c,Defendant_Position__c,Claimant_Rationale__c,Status__c,Submit_Claimant__c,Submit_Defendant__c FROM Merit__c 
                             where Related_Case__c =: Caseid]){
           
           


           if(mer.Status__c=='Settled'){
           output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled><issettled>true</issettled><isarbitrated>false</isarbitrated>';                  
              output += '<DefendantLiability>' + mer.Defendant_Position__c+ '</DefendantLiability>';
              Merit =  mer.Defendant_Position__c;
           }
           else if(mer.Status__c=='Arbitrated'){
 //CHANGE
               output += '<ArbitrationAwardDate>'+FormatDatetime(mer.Arbitration_Date__c) +'T00:00:00</ArbitrationAwardDate><Arbitrator><Name><LastName>'+mer.Arbitrated_by__r.LastName+'</LastName><FirstName>'+mer.Arbitrated_by__r.FirstName+'</FirstName></Name></Arbitrator>';
                                
               output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled><isarbitrated>true</isarbitrated><issettled>false</issettled>';
               output += '<DefendantLiability>' + mer.Arbitrator_Award__c+ '</DefendantLiability>';
               Merit =  mer.Arbitrator_Award__c;
           }
          if(mer.Arbitrator_Rationale__c!=Null){ 
              output += '<Rationale>' + FormatText(mer.Arbitrator_Rationale__c) +  '</Rationale>' ;
          }
          else{
              output += '<Rationale></Rationale>' ;
          }
                       
        }
        output += '</Merits>';
        
        output += '<Case><CaseIdentifier>' + CaseDoc.CaseNumber + '</CaseIdentifier>';
        
        if (CaseDoc.Status == 'Arbitrated') {        
           output += '<isarbitrated>true</isarbitrated>'; 
           output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled>';
           output += '<issettled>false</issettled>';  
            DocType='Arbitrated';        
        }
        else if(CaseDoc.Status == 'Settled'){
            DocType='Settled';
            output += '<SettlementDate>'+ FormatDatetime(system.today()) +'T00:00:00</SettlementDate>';
            output += '<isarbitrated>false</isarbitrated>'; 
            output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled>';
            output += '<issettled>true</issettled>';  
        }
        else if(CaseDoc.Status == 'Partial Settlement'){
            output += '<isarbitrated>false</isarbitrated>'; 
            output += '<isarbitratedandpartiallysettled>true</isarbitratedandpartiallysettled>';
            output += '<issettled>false</issettled>';
            DocType='Partial';  
        }
               
    
        
        For (Incident_Information__c Inc : [SELECT City__c,Country__c,CreatedDate,Description__c,Incident_Date__c FROM Incident_Information__c where id =: IncidentId]){
          output += '<AccidentDate>' + FormatDatetime(Inc.Incident_Date__c) +'T00:00:00</AccidentDate>';
          
        }
         TotalDamages=(TotalArbitrated+TotalSettled-TotalLegalCosts)*(Merit/100);// +TotalLegalCosts;
         output += '<Costs><Value>'+TotalLegalCosts+'</Value>';
    
     //TotalLegalCosts;
    //TotalDamages=TotalArbitrated+TotalSettled; 
    output +='<paymentisfortherespondent>true</paymentisfortherespondent></Costs>';
    output +='<TotalDamages>'+TotalDamages+'</TotalDamages>';
    output +='</Case>';
        
    output += GetNoticeofCommencementTeamXML( caseid, 'Claimant' , ClaimantFirmId, ClaimantFirmTeamId );
     output += GetNoticeofCommencementTeamXML( caseid, 'Defendant' , DefendantFirmId, DefendantFirmTeamId );          
        output += '</INAP>';
        
        
                
        GhostDraftlog__c GD = new GhostDraftlog__c();
        GD.XML__c = output;
        GD.Case__c = CaseId;
        GDNewLog.add(GD);
                
        if (GDNewLog.size() > 0){
           // Insert GDNewLog; 
                      
        }
        
        Map<String,String> Map_TypeBody = new Map<String,String>();
        
        Map_TypeBody.put(DocType,output);
               
        return Map_TypeBody;
 }
 
 
 
 public static Map<String,String> GetARBITRALXML_Interim(String GDCaseId) {

        String DocType;
        
        Id UserId = UserInfo.getUserId();
        
        String output = '';
        Set<Id> caseSetIds = new Set<Id>();
        String CaseId = ''; 
        Set<id> HeadofLossSetIds = new Set<id>();
        Integer HoLCount = 0;
        String ArbitratorId = '';
        String IncidentId = '';
        String HeadofLossId = '';
        String Rationale = '';
        
        String ClaimantFirmId = '';
     String ClaimantFirmTeamId = '';
     String ClaimantFirmName = '';
     String DefendantFirmId = '';
     String DefendantFirmTeamId = '';
     String DefendantFirmName = '';
        
        
        Map<String, String> lscMap = new Map<String, String>();
        Map<Id, Loss_Category__c > HeadofLossMap = new Map<Id, Loss_Category__c >();
        List<Case> caseupdate = new List<Case>();
        List<GhostDraftLog__c> GDNewLog = new List<GhostDraftLog__c>();

        String CurrentHeadofLossId = '';
     
        
        
        
    output += '<?xml version="1.0" encoding="utf-8"?>';
    output += '<INAP xmlns="http://ghostdraft.korbitec.com/server/model/INAP-1.2">';
       
          
        /* Set Case Header information */      
        Case CaseDoc = [SELECT Id,Status,  CaseNumber,Defendant_Firm_Team__c,ClaimantFirm__c,Defendant_Firm_Name__c,Claimant_Firm_Team__c,Defendant_Firm__c,Claimant_Firm_Name__c, Arbitrator_Contact__c, Incident_Information__c FROM Case WHERE  Id =: GDCaseId Limit 1];
          caseSetIds.add(CaseDoc.id); 
          Caseid = CaseDoc.id; 
          Arbitratorid  = CaseDoc.Arbitrator_Contact__c ;
          IncidentId = CaseDoc.Incident_Information__c;
          ClaimantFirmId = CaseDoc.ClaimantFirm__c;
          ClaimantFirmTeamId = CaseDoc.Claimant_Firm_Team__c; 
          DefendantFirmId = CaseDoc.Defendant_Firm__c;
          DefendantFirmName = CaseDoc.Defendant_Firm_Name__c;
          DefendantFirmTeamId = CaseDoc.Defendant_Firm_Team__c;
   
    
    output +=  '<Arbitration><AgreementDate>'+FormatDatetime(system.today()) +'T00:00:00</AgreementDate>';
         output +=  '<AwardDate>'+ FormatDatetime(system.today()) +'T00:00:00</AwardDate>';


    /*Set the Arbitrator Name */
        for (Contact con: [Select id,title,firstname,lastname, Name from Contact where id =: ArbitratorId Limit 1]) {
          output += '<Arbitrator><Name><Title>Mr</Title><FirstName>'+con.firstname+'</FirstName><LastName>'+con.lastname+'</LastName></Name></Arbitrator>';
        }
   output += '</Arbitration>';
   
 
      Date todaydate=System.Today();
    
        List<Loss_Category__c>  LossCategory = new List<Loss_Category__c>([SELECT id,Rationale__c,Loss_Item_Count__c,Total_Arbitration_Award__c,AwardDocName__c,Total_Claimant_Position__c,Confirm_Case_Settlement__c,Settled_Status_Count__c,Schedule_of_Losses__c,Loss_Category_Types__c,Loss_Category_Types__r.Name FROM Loss_Category__c where Case__c =:GDCaseId]);
        List<Loss_Sub_Categories__c>  LossSubCategories = new List<Loss_Sub_Categories__c>([SELECT Id,Interest_Expense_Date__c,Case__r.Closed_Date__c,Interest_Rate__c,Case__r.ClosedDate,Arbitration_Interest__c,Interest__c,Arbitrated_by__r.FirstName,Arbitrated_by__r.LastName,Arbitrator_Rationale__c,Arbitration_Date__c,Arbitrated_by__c,  Loss_Type__c,Loss_Category__r.Loss_Category_Types__r.Name,Arbitration_Referred_By__c,Arbitration_Accepted_Status__c,Past_Future_Financial_Item__c, Sub_Category__c,Defendant_Position__c,Loss_Category__c,Sum_Defendent_Position__c,Stage__c,Status__c,Claimant_Position__c,Arbitrator_Award__c,Name,Past_Future_Financial_Losses__r.Name,RecordType.DeveloperName FROM Loss_Sub_Categories__c WHERE (Status__c = 'Arbitrated') AND Loss_Category__c in:  LossCategory ]);
            
      system.Debug('**LossSubCategories***'+LossSubCategories);          
      output += '<HeadsofLoss>';
      output += '<Items>';
      
      Decimal TotalDamages=0,TotalArbitrated=0,TotalSettled=0,TotalLegalCosts=0,Merit=0;
      
      Decimal ArbitrationCategoryTotal=0;
      
       for(Loss_Category__c c:LossCategory){ 
                 output += '<Loss>'; 
                 
                
           output += '<LossTypes>'+c.AwardDocName__c+'</LossTypes>';
         /*
            if(c.Rationale__c !=null){     
                 output += '<Rationale>'+c.Rationale__c +'</Rationale>';
            }
            else{
                output += '<Rationale></Rationale>';
            }
         */        
            Boolean NoClaim;      
             
             NoClaim = true;
            
             output += '<Sub-Losses>';
             output += '<Items>';
             for(Loss_Sub_Categories__c  l:LossSubCategories){
                      
                      system.Debug('**UserId***'+UserId+'**Arbitrated_by***'+l.Arbitrated_by__c+'**Arbitration_Date***'+l.Arbitration_Date__c+'**Today***'+System.Today());
                   if(UserId ==l.Arbitrated_by__c &&  l.Arbitration_Date__c>=System.Today() )  {       
                       if(l.Loss_Category__c == c.id){
                       
                            NoClaim = false; 
                                     
                            output += '<Sub-Loss>';
                            
                            if(l.Status__c == 'Arbitrated'){
 //CHANGE
                                 output += '<isarbitrated>true</isarbitrated>';
                     output += '<issettled>false</issettled>';
                     output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled>';
                                 output += '<ArbitrationAwardDate>'+FormatDatetime(l.Arbitration_Date__c) +'T00:00:00</ArbitrationAwardDate><Arbitrator><Name><LastName>'+l.Arbitrated_by__r.FirstName+'</LastName><FirstName>'+l.Arbitrated_by__r.LastName+'</FirstName></Name></Arbitrator>';
                                  
                                 output += '<ArbitrationAmount>'+l.Arbitrator_Award__c+'</ArbitrationAmount>';
                                 output += '<SettlementAmount>0</SettlementAmount>';
                                 TotalArbitrated = TotalArbitrated + l.Arbitrator_Award__c;
                                 ArbitrationCategoryTotal = ArbitrationCategoryTotal + l.Arbitrator_Award__c; 
                            }
                             else if(l.Status__c == 'Settled'){
   
                                 output += '<ArbitrationAmount>0</ArbitrationAmount>';
                                 output += '<SettlementAmount>'+l.Claimant_Position__c+'</SettlementAmount>';
                                 TotalSettled = TotalSettled+l.Claimant_Position__c;
                             }
                            output += '<Category>'+l.Loss_Type__c+'</Category>';
                            
                           
                            if(l.Arbitrator_Rationale__c !=null){
                                output += '<Rationale>'+l.Arbitrator_Rationale__c+'</Rationale>';
                            }
                            else{
                                output += '<Rationale></Rationale>';
                            }
                            
                           // output += '<Interest>';
                           if(l.Interest_Expense_Date__c == null){
                                output += '<hasinterest>false</hasinterest>';
                            }
                            else{
                                output += '<hasinterest>true</hasinterest>';
                                output += '<InterestRate_hasinterest>'+ l.Interest_Rate__c  +'</InterestRate_hasinterest>';
                                output += '<InterestStartDate_hasinterest>'+FormatDatetime(l.Interest_Expense_Date__c) +'T00:00:00</InterestStartDate_hasinterest>';
                                if(l.Case__r.Closed_Date__c != null){
                                    output += '<InterestEndDate_hasinterest>'+FormatDatetime(l.Case__r.Closed_Date__c) +'T00:00:00</InterestEndDate_hasinterest>';
                                }
                                else{
                                    output += '<InterestEndDate_hasinterest>'+FormatDatetime(system.today()) +'T00:00:00</InterestEndDate_hasinterest>';
                                }
                                
                                if(l.Arbitration_Interest__c>0){
                                    output += '<InterestAmount_hasinterest>'+l.Arbitration_Interest__c+'</InterestAmount_hasinterest>';
                                }
                                else{
                                    output += '<InterestAmount_hasinterest>'+l.Interest__c +'</InterestAmount_hasinterest>';
                                }
                                
                            }
                        //    output += '</Interest>';
                            output += '</Sub-Loss>';
                            
                         }
                     } 
                 }
                 output += '</Items>';
           output += '</Sub-Losses>';      
             
           if(c.Confirm_Case_Settlement__c > 0 && c.Settled_Status_Count__c==0){
                   /* 
                    output += '<ArbitrationAmount>'+ArbitrationCategoryTotal+'</ArbitrationAmount>';
                    output += '<SettlementAmount>0</SettlementAmount>';
                     */
                    /* 
                     output += '<isarbitrated>true</isarbitrated>';
                     output += '<issettled>false</issettled>';
                     output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled>';
                    */
                     
                  if(c.AwardDocName__c =='isforlegalcosts'){
                      TotalLegalCosts = c.Total_Arbitration_Award__c;
                  }   
                      
          } 
          else if(c.Confirm_Case_Settlement__c == 0 && c.Settled_Status_Count__c > 0){
                /* 
                  output += '<ArbitrationAmount>0</ArbitrationAmount>';
                     output += '<SettlementAmount>'+c.Total_Claimant_Position__c+'</SettlementAmount>';
                 */
                  /*   
                 output += '<isarbitrated>false</isarbitrated>';
                 output += '<issettled>true</issettled>';
                 output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled>';
                 */
                  
                 if(c.AwardDocName__c =='isforlegalcosts'){
                      TotalLegalCosts = c.Total_Claimant_Position__c;
                  } 
          }
          else if(c.Confirm_Case_Settlement__c > 0  && c.Settled_Status_Count__c > 0){             
                /*
                 output += '<isarbitrated>false</isarbitrated>';
                 output += '<issettled>false</issettled>';
                */
                /*
                 output += '<isarbitratedandpartiallysettled>true</isarbitratedandpartiallysettled>'; 
                 output += '<ArbitrationAmount>'+c.Total_Arbitration_Award__c+'</ArbitrationAmount>';
                output += '<SettlementAmount>'+c.Total_Claimant_Position__c+'</SettlementAmount>'; 
                */  
          }
                 
            if(c.Loss_Item_Count__c==0){
            /*
                     output += '<ArbitrationAmount>0</ArbitrationAmount>';
                    output += '<SettlementAmount>0</SettlementAmount>';
                 */
                    
                     output += '<isarbitrated>false</isarbitrated>';
                     output += '<issettled>false</issettled>';
                     output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled>'; 
                     
                     if(c.AwardDocName__c =='isforlegalcosts'){
                          TotalLegalCosts = 0;
                     } 
            
            }     
               
         
          if( NoClaim == false){       
              output += '<isnoclaim>false</isnoclaim>';  
          }
          else{
              output += '<isnoclaim>true</isnoclaim>';
          }    
        
        output += '</Loss>';        
                 
       } 
       
                output += '</Items>';
        output += '</HeadsofLoss>';
        output += '<Merits>';
        
        For (Merit__c mer : [SELECT Agree_to_Settle__c,Arbitration_Date__c,Arbitrator_Rationale__c,Arbitrator_Award__c,Claimant_Position__c,Arbitrated_by__r.LastName,Arbitrated_by__r.FirstName,CreatedDate,Defendant_Position_Max__c,Defendant_Position__c,Claimant_Rationale__c,Status__c,Submit_Claimant__c,Submit_Defendant__c FROM Merit__c 
                             where Related_Case__c =: Caseid ]){
           if(mer.Status__c=='Settled'){                  
              output += '<DefendantLiability>' + mer.Defendant_Position__c+ '</DefendantLiability>';
               output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled><issettled>true</issettled><isarbitrated>false</isarbitrated>';                  
          
              Merit =  mer.Defendant_Position__c;
           }
           else if(mer.Status__c=='Arbitrated'){
 //CHANGE AND Arbitrated_by__c=: UserId AND Arbitration_Date__c>=:todaydate
               //output += '<ArbitrationAwardDate>2019-06-10T00:00:00</ArbitrationAwardDate><Arbitrator><Name><LastName>Arb Last Name 1</LastName><FirstName>Arb First Name 1</FirstName></Name></Arbitrator>';
               output += '<ArbitrationAwardDate>'+FormatDatetime(mer.Arbitration_Date__c) +'T00:00:00</ArbitrationAwardDate><Arbitrator><Name><LastName>'+mer.Arbitrated_by__r.LastName+'</LastName><FirstName>'+mer.Arbitrated_by__r.FirstName+'</FirstName></Name></Arbitrator>';
               
               output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled><issettled>false</issettled><isarbitrated>true</isarbitrated>';                  
          
               output += '<DefendantLiability>' + mer.Arbitrator_Award__c+ '</DefendantLiability>';
               Merit =  mer.Arbitrator_Award__c;
           }
           else{                  
              output += '<DefendantLiability>0</DefendantLiability>';
               output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled><issettled>false</issettled><isarbitrated>false</isarbitrated>';                  
          
              Merit =   mer.Claimant_Position__c; 
           }
          if(mer.Arbitrator_Rationale__c!=Null){ 
              output += '<Rationale>' + FormatText(mer.Arbitrator_Rationale__c) +  '</Rationale>' ;
          }
          else{
              output += '<Rationale></Rationale>' ;
          }
                       
        }
        output += '</Merits>';
        
        output += '<Case><CaseIdentifier>' + CaseDoc.CaseNumber + '</CaseIdentifier>';
        
             
           output += '<isarbitrated>false</isarbitrated>'; 
           output += '<isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled>';
           output += '<issettled>false</issettled>';  
            DocType='Interim';        
         
             
        
        
        
        For (Incident_Information__c Inc : [SELECT City__c,Country__c,CreatedDate,Description__c,Incident_Date__c FROM Incident_Information__c where id =: IncidentId]){
          output += '<AccidentDate>' + FormatDatetime(Inc.Incident_Date__c) +'T00:00:00</AccidentDate>';
          
        }
         TotalDamages= (TotalArbitrated+TotalSettled-TotalLegalCosts)*(Merit/100);// +TotalLegalCosts;
         output += '<Costs><Value>'+TotalLegalCosts+'</Value>';
    
     //TotalLegalCosts;
    //TotalDamages=TotalArbitrated+TotalSettled; 
    output +='<paymentisfortherespondent>true</paymentisfortherespondent></Costs>';
    output +='<TotalDamages>'+TotalDamages+'</TotalDamages>';
    output +='</Case>';
        
     output += GetNoticeofCommencementTeamXML( caseid, 'Claimant' , ClaimantFirmId, ClaimantFirmTeamId );
     output += GetNoticeofCommencementTeamXML( caseid, 'Defendant' , DefendantFirmId, DefendantFirmTeamId );          
        output += '</INAP>';
        
        
                
        GhostDraftlog__c GD = new GhostDraftlog__c();
        GD.XML__c = output;
        GD.Case__c = CaseId;
        GDNewLog.add(GD);
                
        if (GDNewLog.size() > 0){
           // Insert GDNewLog; 
                      
        }
        
        Map<String,String> Map_TypeBody = new Map<String,String>();
        
        Map_TypeBody.put(DocType,output);
               
        return Map_TypeBody;
 } 
  
 
 
 
 
 



}