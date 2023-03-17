Public Class CaseHandler{
    
    
   // Public Case NewCase {get;set;}
    
    public CaseHandler(ApexPages.StandardController stdController) {
       
       // NewCase = (Case)stdController.getRecord();
        
    }




public CaseHandler(){

    
}





@invocablemethod
Public static void AddUserfirm(List<id> CaseId){
    
  String LOGGEDINUSER;
   for(Id c:CaseId){
    LOGGEDINUSER = UserAccessRights.ProfileName(c);
   }
   
   if(LOGGEDINUSER !='System Administrator'){
               Id ContactId = UserAccessRights.returnContact();
               
               system.debug('*****'+ContactId+'**Logged***'+LOGGEDINUSER);
               Contact[] FirmContact = [Select AccountId from Contact where id=:ContactId];
               
               Case[] CurrentCase = [Select ClaimantFirm__c,Defendant_Firm__c,Case_Source__c From Case Where Id=:CaseId];
               
               if(CurrentCase[0].Case_Source__c=='Claimant'){ //&& LOGGEDINUSER=='Defendant Handler'
                   system.debug('**HUH?***'+FirmContact[0].AccountId);
                   CurrentCase[0].ClaimantFirm__c = FirmContact[0].AccountId;
               }
               else if(CurrentCase[0].Case_Source__c=='Defendant' ){ //&& LOGGEDINUSER=='Defendant Handler'
                   system.debug('**HUH?***'+FirmContact[0].AccountId);
                   CurrentCase[0].Defendant_Firm__c = FirmContact[0].AccountId;
               } 
               if(CurrentCase[0].id !=null){
                   system.debug('**Update***'+CurrentCase[0].id);
                   Update CurrentCase;
               } 
    }           
}




}