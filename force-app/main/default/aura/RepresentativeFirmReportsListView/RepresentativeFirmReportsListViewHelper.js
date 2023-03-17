({
	getData : function(component, event, helper) {
        var action = component.get('c.getInapReports');
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.reports', response.getReturnValue());
                
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.log(errors);
            }
        });
        $A.enqueueAction(action);
    }
})