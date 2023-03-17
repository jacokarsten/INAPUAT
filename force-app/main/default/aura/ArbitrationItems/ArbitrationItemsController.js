({
	/*
    invoke : function(component, event, helper) {
       		//$A.get('e.force:refreshView').fire(); 
        	
        	console.log('SHOWFRAME');
        
       		var message = "vfITEMOrigin";
            var vfOrigin = "https://" + component.get("v.vfHost");
            console.log('SHOWFRAME');
        	//var vfWindow = component.find("vfFrame").getElement().contentWindow;
           // var vfWindow = 'https://inap5-k3.cs108.force.com/apex/ArbitrationItemsList2?id=5001l000002Lmk6AAC'	
        	console.log('****vfWindow');
        //	vfWindow.postMessage(message, vfOrigin);
            console.log('SENDARB');
            
            $A.get('e.force:refreshView').fire(); 
       
        
    },
    */
    doInit : function(component,event, helper) {
         
        var vfOrigin = "https://" + component.get("v.vfHost");
        console.log('ARBITEMS');
        
        window.addEventListener("message", function(event) {
            console.log(event.origin);
            console.log(event.data);
            console.log('ARBITEMS - '); // + event.data
            
             
            if (event.data != 'vfOriginL' && event.data != 'vfOriginA' && event.data != 'Finalised') {
                // Not the expected origin: Reject the message!
                console.log('FailArbITEM');
                return;
            }
             
            
            // Handle the message
            console.log('ARBLITEM');
            //alert('In');
   			
            console.log(event.data);
            //window.location.reload();
            //
            
           if(event.data == 'vfOriginL' || event.data == 'Finalised'){   
         	var message = "vfITEMOrigin";
            var vfOrigin ="/"; //"https://" + component.get("v.vfHost");
            
        	var vfWindow = component.find("vfFrame").getElement().contentWindow;
            console.log('****vfWindow');
        	vfWindow.postMessage(message, vfOrigin);
            console.log('SENDARB');
           } 
            $A.get('e.force:refreshView').fire();
       
        }, false);
        
    }
})