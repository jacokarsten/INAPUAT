Public Class FromFirmTeam_Remove{


//@invocablemethod
Public static Boolean RemoveAllMembers(List<Id> FirmTeam){
    
     
    Boolean Active=FirmMemberTeamHandler.CheckForActiveTeam(FirmTeam);
    
    if(Active){
        /*
        Firm_Team__c[] lstFirmTeam = [Select id,Deactivate_Validation__c  from Firm_Team__c where id in:FirmTeam];
        
        for(Firm_Team__c firm:lstFirmTeam){
            firm.Deactivate_Validation__c=true;
        }    
        update lstFirmTeam;
        */
    }
    else{    
        FirmMemberTeamHandler.RemoveAllmembersinteam(FirmTeam);
    }  
    
    return Active;  
}


}