public class DocumentGridController3 {
    
    @AuraEnabled
    public static List<ContentVersion> getFiles(String caseID) {
        User[] ContactUser =[Select id,ContactId From user where id=:UserInfo.getUserId()];
        Contact[] lstContact = [Select id,Active_Case_on_Individual_Count__c,AccountId,Name From Contact where id =:ContactUser[0].ContactId];
        Contact[] GetAllContacts = [Select id,AccountId from Contact where AccountId=:lstContact[0].AccountId];
        
        Set<String> Set_ContactId = new Set<String>();
        for(Contact con:GetAllContacts){
            Set_ContactId.add(con.id);
        }
        
        User[] AllUsers =[Select id, ContactId From user where ContactId in: Set_ContactId];
        
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
        
        List<ContentVersion> myFiles = new List<ContentVersion>();
        for (ContentVersion fFiles: files) {
            if (fFiles.Sharing_Permissions__c == 'Private' && fFiles.Uploaded_By__c == LOGGEDINUSER){
                myFiles.add(fFiles);
            }    
        }
        return myFiles;
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