({
    handleLoad: function(component, event, helper) {
        component.set('v.showSpinner', false);
        $A.util.removeClass(component.find("CompanyName"), "none");
        $A.util.removeClass(component.find("ContactFirstName"), "none");
        $A.util.removeClass(component.find("ContactLastName"), "none");
        $A.util.removeClass(component.find("AddressLine1"), "none");
        $A.util.removeClass(component.find("City"), "none");
        $A.util.removeClass(component.find("Country"), "none");
        $A.util.removeClass(component.find("PostalCode"), "none");
    },
    
    handleSubmit: function(component, event, helper) {
        component.set('v.disabled', true);
        component.set('v.showSpinner', true);
    },
    
    handleError: function(component, event, helper) {
        // errors are handled by lightning:inputField and lightning:nessages
        // so this just hides the spinnet
        component.set('v.showSpinner', false);
    },
    
    refresh : function(component, event, helper) {
        var caseId = component.get("v.caseID");
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/s/case/"+ caseId +"/detail?tabset-7d6d1=ed6e1"
        });
        urlEvent.fire();
    },
    
    
    
    
})