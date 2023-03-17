({
	doInit : function(component,event,helper){
        	alert('In');
   			$A.get('e.force:refreshView').fire();
 	},
})