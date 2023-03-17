({
    init : function (component) {
                var flow = component.find("flowData");
                var inputVariables = [
                    { name : "varT_Case_Id", type : "String", value: component.get("v.caseID")},
                    ];
                flow.startFlow("Document_Upload", inputVariables);
            },
                
                
                handleStatusChange : function (component, event) {
                    if(event.getParam("status") === "FINISHED") {
                        var outputVariables = event.getParam("outputVariables");
                        var outputVar; 
                        
                        
                        for(var i = 0; i < outputVariables.length; i++) {
                            outputVar = outputVariables[i];
                            if(outputVar.name === "recordId") {
                                var urlEvent = $A.get("e.force:navigateToSObject");
                                urlEvent.setParams({
                                    "recordId": outputVar.value,
                                    "isredirect": "true"
                                });
                                urlEvent.fire();
                            }
                        }
                        /*
                        for(var i = 0; i < outputVariables.length; i++) {
                            outputVar = outputVariables[i];
                            if(outputVar.name === "recordId") {
                                var urlEvent = $A.get("e.force:navigateToURL");
                                urlEvent.setParams({
                                    "url": '/'+'outputVar.value'+'?tabset-7d6d1=176af'
                                });
                                urlEvent.fire();
                        
                    }
                }*/
                    }},
            
            
            
            
        })