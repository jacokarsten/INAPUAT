Public Class RemoveSupervisorBulk{


@invocablemethod
Public static void RemoveSuperVisor(List<Id> ContactIds){  
    List<Contact> lstContact = [Select Role__c,AccountId,Status__c from Contact where id in:ContactIds];
    
    system.debug('**IN REMOVE**');
    CaseMemberHandler.BulkRemoveSupervisor(lstContact);
    
}

}