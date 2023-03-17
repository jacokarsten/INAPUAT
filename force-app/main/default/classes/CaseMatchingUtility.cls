Public Class CaseMatchingUtility{
@InvocableMethod


  Public static void ProcessImportedData (List<Id> ids){
  
      Map <Id, String> CaseProtocolMap = new Map<id, String>();
      Map<id, String> CaseCRMap = new Map<id, String>();
      Map<id, String> CaseDRMap = new Map<id, String>();
      Map<id, String> CaseCRTeamMap = new Map<id, String>();
      Map<id, Date> CaseIncidentDate = new Map<id, Date>();
      Map<id, String> CaseIncidentPostCode = new Map<id,String>();
      Map<String,id> CaseIncidentDatePostCodeMap = new Map<String, id>();
      Map<Id, id> CaseIncidentMap = New Map<Id, Id>() ; 
      Map <String, Id> ProtocolMap = new Map<String, Id>();
      Map <String, Id> CRMap = new Map<String, Id>();
      Map <String, Id> FirmMap = new Map<String, Id>();
      Map <String, Id> FirmTeamMap = new Map<String, Id>();
      Map <String, String > Firm2TeamMap = new Map<String,String>();
      Set<String> CaseProtocolSet = new Set<String>();
      Set<String> CaseCRSet = new Set<String>();
      Set<Date> dtIncidentDateSet = new Set<Date>();
      Set<String> IncidentPostCodeSet = new Set <String>();
      Set<String> IncidentPostCode = new Set<String>();
      Set<String> IncidentDatePostCode = new Set<String>(); 
      Set<id> FirmSet = new Set<Id>();
      
     /* SELECT Firm__c, id, name FROM Firm_Team__c*/
         
      String Recordid = '';
      List<Case_Staging_Table__c> CaseStagingtoUpdate = new  List<Case_Staging_Table__c>();
      String ImportErrors = '';
      Date dtIncidentDate = null;
           
      For (Protocol__c p:  [SELECT id, Code__c FROM Protocol__c ]){
          ProtocolMap.put(p.Code__c, p.Id);  
      }
       For (Account a:  [SELECT id, Name,FirmID__c FROM Account ]){
          FirmMap.put(a.FirmID__c, a.Id); 
          //FirmMap.put(a.FIRM_ID__C, a.Id);  
        //  System.Debug('## FirmMap.put ' + a.FIRM_ID__C + ' ' + a.id +' ##');
         /* FirmSet.Add ( a.Id);*/
      }
       For (Firm_Team__c ft:  [SELECT id, Name, Firm__c FROM Firm_Team__c  ]){
          FirmTeamMap.put(ft.Name, ft.Id);       
          System.Debug('## FirmTeamMap.put ' + ft.Name + ' ' + ft.id +' ##');
          
          Firm2TeamMap.put(ft.Name + '_' + ft.firm__c, ft.id );
          System.Debug('#$$# Firm2TeamMap.put ' + ft.Name + '_' +  ft.firm__c +' #$$#'); 
      }
        
       
      For (Case_Staging_Table__c cst : [SELECT Case_Number__c,Case_Source__c,Claimant_Firm_ID__c, Defendant_Firm_ID__c,Protocol_Code__c,
                         Incident_Date__c,
                         Incident_Post_Code__c,Incident_Post_Code_Shorten__c,Address_Line_1__c, Address_Line_2__c,
                                        Mapped_Protocol__c, Mapped_Defendant_Firm__c,   Mapped_Incident__c, Mapped_Status__c, Import_Key__c,
                                        Firm_Team__c, Claimant_Reference_Number__c,Merit_Claimant_Position__c, Mapped_Firm_Team__c 
                                        FROM Case_Staging_Table__c where Id in : ids]){
           CaseStagingtoUpdate.add (cst);
                                         
           if( !CaseProtocolSet.contains(cst.Protocol_Code__c)){                
               CaseProtocolSet.add(cst.Protocol_Code__c) ;
           }
                  
           if (cst.Import_Key__c !=null)  {
             if ( !IncidentDatePostCode.contains(cst.Import_Key__c )){
                 IncidentDatePostCode.add(cst.Import_Key__c); 
             }
           }                        
                                             
           CaseProtocolMap.put(cst.id, cst.Protocol_Code__c); 
           CaseCRMap.put(cst.id, cst.Claimant_Firm_ID__c);
           System.Debug('## CaseCRMap.put ' + cst.id + ' ' + cst.Claimant_Firm_ID__c + ' ##');
           CaseCRTeamMap.put(cst.id, cst.Firm_Team__c);
           System.Debug('## CaseCRTeamMap.put ' + cst.id + ' ' + cst.Firm_Team__c + ' ##');
           CaseDRMap.put(cst.id, cst.Defendant_Firm_ID__c); 
           CaseIncidentDatePostCodeMap.put(cst.Import_Key__c, cst.id);  
           System.Debug('#$# CaseIncidentDatePostCodeMap ' + cst.Import_Key__c + ' ' + cst.id + ' ##');                                                                                  
      }
      
      /* Check to see if the Incident exists based on Incident Date and Incident Post Code*/
      For (Incident_Information__c inc : [Select id ,Incident_Key__c from Incident_Information__c  where  Incident_Key__c in : IncidentDatePostCode  ]){
            System.Debug('#$$# Incident ID to Date Post Code Map ' +   inc.id + ' ' + inc.Incident_Key__c  + ' ###'); 
            String CaseStageid =  CaseIncidentDatePostCodeMap.get(inc.Incident_Key__c);
            CaseIncidentMap.put(CaseStageid, inc.Id);                                                                
      }
      
    
    
      
      For (Case_Staging_Table__c cst1 : CaseStagingtoUpdate ){
          String cstid = cst1.id;
          System.Debug('## cstid ' + cstid + ' ##');
          System.Debug('## CaseProtocolMap.get ' + CaseProtocolMap.get(cst1.id) + ' ##');
          System.Debug('## CaseProtocolMap.get 2 ' + ProtocolMap.get(CaseProtocolMap.get(cst1.id)) + ' ##');
          
          System.Debug('## CaseCRMap.get ' + CaseCRMap.get(cst1.id) + ' ##');
          System.Debug('## CaseCRMap.get 2 ' + FirmMap.get(CaseCRMap.get(cst1.id)) + ' ##');
        
          
          If (CaseProtocolMap.get(cst1.id) != null){
              cst1.Mapped_Protocol__c = ProtocolMap.get(CaseProtocolMap.get(cst1.id)); 
          }
          If (CaseCRMap.get(cst1.id) != null){
              cst1.Mapped_Claimant_Firm__c = FirmMap.get(CaseCRMap.get(cst1.id)); 
          }      
          If (CaseCRTeamMap.get(cst1.id) != null){
              String Firm2Team = CaseCRTeamMap.get(cst1.id) + '_' + cst1.Mapped_Claimant_Firm__c ;
            /*  cst1.Mapped_Firm_Team__c = FirmTeamMap.get(CaseCRTeamMap.get(cst1.id));*/
             System.Debug('#$$$# Firm2Team output ' + Firm2Team + '#$$$#');
            
              cst1.Mapped_Firm_Team__c  = Firm2TeamMap.get (Firm2Team ); 
          }
          If (CaseDRMap.get(cst1.id) != null){
              cst1.Mapped_Defendant_Firm__c = FirmMap.get(CaseDRMap.get(cst1.id)); 
          }
          If (CaseIncidentMap.get(cst1.id) != null){
              cst1.Mapped_Incident__c = CaseIncidentMap.get(cst1.id); 
          }
          
          
          /* Check if mapping is successfully or not */
          if (cst1.Mapped_Protocol__c != null  && cst1.Mapped_Firm_Team__c !=null && cst1.Mapped_Claimant_Firm__c != null  && cst1.Mapped_Defendant_Firm__c != null &&  cst1.Mapped_Incident__c == null ){
             cst1.Mapped_Status__c = 'Accepted'; 
          }
          else{
             cst1.Mapped_Status__c = 'Rejected';
             String MappingError = ''; 
             if (cst1.Mapped_Protocol__c == null) {
                MappingError  += 'Protocol not found' + '\n';
             }
             if (cst1.Mapped_Claimant_Firm__c == null) {
                MappingError  += 'Claimant not found'+ '\n';
             }
             if (cst1.Mapped_Firm_Team__c == null) {
                MappingError  += 'Claimant Firm Team not found'+ '\n';
             }
             if (cst1.Mapped_Defendant_Firm__c == null) {
                MappingError  += 'Defendant not found'+ '\n';
             }
             if (cst1.Mapped_Incident__c != null) {
                MappingError  += 'Existing Incident found'+ '\n';
             }
             cst1.Mapped_Status_Detail__c = Mappingerror;
          }
             
      }
      
      If (CaseStagingtoUpdate.IsEmpty() != null){
         update CaseStagingtoUpdate;
      }
      
  }
  
  
 
                                        
     
   /*
   List<Opportunity> oppLst = [Select o.CreatedDate, o.Id from Opportunity o where   o.CreatedDate >: myDate and o.CreatedDate <:  myDate2 order by  o.LastModifiedDate] ;
   */
  
}