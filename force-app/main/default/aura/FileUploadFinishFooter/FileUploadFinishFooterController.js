({
	init : function(component, event, helper) {
      // Figure out which buttons to display
      var availableActions = component.get('v.availableActions');
      for (var i = 0; i < availableActions.length; i++) {
         if (availableActions[i] == "BACK") {
            component.set("v.canBack", false);
         } else if (availableActions[i] == "NEXT") {
            component.set("v.canNext", true);
         } else if (availableActions[i] == "FINISH") {
            component.set("v.canFinish", true);
         }
      }
   },
        
   onButtonPressed: function(component, event, helper) {
      // Figure out which action was called
      var actionClicked = event.getSource().getLocalId();
      // Fire that action
      var navigate = component.get('v.navigateFlow');
      navigate(actionClicked);
   }
})