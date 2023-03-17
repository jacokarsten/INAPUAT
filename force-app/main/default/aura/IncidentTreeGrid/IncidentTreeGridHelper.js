({
	getData : function (cmp) {
        var action = cmp.get("c.getIncidents");
        var postalCode1 = cmp.get("v.postalCode");
        var incidentDate1 = cmp.get("v.incidentDate");
        var firmId1 = cmp.get("v.firmId");
        action.setParams({
            "postalCodeInput" : postalCode1 , "incidentDateInput" : incidentDate1, "firmIdInput" : firmId1
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
                cmp.set('v.gridData', data);
                
            }
            // error handling when state is "INCOMPLETE" or "ERROR"
        });
        
        $A.enqueueAction(action);
        
    }
})