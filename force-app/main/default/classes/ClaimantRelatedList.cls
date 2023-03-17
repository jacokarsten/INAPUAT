public class ClaimantRelatedList {
    
    @AuraEnabled
    public static List<Claimant_Information__c> getClaimantInfo(String caseId) {
        
        List<Claimant_Information__c> claimantInfo = [SELECT Id, 
                                                      Name,
                                                      Case__c,
                                                      Case__r.Status,
                                                      Claimant_First_Name__c,
                                                      Claimant_Last_Name__c,
                                                      Editable__c,
                                                      Claimant_Vehicle_Registration_Number__c,
                                                      Claimant_Date_of_Birth__c
                                                      FROM Claimant_Information__c
                                                      WHERE Case__c =: caseId];
        
        return claimantInfo;
    }
}