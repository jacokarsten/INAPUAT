public class DefendantRelatedList {

    @AuraEnabled
    public static List<Defendant_Information__c> getDefendantInfo(String caseId) {
        
        List<Defendant_Information__c> defendantInfo = [SELECT Id, 
                                                        Name,
                                                        Case__c ,
                                                        Company_Employer_Name__c ,
                                                        Contact_First_Name__c,
                                                        Contact_Last_Name__c,
                                                        Defendant_Date_of_Birth__c,
                                                        Defendant_First_Name__c,
                                                        Defendant_Last_Name__c,
                                                        Editable__c,
                                                        Defendant_Vehicle_Registration_Number__c,
                                                        Case__r.Status
                                                        FROM Defendant_Information__c
                                                        WHERE Case__c =: caseId];
        
        return defendantInfo;
    }
    
}