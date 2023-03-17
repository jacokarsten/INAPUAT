trigger teamrolestrigger on Firm_Team_Roles__c (After delete,before delete,After insert, After update) {
   
    /*
    if(trigger.isupdate ){
        if(StatusChangeHandler.STATUSCHANGETRIGGER!=True){
            StatusChangeHandler.FromTeam(trigger.new);
        }
    } 
    */
    
     
    if(trigger.isinsert ){
        StatusChangeHandler.FromTeam(trigger.new);
    }
    
    if(trigger.isdelete){
        if(trigger.isbefore){
            StatusChangeHandler.FromTeam(trigger.old);
            CaseMemberHandler.BulkRemoveHandlerCaseTeam(trigger.old);
        }
       
        //ADD_Remove_CaseIndividual.RemoveCaseIndividual(trigger.old);
    }
    /*
    else if(trigger.isinsert){
        ADD_Remove_CaseIndividual.AddCaseIndividual(trigger.new);
    }
    */
    

}