global class Batch_CaseReferalHandler implements Database.Batchable<sObject>,Schedulable, Database.AllowsCallouts, Database.Stateful{
       
    global Database.QueryLocator start(Database.BatchableContext BC){  
                   
        return Database.getQueryLocator([Select id from Case where Stage__c ='Negotiation']);    
    }

    global void execute(Database.BatchableContext BC, List<Case> scope){
       
       Set<String> set_Case = new Set<String>();
         
        
        
       for(Case var : scope){
           set_Case.add(var.id);           
       }
      
       CaseReferalHandler.UpdatetoDocPrepStatus(set_Case);
       CaseReferalHandler.UpdatetoFinalOffersStatus(set_Case);
       CaseReferalHandler.UpdatetoArbitratingStatus(set_Case);
       
      
    }

    global void finish(Database.BatchableContext BC){
        
    }
    
    
    global void execute(SchedulableContext sc)
    {
        Batch_CaseReferalHandler updateReferal = new Batch_CaseReferalHandler();
        database.executebatch(updateReferal ,1);
    }
    
}