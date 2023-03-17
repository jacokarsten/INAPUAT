Public without sharing Class ghostscriptAPI{

@invocablemethod
Public static void Addfile(List<String> Caseid){

for(String c:Caseid){
    generatedoc(c);
}

}


@future (callout=true)
Public static void generateFinalAwardonclose(String CaseId){
   awardgeneratedoc(CaseId,'FINAL');
}

@future (callout=true)
Public static void generateInterimAwardonclose(String CaseId){
   awardgeneratedoc(CaseId,'INTERIM');
}



Public static string awardgeneratedoc(String CaseId,String DOCTYPE){
 
    HttpRequest request = new HttpRequest();
    Blob requestresponse;
  
    request.setMethod('POST');
    

    request.setHeader('Content-Type', 'application/xml');
    request.setHeader('Authorization', 'Basic c2hhdW5yOlBAc3N3MHJkMTIz');
    
   
   // string body='<?xml version="1.0" encoding="utf-8"?><INAP xmlns="http://ghostdraft.korbitec.com/server/model/INAP-1.2"><Case><CaseIdentifier>#1234</CaseIdentifier><isarbitrated>true</isarbitrated><isarbitratedandpartiallysettled>false</isarbitratedandpartiallysettled><issettled>false</issettled><AccidentDate>2019-05-14T00:00:00</AccidentDate><Costs><Value>2000</Value><paymentisfortherespondent>true</paymentisfortherespondent></Costs><TotalDamages>89752</TotalDamages></Case><ClaimantFirm><FullName>Liam Claimant Peteresen</FullName></ClaimantFirm><DefendantFirm><FullName>Peter Defendant Parker</FullName></DefendantFirm><Arbitration><AgreementDate>2019-05-03T00:00:00</AgreementDate><Arbitrator><Name><Title>Mrs</Title><FirstName>Amina</FirstName><LastName>Palmer</LastName></Name></Arbitrator><AwardDate>2019-05-08T00:00:00</AwardDate></Arbitration><Merits><DefendantLiability>55</DefendantLiability><Rationale>Because this is the Rationale of Merits</Rationale></Merits><HeadsofLoss><Items><Loss><LossTypes>isforbereavement</LossTypes><Sub-Losses><Items></Items></Sub-Losses><isnoclaim>false</isnoclaim><isarbitrated>true</isarbitrated><issettled>false</issettled><SettlementAmount>65412</SettlementAmount><Rationale>Because this is the Rationale</Rationale><ArbitrationAmount>20000</ArbitrationAmount></Loss></Items></HeadsofLoss></INAP>';
    
    Map<String,String> Map_TypeBody = new Map<String,String>();
    
   if(DOCTYPE=='FINAL'){ 
       Map_TypeBody = ghostscriptUtility.GetARBITRALXML_2(CaseId);
   }
   else if(DOCTYPE=='INTERIM'){ 
       Map_TypeBody = ghostscriptUtility.GetARBITRALXML_Interim(CaseId);
   } 
   
    string body;
 Ghost_Draft_API__c[] GhostDraftSettings = [Select Commencement_URL__c,Final_Award_URL__c, Interim_Award_URL__c,   Settlement_URL__c From  Ghost_Draft_API__c];
 
 if(DOCTYPE=='FINAL'){   
    if(Map_TypeBody.get('Partial')!=null){
        
        //request.setEndpoint('https://secure.ghostdraft.com/instances/GhostDraft/GhostDraftServer/RestApi/AssembleDocument?DocumentServiceName=INAP&PackageName=INAP&PackageVersion=1.2&TemplateName=Arbitral%20Award&Format=pdf'); //Arbitral%20Award%20Boilerplate
        request.setEndpoint(GhostDraftSettings[0].Final_Award_URL__c); 
        body=Map_TypeBody.get('Partial');
    }
    else if(Map_TypeBody.get('Arbitrated')!=null){
        //request.setEndpoint('https://secure.ghostdraft.com/instances/GhostDraft/GhostDraftServer/RestApi/AssembleDocument?DocumentServiceName=INAP&PackageName=INAP&PackageVersion=1.2&TemplateName=Arbitral%20Award&Format=pdf'); //Arbitral%20Award%20Boilerplate
        request.setEndpoint(GhostDraftSettings[0].Final_Award_URL__c); 
        body=Map_TypeBody.get('Arbitrated');
        
    }
    
    else if(Map_TypeBody.get('Settled')!=null){
        //request.setEndpoint('https://secure.ghostdraft.com/instances/GhostDraft/GhostDraftServer/RestApi/AssembleDocument?DocumentServiceName=INAP&PackageName=INAP&PackageVersion=1.2&TemplateName=Settlement%20Agreement&Format=pdf'); //Arbitral%20Award%20Boilerplate
        request.setEndpoint(GhostDraftSettings[0].Settlement_URL__c);
        body=Map_TypeBody.get('Settled');
    }
 }
 else{
          //request.setEndpoint('https://secure.ghostdraft.com/instances/GhostDraft/GhostDraftServer/RestApi/AssembleDocument?DocumentServiceName=INAP&PackageName=INAP&PackageVersion=1.2&TemplateName=Interim%20Arbitral%20Award&Format=pdf'); //Arbitral%20Award%20Boilerplate
          request.setEndpoint(GhostDraftSettings[0].Interim_Award_URL__c);
          body=Map_TypeBody.get('Interim');
 
 }       
      
  
  
  
  system.debug('***END POINT*****'+body);
    request.setBody(body);   
    Http http = new Http(); 
    HTTPResponse res;

    
    String APISTATUS='';
     if(!Test.isRunningTest()) {
          try{ 
               res = http.send(request);
               requestresponse = res.getBodyAsBlob();
               system.debug('***'+res.getStatus()+'**requestresponse**'+requestresponse);
               APISTATUS = res.getStatus();
              
           }
          catch(exception e){
          
  
          } 
    
     } 
     else{
     
         APISTATUS ='OK';
            requestresponse = blob.valueof('testing');
     } 
     
   
   
              GhostDraftLog__c GhostDraftLog = new GhostDraftLog__c();
              GhostDraftLog.Case__c = CaseId;
             
              GhostDraftLog.Status__c = APISTATUS.left(200);
              GhostDraftLog.XML__c  = body;
              GhostDraftLog.Type__c =DOCTYPE;
              
              Insert GhostDraftLog;
   
    if(APISTATUS!='OK'){
        
                    //Run Schedule to start again. RETRY
                    return 'Bad';
     }
    
    
    
    //system.debug('***'+res.getStatus()+'**requestresponse**'+requestresponse);
    
         
    
          
     
       
    Case[] CaseDoc = [Select CaseNumber from Case where id=:CaseId];
    
    
   String DocName;
   
   if(DOCTYPE=='FINAL'){
       DocName = 'FinalAward - '+CaseDoc[0].CaseNumber+' - ' +system.now() +'.pdf';
   }
   else{
       DocName = 'ArbInterim - '+CaseDoc[0].CaseNumber+' - ' +system.now() +'.pdf';
   }
   
    Network[] Nwork = [SELECT Id,Name FROM Network limit 1];
    
    ContentVersion contentVersion = new ContentVersion(
      Title = DocName,
      PathOnClient = DocName,
      Case_Id__c = CaseId,
      Sharing_Permissions__c = 'Shared',
      VersionData = requestresponse,
      INAP_Doc_Type__c = 'Award Document',
      Ghost_Draft_Doc__c =true,
      NetworkId = Nwork[0].id,
      IsMajorVersion = true
    );
    insert contentVersion;    
    
    system.debug('**CV**'+contentVersion);
    List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument where title=:DocName];

    system.debug('**documents**'+documents);
    //create ContentDocumentLink  record 
    
    ContentDocumentLink cdl = New ContentDocumentLink();
    cdl.LinkedEntityId = CaseId;
    cdl.ContentDocumentId = documents[0].Id;
    cdl.shareType = 'V';
    insert cdl;
    
    Loss_Category_Files__c LossFiles =  new Loss_Category_Files__c();
    LossFiles.File_Url__c='/s/contentdocument/'+documents[0].Id;
    LossFiles.File_Name__c = DocName;
    LossFiles.CaseId__c = CaseId;
    LossFiles.Document_Type__c='Award Document';
    LossFiles.Document_Sharing_Permissions__c ='Shared';
    LossFiles.Uploaded_By__c = 'Claimant Handler';
    insert LossFiles;
    
    
    return 'OK';
    
    
 /*   
    
  //  blob b=blob.valueOf(requestresponse);
    Document d = [SELECT DeveloperName,Body FROM Document where DeveloperName='Dez_Bryant'];
     //string body=d.body.toString();
    Document newPDF = new Document(body = requestresponse,Developername='GX12',name='GX12.pdf',FolderId='00l0N0000017qoiQAA');
    Insert newPDF;
   */ 
    
    //GhostXML__c GhostXML = new GhostXML__c(XML__c=requestresponse);
   // Insert GhostXML;    

}

@future (callout=true)
Public static void generatedoc(String CaseId){
 
    HttpRequest request = new HttpRequest();
    Blob requestresponse;
  
    request.setMethod('POST');
    Ghost_Draft_API__c[] GhostDraftSettings = [Select Commencement_URL__c,Final_Award_URL__c, Interim_Award_URL__c,   Settlement_URL__c From  Ghost_Draft_API__c];
    request.setEndpoint(GhostDraftSettings[0].Commencement_URL__c);
    //request.setEndpoint('https://secure.ghostdraft.com/instances/GhostDraft/GhostDraftServer/RestApi/AssembleDocument?DocumentServiceName=INAP&PackageName=INAP&PackageVersion=1.2&TemplateName=Notice%20of%20Commencement%20of%20Arbitration&Format=pdf');
    

    request.setHeader('Content-Type', 'application/xml');
    request.setHeader('Authorization', 'Basic c2hhdW5yOlBAc3N3MHJkMTIz');
    request.setTimeout(120000);
   
    //string body='<?xml version="1.0" encoding="utf-8"?><INAP xmlns="http://ghostdraft.korbitec.com/server/model/INAP-1.2"><Case><CaseIdentifier>#12345</CaseIdentifier><AcceptanceDate>2019-05-04T00:00:00</AcceptanceDate></Case><ClaimantFirm><Handler><Name><FirstName>Jacob</FirstName><LastName>Polly</LastName></Name></Handler><FullName>Amina Palmer</FullName><PhysicalAddress><Line1>240 Main Road</Line1><PostalCode>7700</PostalCode></PhysicalAddress><Claimant><Name><FirstName>Amina</FirstName><LastName>Palmer</LastName></Name></Claimant></ClaimantFirm><DefendantFirm><Handler><Name><FirstName>Peter </FirstName><Title>Mr</Title></Name></Handler><FullName>Judy Boucher</FullName><PhysicalAddress><Line1>3 Pilot Way</Line1><PostalCode>7725</PostalCode></PhysicalAddress><Defendant><Name><FirstName>Judy</FirstName><LastName>Boucher</LastName></Name></Defendant></DefendantFirm></INAP>';

     string body=ghostscriptUtility.GetNoticeofCommencementXML(CaseId);
        system.debug('**body**'+body);
   
    //string body=d.body.toString();

    request.setBody(body);   
    Http http = new Http(); 
    HTTPResponse res;
    
    String APISTATUS='';
     if(!Test.isRunningTest()) {
          try{   
               res = http.send(request);
               requestresponse = res.getBodyAsBlob();
                APISTATUS = res.getStatus();
              
           }
          catch(exception e){
          
  
          } 
     } 
     else{
     
              APISTATUS ='OK';
            requestresponse = blob.valueof('testing');
     } 
     
     
     GhostDraftLog__c GhostDraftLog = new GhostDraftLog__c();
     GhostDraftLog.Case__c = CaseId;
             
              GhostDraftLog.Status__c = APISTATUS.left(200);
              GhostDraftLog.XML__c  = body;
              GhostDraftLog.Type__c ='COMMENCEMENT';
              
              Insert GhostDraftLog; 
       
    system.debug('**requestresponse**'+requestresponse);
    
    Case[] CaseDoc = [Select CaseNumber from Case where id=:CaseId];
    
    
   String DocName = 'Commencement - '+CaseDoc[0].CaseNumber +' - ' +system.now()+'.pdf';
    
  Network[] Nwork = [SELECT Id,Name FROM Network limit 1];
    
    ContentVersion contentVersion = new ContentVersion(
      Title = DocName,
      PathOnClient = DocName,
      Sharing_Permissions__c = 'Shared',
      Case_Id__c = CaseId,
      VersionData = requestresponse,
      INAP_Doc_Type__c = 'Commencement',
      Ghost_Draft_Doc__c =true,
      NetworkId = Nwork[0].id,
      IsMajorVersion = true
    );
    insert contentVersion;    
    
    system.debug('**CV**'+contentVersion);
    List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument where title=:DocName];

    system.debug('**documents**'+documents);
    //create ContentDocumentLink  record 
    
    ContentDocumentLink cdl = New ContentDocumentLink();
    cdl.LinkedEntityId = CaseId;
    cdl.ContentDocumentId = documents[0].Id;
    cdl.shareType = 'V';
    insert cdl;
    
    Loss_Category_Files__c LossFiles =  new Loss_Category_Files__c();
    LossFiles.File_Url__c='/s/contentdocument/'+documents[0].Id;
    LossFiles.File_Name__c = DocName;
    LossFiles.CaseId__c = CaseId;
    LossFiles.Document_Type__c='Commencement';
    LossFiles.Document_Sharing_Permissions__c ='Shared';
    LossFiles.Uploaded_By__c = 'Claimant Handler';
    insert LossFiles;
    
  //  blob b=blob.valueOf(requestresponse);
    // Document d = [SELECT DeveloperName,Body FROM Document where DeveloperName='Dez_Bryant'];

    //Document newPDF = new Document(body = requestresponse,Developername='GX6',name='GX6.pdf',FolderId='00l0N0000017qoiQAA');
   // Insert newPDF;
    
    
    //GhostXML__c GhostXML = new GhostXML__c(XML__c=requestresponse);
   // Insert GhostXML;    

}

}