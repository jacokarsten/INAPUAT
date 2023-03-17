public class CaseTeamListController {
    
    @AuraEnabled
    public static List<CaseTeamWrapper> getCaseTeamMembers(String caseIdInput) {
        
        CaseTeamMember[] CaseTeamMembers = [SELECT Id, MemberId, ParentId, TeamRole.Name FROM CaseTeamMember WHERE ParentId =: caseIdInput];
        // CaseTeamRole[] CaseTeamRoles = [SELECT Id, Name from CaseTeamRole];
        Map<String,String> Map_role = new Map<String,String>();
        for(CaseTeamMember t:CaseTeamMembers){
            Map_role.put(t.MemberId,t.TeamRole.name);
        }
        Set<String> Set_MemberId = new Set<String>();
        for(CaseTeamMember ctm:CaseTeamMembers){
            Set_MemberId.add(ctm.MemberId);
        }
        User[] AllCaseUsers = [SELECT Id, ContactId, Name, Contact.Email, Account.Name from User WHERE Id =: Set_MemberId];
        
        
        List<CaseTeamWrapper> caseTeamList = new List<CaseTeamWrapper>();
        for(User caseTeamMember : AllCaseUsers) {
            CaseTeamWrapper teamWrapper = new CaseTeamWrapper();
            teamWrapper.Name = caseTeamMember.Name;
            teamWrapper.Role = Map_role.get(caseTeamMember.id);
            teamWrapper.Email = caseTeamMember.Contact.Email;
            teamWrapper.FirmName = caseTeamMember.Account.Name;
            caseTeamList.add(teamWrapper);
        }
        
        
        return caseTeamList;
        
    }
    
    public Class CaseTeamWrapper{
        @AuraEnabled
        public String Name {get; set;}
        @AuraEnabled
        public String Role {get; set;}
        @AuraEnabled
        public String Email {get; set;}
        @AuraEnabled
        public String FirmName {get; set;}
    }
    
}