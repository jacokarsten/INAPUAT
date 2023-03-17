({
	doInit : function(component) {
        var vfOrigin = "https://" + component.get("v.vfHost");
        console.log('LOSSITEMSA');
        
        window.addEventListener("message", function(event) {
            console.log(event.origin);
            console.log('LOSSITEMS');
            console.log('LOSSITEMS - ' + event.data);
            if (event.data != 'vfOriginL' && event.data != 'vfOriginA' && event.data != 'Finalised') {
                // Not the expected origin: Reject the message!
                console.log('FailITEM');
                return;
            }
            // Handle the message
            console.log('SuccessLITEM');
            //alert('In');
   			
            console.log(event.data);
            //window.location.reload();
            //
        //$A.get('e.force:refreshView').fire();    
        if(event.data == 'vfOriginA' || event.data == 'Finalised'){ 
         	var message = "vfArbOrigin";
            var vfOrigin ="/";    // "https://" + component.get("v.vfHost");
            console.log('SHOWFRAME');
        	var vfWindow = component.find("vfFrame").getElement().contentWindow;
            console.log('****vfWindow');
        	vfWindow.postMessage(message, vfOrigin);
            console.log('SENDARB');
        }
        if(event.data == 'vfOriginL' ){
            	$A.get('e.force:refreshView').fire();
            
            	var evt = $A.get("e.c:LossItems");
      				
      			evt.fire();
        }        
            
            
            
        }, false);
    }
})