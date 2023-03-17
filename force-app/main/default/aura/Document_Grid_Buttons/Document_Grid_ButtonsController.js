({
    
    uploadDocument : function(cmp, event, helper) {
        var evt = $A.get("e.force:navigateToComponent");
        console.log('evt'+evt);
        var Case_Id = component.get("v.recordId");
        evt.setParams({
            componentDef: "c:File_Upload_Component" ,
            componentAttributes : {
                caseId : Case_Id
            }
        });
        evt.fire();
},
    
    linkDocument : function(cmp, event, helper) {
        var action = cmp.get('c.myController');
        action.setCallback(cmp,
                           function(response) {
                               var state = response.getState();
                               if (state === 'SUCCESS'){
                                   $A.get('e.force:refreshView').fire();
                               } else {
                                   console.log('File could not be linked');
                               }
                           }
                          );
        $A.enqueueAction(action);
    },
    
    refresh : function(cmp, event, helper) {
        var action = cmp.get('c.getData');
        action.setCallback(cmp,
                           function(response) {
                               var state = response.getState();
                               if (state === 'SUCCESS'){
                                   $A.get('e.force:refreshView').fire();
                               } else {
                                   console.log('Error');
                               }
                           }
                          );
        $A.enqueueAction(action);
    },
    
})