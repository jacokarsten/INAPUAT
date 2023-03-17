({
	getData : function (component) {
        var action = component.get("c.getCaseTeamMembers");
        var caseId = component.get("v.recordId");
        action.setParams({
            "caseIdInput" : caseId 
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var data = response.getReturnValue();
                console.log(data);
                for(var i=0; i<data.length; i++) {
                    data[i]._children = data[i]['items'];
                    delete data[i].items;
                }
                component.set('v.gridData', data);
            }
            // error handling when state is "INCOMPLETE" or "ERROR"
        });
        
        $A.enqueueAction(action);
        
    }
})