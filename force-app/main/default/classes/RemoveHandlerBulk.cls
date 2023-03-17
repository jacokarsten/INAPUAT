Public class RemoveHandlerBulk{

//REMOVED DONE ON DELETE
@invocablemethod
Public static void RemoveCaseIndividual(List<Id> firmRoleId){
    
    List<Firm_Team_Roles__c> lst_FirmTeamRoles = [Select Contact__c,Firm_Team__c,Roles__c  From Firm_Team_Roles__c where id in: firmRoleId];      
    CaseMemberHandler.BulkRemoveHandlerCaseTeam(lst_FirmTeamRoles);

}



}