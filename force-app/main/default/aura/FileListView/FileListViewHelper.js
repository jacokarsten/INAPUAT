({
        getData : function(component, event, helper) {
        var action = component.get('c.getFiles');
        action.setParams({
            caseID : component.get("v.caseId")
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.singleRec', response.getReturnValue());
                
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.log(errors);
            }
        });
        $A.enqueueAction(action);
    },
    
    
    // fetch picklist values dynamic from apex controller 
    fetchPickListVal: function(component, fieldName, picklistOptsAttributeName) {
        var action = component.get("c.getselectOptions");
        action.setParams({
            "objObject": component.get("v.objInfoForPicklistValues"),
            "fld": fieldName
        });
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
 
                if (allValues != undefined && allValues.length > 0) {
                    opts.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.set("v." + picklistOptsAttributeName, opts);
            }
        });
        $A.enqueueAction(action);
    },
    

    saveEdition: function (component, draftValues) {
        var self = this;
        // simulates a call to the server, similar to an apex controller.
        this
         /* .server
        .updateOpportunities(draftValues) */
        .then($A.getCallback(function (response) {
            var state = response.state;
            
            if (state === "SUCCESS") {
                var returnValue = response.returnValue;
                
                if (Object.keys(returnValue.errors).length > 0) {
                    // the draft values have some errors, setting them will show it on the table
                    component.set('v.errors', returnValue.errors);
                } else {
                    // Yay! success, initialize everything back
                    component.set('v.errors', []);
                    component.set('v.draftValues', []);
                    self.fetchData(component);
                }
            } else if (state === "ERROR") {
                var errors = response.error;
                console.error(errors);
            }
        }));
    },
    
    
})