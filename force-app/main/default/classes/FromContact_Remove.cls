Public Class FromContact_Remove{


//@invocablemethod

Public static Boolean RemoveAllMembers(List<Id> ContactId){
    /*
    Boolean Active=FirmMemberTeamHandler.CheckForActiveTeam(ContactId);
    
    if(Active){
       
    }
    else{
        
    }
    */
    
    
    FirmMemberTeamHandler.RemoveAllmembersContact(ContactId);
    return false;
       
}


}