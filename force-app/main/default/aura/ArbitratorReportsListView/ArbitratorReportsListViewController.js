({
	init: function (component, event, helper) {
            helper.getData(component, event, helper);
            },
    
    goToRecord : function (component, event) {
        var response = event.target.id;
        var urlEvent = $A.get("e.force:navigateToSObject");
        urlEvent.setParams({
            "recordId": response,
            "isredirect": "true"
        });
        urlEvent.fire();
    }
    
})