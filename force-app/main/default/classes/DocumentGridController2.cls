public class DocumentGridController2 {

    @AuraEnabled
    public static List<ContentVersion> getFiles(String caseID) {
        
        
        String LOGGEDINUSER = UserAccessRights.ProfileName(caseID);
        
        ContentDocumentLink[] DocumentLink = [SELECT LinkedEntityId,ContentDocumentId FROM ContentDocumentLink where LinkedEntityId =:caseID  ];      

        Set<String> set_docId = new Set<String>();
         for(ContentDocumentLink doc:DocumentLink){
             set_docId.add(doc.ContentDocumentId);    
         }
        
        
        
        List<ContentVersion> files = [SELECT Id,
                                      Case_Id__c,
                                      Case__r.Status,
                                      ContentDocumentId,
                                      Sharing_Permissions__c,
                                      INAP_Doc_Type__c,
                                      CreatedbyId,
                                      Title,
                                      ContentModifiedDate,
                                      Uploaded_By__c
                                      FROM ContentVersion
                                      WHERE ContentDocumentId in:set_docId];
        
        system.debug('******'+ files);
        
        List<ContentVersion> FilteredFiles = new List<ContentVersion>();
        
        for (ContentVersion fFiles: files) {
             if (fFiles.Sharing_Permissions__c == 'Private' && fFiles.Uploaded_By__c == LOGGEDINUSER && fFiles.Uploaded_By__c == 'Claimant Handler' ){
                FilteredFiles.add(fFiles);
            }
            else if (fFiles.Sharing_Permissions__c == 'Private' && fFiles.Uploaded_By__c == LOGGEDINUSER && fFiles.Uploaded_By__c == 'Defendant Handler') {
                FilteredFiles.add(fFiles);
            }
            else if (fFiles.Sharing_Permissions__c == 'Shared' && LOGGEDINUSER != 'Arbitrator') {
               FilteredFiles.add(fFiles);
            }
            else if (fFiles.CreatedbyId == userInfo.getUserId() && LOGGEDINUSER == 'Arbitrator') {
               FilteredFiles.add(fFiles);
            }
        }
        
        
        return FilteredFiles;
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