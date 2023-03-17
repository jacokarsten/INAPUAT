Public Class AddSupervisorBulk{


@invocablemethod
Public static void AddSuperVisor(List<Id> ContactIds){
    
    List<Contact> lstContact = [Select Role__c,AccountId from Contact where id in:ContactIds];
        
    CaseMemberHandler.BulkAddSupervisor(lstContact);
}

}