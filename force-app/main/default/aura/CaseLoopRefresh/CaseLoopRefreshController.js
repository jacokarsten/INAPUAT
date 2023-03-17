({
	doInit : function(component, event, helper) {
		window.setInterval(                
                $A.getCallback(function() { 
                    $A.get('e.force:refreshView').fire();
                }), 5000
            );
	}
})