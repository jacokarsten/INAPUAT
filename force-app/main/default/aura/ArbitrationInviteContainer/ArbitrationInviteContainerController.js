({
    init : function (cmp) {
        var flow = cmp.find("flowData");
        var inputVariables = [
         { name : "Case_User_Invitation_Id", type : "SObject", value: cmp.get("v.recordId") }
            ];
                flow.startFlow("Neg_Arbitrating_4_Arbitrator_Accept_Reject_Flow", inputVariables);
            },
             
             handleStatusChange : function (cmp, event) {
                 if(event.getParam("status") === "FINISHED") {
                     var outputVariables = event.getParam("outputVariables");
                     var outputVar;
                     for(var i = 0; i < outputVariables.length; i++) {
                         outputVar = outputVariables[i];
                         if(outputVar.name === "Selected_Case_Id") {
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