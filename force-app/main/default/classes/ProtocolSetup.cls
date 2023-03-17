Public Class ProtocolSetup{

@invocablemethod
Public static void SetProtocolOptionRecordType(List<Id> optionsId){
    
    system.debug('**IN**');
    List<Protocol_Option__c> lst_Options = new List<Protocol_Option__c>([Select id,Protocol_Option__c,Record_Type_ID__c,Protocol_Item_Type__c from Protocol_Option__c where id in:optionsId  ]);
    PopulateProtocolOptions(lst_Options);
}



Public Static void PopulateProtocolOptions(List<Protocol_Option__c> lst_Options){

    
    List<RecordType> lst_recordIncident = new List<RecordType>([Select Id,DeveloperName from RecordType Where SobjectType=:'Incident_Information__c']);    
    List<RecordType> lst_recordClaim = new List<RecordType>([Select Id,DeveloperName from RecordType Where SobjectType=:'Claimant_Information__c']);    
    List<RecordType> lst_recordDef = new List<RecordType>([Select Id,DeveloperName from RecordType Where SobjectType=:'Defendant_Information__c']);    
    List<RecordType> lst_recordCase = new List<RecordType>([Select Id,DeveloperName from RecordType Where SobjectType=:'Case']);    
    
    system.debug('**ONE**'+lst_recordClaim);
    
    
    Map<String,String> Map_RecordInc = new Map<String,String>();
    Map<String,String> Map_RecordClaim = new Map<String,String>();
    Map<String,String> Map_RecordDef = new Map<String,String>();
    Map<String,String> Map_RecordCase = new Map<String,String>();
    
   
    
   
    
    for(RecordType rt:lst_recordIncident){
       
       if(rt.DeveloperName=='Arbitration_Only'){ 
            Map_RecordInc.put('Arb',rt.id);
       }
       else if(rt.DeveloperName=='PI_EL_End_to_End'){  
            Map_RecordInc.put('PIEL',rt.id);
       }
       else if(rt.DeveloperName=='End_to_End'){  
            Map_RecordInc.put('End',rt.id);
       }
       else if(rt.DeveloperName=='PI_PL_End_to_End'){ 
            Map_RecordInc.put('PIPL',rt.id);
       }
    }
    
    for(RecordType rt:lst_recordClaim){
       system.debug('**DeveloperName**'+rt.DeveloperName);
      if(rt.DeveloperName=='Arbitration_Only'){ 
            Map_RecordClaim.put('Arb',rt.id);
            
            system.debug('**Claim**'+Map_RecordClaim.get('Arb')+'****'+rt.id);
       }
       else if(rt.DeveloperName=='Claimant_PI_EL_EE'){   
            Map_RecordClaim.put('PIEL',rt.id);
       }
       else if(rt.DeveloperName=='Claimant_PI_PL_EE'){   
            Map_RecordClaim.put('PIPL',rt.id);
       }
       else if(rt.DeveloperName=='End_to_End'){ 
            Map_RecordClaim.put('End',rt.id);
       } 
    }
    
    for(RecordType rt:lst_recordDef){
       
       if(rt.DeveloperName=='Arbitration_Only'){ 
            Map_RecordDef.put('Arb',rt.id);
       }
       else if(rt.DeveloperName=='Defendant_PI_EL_EE'){   
            Map_RecordDef.put('PIEL',rt.id);
       }
       else if(rt.DeveloperName=='Defendant_PI_PL_EE'){   
            Map_RecordDef.put('PIPL',rt.id);
       }
       else if(rt.DeveloperName=='End_to_End'){ 
            Map_RecordDef.put('End',rt.id);
       } 
    }
    
    for(RecordType rt:lst_recordCase){
       
       if(rt.DeveloperName=='Personal_Injury_Public_Liability_End_to_End'){ 
            Map_RecordCase.put('PIEL',rt.id);
       }
       else if(rt.DeveloperName=='Personal_Injury_Public_Liability_End_to_End'){ 
            Map_RecordCase.put('PIPL',rt.id);
       }
       else if(rt.DeveloperName=='PersonalInjuryMotorVehicleArbitrationOnly'){ 
            Map_RecordCase.put('Arb',rt.id);
       }
       else if(rt.DeveloperName=='PersonalInjuryMotorVehicleEndtoEnd_1'){ 
            Map_RecordCase.put('End',rt.id);
       }
    }
    
    for( Protocol_Option__c  o:lst_Options){
        
        if(o.Protocol_Item_Type__c =='Claimant'){
        system.debug('**TWO**');
                if(o.Protocol_Option__c=='Claimant - PI-MV-AO'){ 
                  o.Record_Type_ID__c =  Map_RecordClaim.get('Arb');
                  system.debug('**Record**'+Map_RecordClaim.get('Arb'));
               }
               else if(o.Protocol_Option__c=='Claimant - PI-EL-EE'){   
                   o.Record_Type_ID__c = Map_RecordClaim.get('PIEL');
               }
               else if(o.Protocol_Option__c=='Claimant - PI-PL-EE'){   
                   o.Record_Type_ID__c = Map_RecordClaim.get('PIPL');
               }
               else if(o.Protocol_Option__c=='Claimant - PI-MV-EE'){ 
                  o.Record_Type_ID__c =  Map_RecordClaim.get('End');
               } 
        }
        else if(o.Protocol_Item_Type__c=='Defendant'){
                
                
                if(o.Protocol_Option__c=='Defendant - PI-MV-AO'){ 
                   o.Record_Type_ID__c = Map_RecordDef.get('Arb');
               }
               else if(o.Protocol_Option__c=='Defendant - PI-EL-EE'){   
                   o.Record_Type_ID__c = Map_RecordDef.get('PIEL');
               }
               else if(o.Protocol_Option__c=='Defendant - PI-PL-EE'){   
                   o.Record_Type_ID__c = Map_RecordDef.get('PIPL');
               }
               else if(o.Protocol_Option__c=='Defendant - PI-MV-EE'){ 
                   o.Record_Type_ID__c = Map_RecordDef.get('End');
               } 
               
               system.debug('**DEFN**'+o.Record_Type_ID__c);
        }
        else if(o.Protocol_Item_Type__c=='Case'){
            if(o.Protocol_Option__c=='Case - PI-MV-AO'){ 
                    o.Record_Type_ID__c =Map_RecordCase.get('Arb');
               }
               else if(o.Protocol_Option__c=='Case - PI-EL-EE'){   
                   o.Record_Type_ID__c = Map_RecordCase.get('PIEL');
               }
               else if(o.Protocol_Option__c=='Case - PI-PL-EE'){   
                   o.Record_Type_ID__c = Map_RecordCase.get('PIPL');
               }
               else if(o.Protocol_Option__c=='Case - PI-MV-EE'){ 
                  o.Record_Type_ID__c =  Map_RecordCase.get('End');
               } 
        }
        else if(o.Protocol_Item_Type__c=='Incident'){
                if(o.Protocol_Option__c=='Incident - PI-MV-AO'){ 
                   o.Record_Type_ID__c = Map_RecordInc.get('Arb');
               }
               else if(o.Protocol_Option__c=='Incident - PI-EL-EE'){   
                  o.Record_Type_ID__c =  Map_RecordInc.get('PIEL');
               }
               else if(o.Protocol_Option__c=='Incident - PI-PL-EE'){   
                  o.Record_Type_ID__c =  Map_RecordInc.get('PIPL');
               }
               else if(o.Protocol_Option__c=='Incident - PI-MV-EE'){ 
                   o.Record_Type_ID__c = Map_RecordInc.get('End');
               } 
        }
        
        system.debug('**Opp**'+o.Protocol_Item_Type__c+'**Rec**'+o.Record_Type_ID__c);
    }
    
   //update lst_Options; 
    
  system.debug('**DEFN22**'+lst_Options);

}










/*
Public void AddHeadsofLosstoCase(String CaseID){
   
   
    List<RecordType> lst_recordType = new List<RecordType>([Select Id,DeveloperName from RecordType Where SobjectType=:'Loss_Category__c']);    
    
    
    Map<String,String> Map_RecordTypes = new Map<String,String>();
    
    for(RecordType rt:lst_recordType){
       
       if(rt.DeveloperName=='Past_or_Future_Losses'){ 
            Map_RecordTypes.put('Loss',rt.id);
       }
       else if(rt.DeveloperName=='Personal_Injury_and_Loss_of_Amenity'){ 
            Map_RecordTypes.put('PSLA',rt.id);
       }
       else{ 
            Map_RecordTypes.put('Other',rt.id);
       } 
    }
    
    List<Loss_Category__c> lst_headofLoss = new List<Loss_Category__c>();
    
    Schedule_of_Losses__c ScheduleLosses = new Schedule_of_Losses__c();
    
    ScheduleLosses.Case__c = CaseID;
    Insert ScheduleLosses;
    
    Loss_Category_Types__c[] LossTypes = [Select id,Name from Loss_Category_Types__c];
    
    
    for(Loss_Category_Types__c t:LossTypes){
        
        Loss_Category__c loss = new Loss_Category__c();
        loss.Case__c = CaseID;
        loss.Schedule_of_Losses__c = ScheduleLosses.id;
        loss.Loss_Category_Types__c = t.id;
        
        if(t.Name == 'Future Financial Losses' || t.Name == 'Past Financial Losses'){
            loss.RecordTypeId = Map_RecordTypes.get('Loss');
        }
        else if(t.Name == 'Personal Injury and Loss of Amenity'){
            loss.RecordTypeId = Map_RecordTypes.get('PSLA');
        }
        else{
            loss.RecordTypeId = Map_RecordTypes.get('Other');
        }  
       lst_headofLoss.add(loss); 
              
    }
    
    
    Insert lst_headofLoss;
    
    Merit__c Merit = new Merit__c();
    Merit.Schedule_of_Losses__c = ScheduleLosses.id;
    Merit.Related_Case__c = CaseID;
    Insert Merit;



}
*/











}