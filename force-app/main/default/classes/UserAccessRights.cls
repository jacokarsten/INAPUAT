Public class UserAccessRights{






Public  static Map<String,String> UserRightsLossItems(Id CaseId){

    Map<String,String> MapLossitems = new Map<String,String>();   
        
    
    String ProfileName = ProfileName(CaseId);
    
    system.debug('**ProfileName**'+ProfileName);
    
    if(ProfileName=='Owner'){
        MapLossitems.Put('Claimant','Edit');
        MapLossitems.Put('Defendant','Readonly');
        MapLossitems.Put('Arbitrator','Readonly');
        MapLossitems.Put('UpdateItem','TRUE');
        MapLossitems.Put('ViewItems','TRUE');
        MapLossitems.Put('CreateNew','TRUE');
        MapLossitems.Put('Refer','TRUE'); 
        MapLossitems.Put('ViewInd','TRUE');      
        
    }
    
    else if(ProfileName=='Claimant Supervisor'){
        MapLossitems.Put('Claimant','Readonly');
        MapLossitems.Put('Defendant','Readonly');
        MapLossitems.Put('Arbitrator','Readonly');
        MapLossitems.Put('UpdateItem','FALSE');
        MapLossitems.Put('ViewItems','TRUE');
        MapLossitems.Put('CreateNew','FALSE');
        MapLossitems.Put('Refer','TRUE'); 
        MapLossitems.Put('ViewInd','TRUE');      
        
    }
    else if(ProfileName=='Defendant Supervisor'){    
        MapLossitems.Put('Defendant','Readonly');
        MapLossitems.Put('Arbitrator','Readonly');
        MapLossitems.Put('Claimant','Readonly');
        MapLossitems.Put('UpdateItem','FALSE');
        MapLossitems.Put('CreateNew','FALSE');
        MapLossitems.Put('ViewInd','TRUE');
        MapLossitems.Put('ViewItems','TRUE');
        MapLossitems.Put('Refer','FALSE');
    }
    else if(ProfileName=='Claimant Handler'){
        MapLossitems.Put('Claimant','Edit');
        MapLossitems.Put('Defendant','Readonly');
        MapLossitems.Put('Arbitrator','Readonly');
        MapLossitems.Put('UpdateItem','TRUE');
        MapLossitems.Put('ViewItems','TRUE');
        MapLossitems.Put('CreateNew','TRUE');
        MapLossitems.Put('Refer','TRUE'); 
        MapLossitems.Put('ViewInd','TRUE');      
        
    }
    else if(ProfileName=='Defendant Handler'){    
        MapLossitems.Put('Defendant','Edit');
        MapLossitems.Put('Arbitrator','Readonly');
        MapLossitems.Put('Claimant','Readonly');
        MapLossitems.Put('UpdateItem','TRUE');
        MapLossitems.Put('ViewInd','TRUE');
        MapLossitems.Put('ViewItems','TRUE');
        MapLossitems.Put('Refer','TRUE');
    }
    else if(ProfileName=='Facilitator'){    
        //MapLossitems.Put('ViewItems','FALSE');
        MapLossitems.Put('Defendant','Readonly');
        MapLossitems.Put('Arbitrator','Readonly');
        MapLossitems.Put('Claimant','Readonly');
        MapLossitems.Put('UpdateItem','FALSE');
        MapLossitems.Put('ViewInd','FALSE');
        MapLossitems.Put('ViewItems','TRUE');
        MapLossitems.Put('Refer','FALSE');
    }
    else if(ProfileName=='Arbitrator'){    
        //MapLossitems.Put('ViewItems','FALSE');
        MapLossitems.Put('Defendant','Readonly');
        MapLossitems.Put('Arbitrator','Edit');
        MapLossitems.Put('Claimant','Readonly');
        MapLossitems.Put('UpdateItem','TRUE');
        MapLossitems.Put('ViewInd','FALSE');
        MapLossitems.Put('ViewItems','TRUE');
        MapLossitems.Put('Refer','FALSE');
    }
    else if(ProfileName=='System Administrator'){
        MapLossitems.Put('Claimant','Readonly');
        MapLossitems.Put('Defendant','Readonly');
        MapLossitems.Put('Arbitrator','Hidden');
        MapLossitems.Put('UpdateItem','FALSE');
        MapLossitems.Put('ViewInd','TRUE');
        MapLossitems.Put('ViewItems','TRUE');
        MapLossitems.Put('CreateNew','TRUE');
    }
    else if(ProfileName=='Market Maker'){
        MapLossitems.Put('Claimant','Readonly');
        MapLossitems.Put('Defendant','Readonly');
        MapLossitems.Put('Arbitrator','Hidden');
        MapLossitems.Put('UpdateItem','FALSE');
        MapLossitems.Put('ViewInd','TRUE');
        MapLossitems.Put('ViewItems','TRUE');
        MapLossitems.Put('CreateNew','TRUE');
    }
    
    
    
    //MapLossitems.Put('Claimant','Readonly');
    //MapLossitems.Put('Claimant','Hidden');
   // MapLossitems.Put('Defendant','Readonly');
   // MapLossitems.Put('Defendant','Hidden'); 
    
    return MapLossitems;
}


/*
Public static Map<String,String>   UpdateUserRightsonFiles(Id CaseId){
   
   
   Map<String,String> MapArbitration = new Map<String,String>(); 
   String ProfileName = ProfileName(CaseId);
    
    if(ProfileName=='Claimant Handler'){
        MapArbitration.Put('Claimant','Edit');
        MapArbitration.Put('Defendant','Readonly');
        MapArbitration.Put('Arbitrator','Readonly');
        MapArbitration.Put('UpdateItem','TRUE');
        MapArbitration.Put('UpdateItem','TRUE');
        MapArbitration.Put('ViewItems','TRUE');       
        
    }
    else if(ProfileName=='Defenadant Handler'){    
        MapArbitration.Put('Defendant','Edit');
        MapArbitration.Put('Arbitrator','Readonly');
        MapArbitration.Put('Claimant','Readonly');
        MapArbitration.Put('UpdateItem','TRUE');
        MapArbitration.Put('UpdateItem','TRUE');
        MapArbitration.Put('ViewItems','TRUE');
    }
    else if(ProfileName=='Arbitrator'){    
        MapArbitration.Put('ViewItems','FALSE');
    }
    else if(ProfileName=='System Administrator'){
        MapArbitration.Put('Claimant','Readonly');
        MapArbitration.Put('Defendant','Readonly');
        MapArbitration.Put('Arbitrator','Hidden');
        MapArbitration.Put('UpdateItem','TRUE');
        MapArbitration.Put('ViewInd','FALSE');
        MapArbitration.Put('ViewItems','TRUE');
        MapArbitration.Put('CreateNew','FALSE');
    }
    return MapArbitration;

}

Public static Map<String,String>  RefertoAbritration(){
    Map<String,String> MapArbitration = new Map<String,String>();
   
    return MapArbitration;

}

Public static Map<String,String>   AcceptAbritration(){
    Map<String,String> MapArbitration = new Map<String,String>();
   
    return MapArbitration;
    
}
*/
    

Public static void AddMemberstoCase(){


}

//----------------GET PROFILE type based on Case

Public Static String ProfileName(Id CaseId){

    id id1 = UserInfo.getProfileId();
 
    Profile[] profileName = [select Name from profile where id = :id1];
    
    String CaseUserType;
    if(profileName[0].name=='System Administrator' || profileName[0].name=='Arbitrator' || profileName[0].name=='Market Maker'){
        return profileName[0].name;
    }
    else{
        CaseUserType=CaseMemberHandler.returnCaseTeamRole(CaseId,UserInfo.getUserId());   
    }
    
    
    return CaseUserType;
    
}

Public Static Id returnContact(){
   
    User[] ContactUser =[Select id,ContactId From user where id=:UserInfo.getUserId()];
    return ContactUser[0].ContactId;
}

}