public class TeamViewApexController {
    
    @AuraEnabled
    public static List<FirmTeamWrapper> getFirmTeamRoles() {
        
        User[] ContactUser =[Select id,ContactId, AccountId From user where id=:UserInfo.getUserId()];
        Contact[] lstContact = [Select id,Active_Case_on_Individual_Count__c,AccountId,Role__c,Name,Email,Status__c From Contact where id =:ContactUser[0].ContactId];
        Firm_Team__c[] lstFirmTeam = [Select id,Firm__c,Name from Firm_Team__c where Firm__c=:lstContact[0].AccountId]; 
        Set<String> Set_Han = new Set<String>();
        List<FirmTeamWrapper> firmTeamList = new List<FirmTeamWrapper>();
        List<Contact> firmContacts = [SELECT Id, AccountId, Name, Email, Role__c, Status__c FROM Contact WHERE AccountId =:lstContact[0].AccountId ];
        for( Contact con:firmContacts){
            if(con.Role__c=='Handler'){
                Set_Han.add(con.id);    
            }
        }
            Firm_Team_Roles__c[] FirmTeamRoles = [Select Firm_Team__c,Firm_Team_Name__c,Contact_Email__c, Contact_Name__c,Roles__c, Contact__c, Contact_Status__c   From Firm_Team_Roles__c where  Contact__c in: Set_Han];
            
            
            
            Map<String,String> Map_TeamName = new Map<String,String>();
            
            for(Firm_Team_Roles__c role : FirmTeamRoles){
                Map_TeamName.put(role.Contact__c,role.Firm_Team_Name__c);
                    }
            
            
            for( Contact con2 : firmContacts){
                FirmTeamWrapper teamwrap = new FirmTeamWrapper();
                if(con2.Role__c=='Handler'){
                    system.debug('***TeAM**'+Map_TeamName.get(con2.id));
                    teamwrap.Team =Map_TeamName.get(con2.id);         
                }
                else{
                    teamwrap.Team ='';
                }
                teamwrap.Name = con2.Name;
                teamwrap.Email = con2.Email;
                teamwrap.Role = con2.Role__c;
                teamwrap.Status = con2.Status__c;
                
                firmTeamList.add(teamwrap);
                
            }
        
            
            
        
        return firmTeamList;
    }
    
        
        
        
        
        public Class FirmTeamWrapper{
            @AuraEnabled
            public String Team {get; set;}
            @AuraEnabled
            public String Name {get; set;}
            @AuraEnabled
            public String Email {get; set;}
            @AuraEnabled
            public String Role {get; set;}
            @AuraEnabled
            public String Status {get; set;}
        }
        
    }