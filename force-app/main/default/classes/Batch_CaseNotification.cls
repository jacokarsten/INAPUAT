global class Batch_CaseNotification implements Database.Batchable<sObject>,Schedulable, Database.AllowsCallouts, Database.Stateful{
       
    global Database.QueryLocator start(Database.BatchableContext BC){  
                   
        return Database.getQueryLocator([Select id from Case where Stage__c ='Negotiation']);    
    }

    global void execute(Database.BatchableContext BC, List<Case> scope){
       
       Set<String> set_Case = new Set<String>();
         
        
        
       for(Case var : scope){
           set_Case.add(var.id);           
       }
      
       CaseNotificationHandler.NotifyBilateralDate(set_Case);
       CaseNotificationHandler.NotifyUnilateralDate(set_Case);
       CaseNotificationHandler.NotifyDocPrepStatus(set_Case);
       CaseNotificationHandler.NotifyDocPrepStatus_PriortoEnd(set_Case);
       CaseNotificationHandler.NotifyFinalOfferStatus(set_Case);
       CaseNotificationHandler.NotifyFinalOfferStatus_PriortoEnd(set_Case);
       CaseNotificationHandler.NotifyArbitratorFinal(set_Case);
       CaseNotificationHandler.NotifyMarketMakerFinal(set_Case);
       
      
    }

    global void finish(Database.BatchableContext BC){
        
    }
    
    
    global void execute(SchedulableContext sc)
    {
        Batch_CaseNotification updateReferal = new Batch_CaseNotification();
        database.executebatch(updateReferal ,1);
    }
    
}