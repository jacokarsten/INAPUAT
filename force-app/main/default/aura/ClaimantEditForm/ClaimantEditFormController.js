({
    handleLoad: function(component, event, helper) {
        component.set('v.showSpinner', false);
        $A.util.removeClass(component.find("FirstName"), "none");
        $A.util.removeClass(component.find("LastName"), "none");
        $A.util.removeClass(component.find("DOB"), "none");
        $A.util.removeClass(component.find("VehicleRegNo"), "none");
    },
    
    handleSubmit: function(component, event, helper) {
        component.set('v.disabled', true);
        component.set('v.showSpinner', true);
    },
    
    /* handleError: function(component, event, helper) {
        // errors are handled by lightning:inputField and lightning:nessages
        // so this just hides the spinnet
        component.set('v.showSpinner', false);
    }, */
    
    refresh : function(component, event, helper) {
        var caseId = component.get("v.caseID");
        var tabId = component.get("v.tabID");
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/s/case/"+ caseId + "/detail?" + tabId
        });
        urlEvent.fire();
    }
    
    
})