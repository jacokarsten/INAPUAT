Public Class UserHandler{

Public Static Boolean STOPUSERTRIGGER;


//FROM USER
Public static void updateContactDetails(List<user> lst_user){

    Set<String> Set_Con = new set <String>(); 
    Set<String> Set_User = new set <String>();   
    
    for(user u:lst_user){
        if(u.contactId != null){
            Set_Con.Add(u.contactId);
            Set_User.Add(u.id);
        }
    }
    
    /*
    List<Contact> lst_Contact = new List<Contact>([Select id,Status__c, Email,Mobilephone,FirstName,lastname,MailingStreet,MailingPostalCode,MailingCity from Contact Where id in:Set_Con ]);
    
    for(user u:lst_user){
    
        for(Contact con: lst_Contact){
            
            if(u.contactId == con.id){
               
                
                if(u.Isactive){
                    con.Status__c='Active';
                }
                else if(u.Isactive == false){
                    
                //    if(con.Active_Count_on_Teams__c>0){
               //        u.Still_has_Active_Cases__c = true;
                //    }
                    
                    
                }
                
            }
            
        }    
    }
    */
    
    
    updateUserDetails_future(Set_Con);
    
}


@future
Public static void updateUserDetails_future(Set<String> Set_Con){
    
    List<user> lst_user = new List<user>([Select email,Department,fax,CompanyName,Account.Name,phone,contactId,firstname,lastname,street,postalcode,city,Isactive From User Where ContactId in: Set_Con ]);
    
    List<Contact> lst_Contact = new List<Contact>([Select id,Status__c,Department,fax,Account.Name, Email,Mobilephone,FirstName,lastname,MailingStreet,MailingPostalCode,MailingCity from Contact Where id in:Set_Con ]);
    
    system.debug('**One***'+lst_Contact);
     for(user u:lst_user){
    
        for(Contact con: lst_Contact){
             system.debug('**TWO***');
            if(u.contactId == con.id){
                con.email=u.email;
                con.Mobilephone = u.phone;
                con.FirstName=u.firstname;
                con.lastname =u.lastname;
                con.MailingStreet =u.street;
                con.MailingPostalCode = u.postalcode;
                con.MailingCity =u.city;
               con.Department = u.Department;
               con.fax = u.fax;
               con.Account.Name=u.CompanyName;
               
                if(u.Isactive){
                    con.Status__c='Active';
                }
                else if(u.Isactive == false){
                    con.Status__c='InActive';
                }
                system.debug('**THREE***');
            }
            
        }    
    }
    
    
    system.debug('**FOUR***');
    STOPUSERTRIGGER = true;
    StatusChangeHandler.STATUSCHANGETRIGGER=True;
    update lst_Contact;
}



//FROM CONTACT


@Invocablemethod
Public static void updateUserDetails(List<Id> ContactID){
    
    //updateContactUserDetails(ContactID);
}    

Public static void updateUserDetailsFromContact(List<Contact> lst_Contact){
    List<ID> lst_Con = new List<Id>();    
    
    for(Contact c:lst_Contact){         
            lst_Con.Add(c.Id);
    }
   
   
    updateContactUserDetails(lst_Con);
}

@future
Public static void updateContactUserDetails(List<Id> ContactID){
    List<Contact> lst_Contact = new List<Contact>([Select id,Department,fax,Account.Name,Status__c,Email,Mobilephone,FirstName,lastname,MailingStreet,MailingPostalCode,MailingCity from Contact Where id in:ContactID ]);

    Set<String> Set_Con = new set <String>();    
    
    for(Contact c:lst_Contact){         
            Set_Con.Add(c.Id);
    }
    
    List<user> lst_user = new List<user>([Select email,Department,fax,CompanyName,contactId,phone,firstname,lastname,street,postalcode,city,Isactive From User Where ContactId in: Set_Con ]);
    
    system.debug('***C_One**');
    
    for(user u:lst_user){
    
        for(Contact con: lst_Contact){
            
            if(u.contactId == con.id){
               u.email = con.email;
               u.phone = con.Mobilephone;
               u.firstname = con.FirstName;
               u.lastname = con.lastname;
               u.street = con.MailingStreet;
               u.postalcode = con.MailingPostalCode;
               u.city = con.MailingCity;
               u.Department = con.Department;
               u.fax = con.fax;
               u.CompanyName = con.Account.Name;
                
                if(con.Status__c=='Active'){                    
                    u.Isactive = true;
                    
                }
                else{
                    u.Isactive = false;
                }
               system.debug('***C_TWO**'+con.Status__c); 
            }
            
        }    
    }
    STOPUSERTRIGGER=true;
    StatusChangeHandler.STATUSCHANGETRIGGER=True;
    update lst_user;
    
    
}


}