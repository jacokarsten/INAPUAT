({
	doInit: function (cmp, event, helper) {
        helper.getData(cmp);
    },
    
    handleClick: function (cmp, event, handler) {
        // When an option is selected, navigate to the next screen
        var response = event.target.id;
        cmp.set("v.incidentID", response);
        var navigate = cmp.get("v.navigateFlow");
        navigate("NEXT");
    },
    
    goToRecord : function (cmp, event) {
        var response = event.target.id;
        var urlEvent = $A.get("e.force:navigateToSObject");
        urlEvent.setParams({
            "recordId": response,
            "isredirect": "true"
        });
        urlEvent.fire();
    }
})