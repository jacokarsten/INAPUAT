({
  init : function (cmp) {
    var flow = cmp.find("flowData");
    flow.startFlow("Create_New_Case_Flow");
  },

  handleStatusChange : function (cmp, event) {
   if(event.getParam("status") === "FINISHED") {
      var outputVariables = event.getParam("outputVariables");
      var outputVar;
      for(var i = 0; i < outputVariables.length; i++) {
         outputVar = outputVariables[i];
         if(outputVar.name === "outputCaseId") {
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