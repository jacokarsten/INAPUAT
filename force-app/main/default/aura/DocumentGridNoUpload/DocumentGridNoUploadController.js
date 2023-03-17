({
    initRecords: function(component, event, helper) {
        // call the apex class method and fetch document list  
        var action = component.get("c.getFiles");
        action.setParams({
            caseID : component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                console.log(JSON.stringify(storeResponse));
                // set AccountList list with return value from server.
                component.set("v.DocumentList", storeResponse);
            }
        });
        $A.enqueueAction(action);
    },
    
    
    
})