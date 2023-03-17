({
     
    invoke : function(component) {
      	/*
        
      				
        evt.fire();
        
        $A.get('e.force:refreshView').fire();
        var evt2 = $A.get("e.c:ArbitrationItems");
      				
        evt2.fire();
        */
        
        
        /*
       		var message = "vfArbOrigin";
            var vfOrigin = 'https://inap5-k3.cs108.force.com/apex/ArbitrationItemsList2'
            console.log('SHOWFRAME');
        	//var vfWindow = component.find("vfFrame").getElement().contentWindow;
            var vfWindow = 'https://inap5-k3.cs108.force.com/apex/ArbitrationItemsList2?id=5001l000002LtFjAAK'	
        	console.log('****vfWindow');
       		vfWindow.postMessage(message, vfOrigin);
            console.log('SENDARB'); 
        */
        
        
        
      //  $A.get('e.force:refreshView').fire(); 
        
    },
    
    
	doInit : function(component) {
        var vfOrigin = "https://" + component.get("v.vfHost");
        window.addEventListener("message", function(event) {
            console.log(event.origin);
            console.log(vfOrigin);
            console.log(event.data);
            if ( event.data != 'vfOriginQ' && event.data !='Finalised') {
                // Not the expected origin: Reject the message!
                console.log('Fail');
                return;
            }
            // Handle the message
            
            //alert('In');
   			
            console.log(event.data);
            
             
         	 $A.get('e.force:refreshView').fire();
             
            
           
           /*  
            if(event.data == 'Finalised'){
            	
            console.log('FINALISED IN');
            	var evt = $A.get("e.c:LossItems");
      				
      			evt.fire();
            
            	
                var evt2 = $A.get("e.c:ArbitrationItems");
      				
      			evt2.fire();
                
                $A.get('e.force:refreshView').fire();
            }
             
            if(event.data == 'vfOriginQ'){
            	
            	$A.get('e.force:refreshView').fire();
            	//var evt = $A.get("e.c:LossItems");
      				
      			//evt.fire();
                
                
                //var evt2 = $A.get("e.c:ArbitrationItems");
      				
      			//evt2.fire();
                
                
                
            }
            */
            
            /*
            
            var message = "vfArbOrigin";
            var vfOrigin = "https://" + component.get("v.vfHost");
        	var vfWindow = component.find("vfFrame").getElement().contentWindow;
        	//var vfWindow = component.find("vfOrigin").getElement().contentWindow;
        	
            vfWindow.postMessage(message, vfOrigin);
            console.log('SENDARB');
           */
            
        }, false);
    }
})