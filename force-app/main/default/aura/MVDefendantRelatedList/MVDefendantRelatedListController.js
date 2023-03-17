({
    init: function (component, event, helper) {
        
        component.set('v.columns', [
            { label: 'Defendant First Name', fieldName: 'Defendant_First_Name__c', editable: false, type: 'text', padding: 20},
            { label: 'Defendant Last Name', fieldName: 'Defendant_Last_Name__c', type: 'text', editable: false},
            { label: 'Defendant Date of Birth', fieldName: 'Defendant_Date_of_Birth__c', type: 'text', editable: false},
            { label: 'Vehicle Registration No', fieldName: 'Defendant_Vehicle_Registration_Number__c', type: 'text', editable: false},
            { label: 'Actions',
             type: "button", typeAttributes:
             {
                 label: 'Edit',
                 name: 'Edit',
                 title: 'Edit',
                 disabled: { fieldName: 'Editable__c'},
                 value: 'edit',
                 iconPosition: 'left',
                 variant: 'brand'
             }, initialWidth: 100
            }                  
        ]); 
        helper.getData(component, event, helper);
    },
    
    
    
    viewRecord : function (component, event, helper) {
        var caseId = component.get('v.recordId');
        var recId = event.getParam('row').Id;
        var modalBody;
        
        $A.createComponent("c:DefendantPersonEditForm", {recID: recId, caseID: caseId},
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   modalBody = content;
                                   component.find('overlayLib').showCustomModal({
                                       header: "Edit Defendant Information",
                                       body: modalBody,
                                       showCloseButton: true,
                                       cssClass: "mymodal",
                                       closeCallback: function() {
                                           ;
                                       }
                                   })
                               }
                           });
                           
    },
    
    refresh : function(component, event, helper) {
        var action = component.get('c.MVDefendantRelatedList');
        action.setCallback(component,
                           function(response) {
                               var state = response.getState();
                               if (state === 'SUCCESS'){
                                   $A.get('e.force:refreshView').fire();
                               } else {
                                   //do something
                               }
                           }
                          );
        $A.enqueueAction(action);
    }
})