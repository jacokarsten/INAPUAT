({
	getData: function(component, event, helper) {
        var action = component.get('c.getDefendantInfo');
        action.setParams({
            caseId : component.get("v.recordId")
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.data', response.getReturnValue());
                
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.log(errors);
            }
        });
		$A.enqueueAction(action);
    }
})