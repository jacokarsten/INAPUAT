({
    initRecords: function(component, event, helper) {
        var availableActions = component.get('v.availableActions');
        for (var i = 0; i < availableActions.length; i++) {
            if (availableActions[i] == "BACK") {
                component.set("v.canBack", false);
            } else if (availableActions[i] == "NEXT") {
                component.set("v.canNext", true);
            } else if (availableActions[i] == "FINISH") {
                component.set("v.canFinish", true);
            }
        }
        // call the apex class method and fetch document list  
        var action = component.get("c.getFiles");
        action.setParams({
            caseID : component.get("v.caseId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                console.log(JSON.stringify(storeResponse));
                // set DocumentList list with return value from server.
                component.set("v.DocumentList", storeResponse);
            }
        });        
        $A.enqueueAction(action);
    },
    
    
    
    Save: function(component, event, helper) {
        // Check required fields(Name) first in helper method which is return true/false
        if (helper.requiredValidation(component, event)){
            // call the saveAccount apex method for update inline edit fields update 
            var action = component.get("c.saveContentVersion");
            action.setParams({
                'lstContentVersion': component.get("v.DocumentList")
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var storeResponse = response.getReturnValue();
                    // set AccountList list with return value from server.
                    component.set("v.DocumentList", storeResponse);
                    // Hide the save and cancel buttons by setting the 'showSaveCancelBtn' false 
                    component.set("v.showSaveCancelBtn",false);
                    component.set("v.canFinish",true);
                    
                }
            });
            $A.enqueueAction(action);
        } 
    },
    
    cancel : function(component,event,helper){
        // on cancel refresh the view (This event is handled by the one.app container. It’s supported in Lightning Experience, the Salesforce app, and Lightning communities. ) 
        $A.get('e.force:refreshView').fire(); 
    },
    
    onButtonPressed: function(component, event, helper) {
        // Figure out which action was called
        var actionClicked = event.getSource().getLocalId();
        // Fire that action
        var navigate = component.get('v.navigateFlow');
        navigate(actionClicked);
    }    
    
    
})