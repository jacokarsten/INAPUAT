({
    init : function (cmp) {
        var flow = cmp.find("flowData");
        var inputVariables = [{
            name : "varT_Case_Id", type : "String", value: cmp.get("v.recordId") },];
                              flow.startFlow("Document_Upload", inputVariables);
                              },
                              
                              handleStatusChange : function (cmp, event) {
                              if(event.getParam("status") === "FINISHED") {
                              var outputVariables = event.getParam("outputVariables");
                              var outputVar;
                              for(var i = 0; i < outputVariables.length; i++) {
                              outputVar = outputVariables[i];
        if(outputVar.name === "Uploaded_Document_Id") {
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