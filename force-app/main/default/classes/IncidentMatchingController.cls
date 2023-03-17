public without sharing class IncidentMatchingController {

    @AuraEnabled
    public static List<IncidentsWrapper> getIncidents(String postalCodeInput, Date incidentDateInput, String firmIdInput){
        User[] ContactUser =[Select id,ContactId From user where id=:UserInfo.getUserId()];
        Contact[] lstContact = [Select id,Active_Case_on_Individual_Count__c,AccountId,Name From Contact where id =:ContactUser[0].ContactId];
        Contact[] GetAllContacts = [Select id,AccountId from Contact where AccountId=:lstContact[0].AccountId];
        Set<String> Set_ContactId = new Set<String>();
        for(Contact con:GetAllContacts){
            Set_ContactId.add(con.id);
        }
        User[] AllUsers =[Select id, ContactId From user where ContactId in: Set_ContactId];
        
        
        List<Incident_Information__c> matchingIncidents = [SELECT Id, State_County__c, Postal_Code__c, Address_Line_1__c, City2__c, Country__c,  Incident_Matching_Date__c , Incident_Date__c, OwnerId, Description__c, Name from Incident_Information__c where OwnerId in:AllUsers and Postal_Code__c =: postalCodeInput and Incident_Matching_Date__c =: incidentDateInput];
        List<Case> relatedCases = [SELECT Id, Incident_Information__c, Defendant_Firm__r.Name, Claimant_Information__r.Claimant_First_Name__c, Claimant_Information__r.Claimant_Last_Name__c, CaseNumber, Protocol__r.Code__c, Type, Status, Claimant_Name__c from Case where Incident_Information__c =: matchingIncidents];
        List<Claimant_Information__c> cl = [SELECT Id, Case__c, Claimant_First_Name__c, Claimant_Last_Name__c FROM Claimant_Information__c WHERE Case__c =: relatedCases];
        List<Defendant_Information__c> def = [SELECT Id, Case__c, Company_Employer_Name__c, Defendant_First_Name__c, Defendant_Last_Name__c FROM Defendant_Information__c WHERE Case__c =: relatedCases];
        
        List<IncidentsWrapper> incidentsList = new List<IncidentsWrapper>();
        for(Incident_Information__c incident : matchingIncidents){
            IncidentsWrapper incWrapper = new IncidentsWrapper();
            incWrapper.Name = incident.Name ;
            incWrapper.incidentId = incident.Id;
            incWrapper.PostalCode = incident.Postal_Code__c ;
            incWrapper.IncidentDate = incident.Incident_Date__c;
            incWrapper.AddressLine1 = incident.Address_Line_1__c;
            incWrapper.City = incident.City2__c;
            incWrapper.County = incident.State_County__c;
            incWrapper.Country = incident.Country__c;
            incWrapper.Description = incident.Description__c;
            List<Items> co = new List<Items>();
            for(Case caseList : relatedCases){
                if (caseList.Incident_Information__c == incident.Id) {
                    Items caseWrap = new Items();
                    caseWrap.Status = caseList.Status;
                    caseWrap.Name = caseList.CaseNumber;
                    caseWrap.CaseNumber = caseList.CaseNumber;
                    caseWrap.IncidentId = caseList.Incident_Information__c;
                    caseWrap.caseId = caseList.Id;
                    caseWrap.DefendantFirm =  caseList.Defendant_Firm__r.Name;
                    caseWrap.CaseType =  caseList.Type;
                    caseWrap.CaseProtocol = caseList.Protocol__r.Code__c;
                    
                    for(Claimant_Information__c claimant : cl){
                        if(claimant.Case__c == caseList.Id) {
                            caseWrap.ClaimantFirstName = claimant.Claimant_First_Name__c ;
                            caseWrap.ClaimantLastName = claimant.Claimant_Last_Name__c ;
                        }
                    }
                    
                    for(Defendant_Information__c defendant : def){
                        if(defendant.Case__c == caseList.Id) {
                            if (defendant.Defendant_First_Name__c != null ) {
                                caseWrap.DefendantName = defendant.Defendant_First_Name__c+ ' ' +defendant.Defendant_Last_Name__c ;}
                            else if (defendant.Defendant_First_Name__c == null ){
                                caseWrap.DefendantName = defendant.Company_Employer_Name__c;
                            }
                        }
                    }
                    
                    co.add(caseWrap); 
                    
                }
                incWrapper.items = co;
                
            }
            incidentsList.add(incWrapper);
        }
        System.debug('*****'+JSON.serializePretty(incidentsList));
        // return JSON.serializePretty(incidentsList);  
        return incidentsList;
    }
    
    
    
    public Class IncidentsWrapper{
        @AuraEnabled
        public String Name {get; set;}
        @AuraEnabled
        public String PostalCode {get; set;}
        @AuraEnabled
        public Datetime IncidentDate {get; set;}
        @AuraEnabled
        public String incidentId {get; set;}
        @AuraEnabled
        public String AddressLine1 {get; set;}
        @AuraEnabled
        public String Description {get; set;}
        @AuraEnabled
        public String City {get; set;}
        @AuraEnabled
        public String County {get; set;}
        @AuraEnabled
        public String Country {get; set;}
        @AuraEnabled
        public List<Items> items{get; set;}
    }
    public Class Items{
        @AuraEnabled
        public String Name {get; set;}
        @AuraEnabled
        public String CaseNumber {get; set;}
        @AuraEnabled
        public String Status {get; set;}
        @AuraEnabled
        public Id incidentId {get; set;}
        @AuraEnabled
        public Id caseId {get; set;}
        @AuraEnabled
        public String DefendantFirm {get; set;}
        @AuraEnabled
        public String ClaimantFirstName {get; set;}
        @AuraEnabled
        public String ClaimantLastName {get; set;}
        @AuraEnabled
        public String DefendantName {get; set;}
        @AuraEnabled
        public String DefendantLastName {get; set;}
        @AuraEnabled
        public String DefendantCompany {get; set;}
        @AuraEnabled
        public String CaseType {get; set;}
        @AuraEnabled
        public String CaseProtocol {get; set;}
        
    }
    
    
}