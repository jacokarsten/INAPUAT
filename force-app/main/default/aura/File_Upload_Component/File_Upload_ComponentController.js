({
  init : function (cmp) {
    var flow = cmp.find("flowData");
      var inputVariables = [
      {
        name : 'caseId',
        type : 'String',
        value : '<Case.Id>'
      }];
    flow.startFlow("Document_Upload");
  },

  handleStatusChange : function (cmp, event) {
   if(event.getParam("status") === "FINISHED") {
      var outputVariables = event.getParam("outputVariables");
      var outputVar;
      for(var i = 0; i < outputVariables.length; i++) {
         outputVar = outputVariables[i];
         if(outputVar.name === "Case_Id") {
            var urlEvent = $A.get("e.force:navigateToSObject");
            urlEvent.setParams({
               "recordId": outputVar.value,
               "isredirect": "true"
            });
            urlEvent.fire();
         }
      }
   }
}
    })