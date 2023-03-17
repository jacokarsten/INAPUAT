public class FileListViewController {
    
    // method for fetch documents list  
    @AuraEnabled
    public static List < ContentVersion > getFiles(String caseID) {
        
        List < ContentVersion > returnList = new List < ContentVersion > ();
        List < ContentVersion > lstOfFiles = [SELECT Id,
                                              Case_Id__c,
                                              Case__r.Status,
                                              ContentDocumentId,
                                              Sharing_Permissions__c,
                                              INAP_Doc_Type__c,
                                              Title,
                                              ContentModifiedDate,
                                              Uploaded_By__c
                                              FROM ContentVersion
                                              WHERE Case_Id__c =: caseID 
                                              AND Uploaded__c = false];
        
        for (ContentVersion file: lstOfFiles) {
            returnList.add(file);
        }
        return returnList;
    }
    
    // method for update records after inline editing  
    @AuraEnabled
    public static List < ContentVersion > saveContentVersion(List<ContentVersion> lstContentVersion) {
       
        update lstContentVersion;
        return lstContentVersion;
    }
    
    // method for fetch picklist values dynamic  
    @AuraEnabled
    public static List < String > getselectOptions(sObject objObject, string fld) {
        system.debug('objObject --->' + objObject);
        system.debug('fld --->' + fld);
        List < String > allOpts = new list < String > ();
        // Get the object type of the SObject.
        Schema.sObjectType objType = objObject.getSObjectType();
        
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values =
            fieldMap.get(fld).getDescribe().getPickListValues();
        
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        system.debug('allOpts ---->' + allOpts);
        allOpts.sort();
        return allOpts;
    }
    
    
}