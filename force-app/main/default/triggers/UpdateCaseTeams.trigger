trigger UpdateCaseTeams on Case (before update) {

    if(trigger.isupdate){
        
        RemoveCaseTeams.RemoveClaimantTeam(trigger.old,trigger.new);
        RemoveCaseTeams.RemoveDefendantTeam(trigger.old,trigger.new);
        RemoveCaseTeams.RemoveClaimantSupervisor(trigger.old,trigger.new);
        RemoveCaseTeams.RemoveDefendantSupervisor(trigger.old,trigger.new);
        RemoveCaseTeams.RemoveFacilitator(trigger.old,trigger.new);
        
    }

}