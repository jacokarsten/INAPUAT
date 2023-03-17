({
    init: function (component, event, helper) {
	component.set('v.columns', [
            { label: 'Company / Employer Name', fieldName: 'Company_Employer_Name__c', editable: false, type: 'text', padding: 20},
            { label: 'Contact First Name', fieldName: 'Contact_First_Name__c', type: 'text', editable: false},
            { label: 'Contact Last Name', fieldName: 'Contact_Last_Name__c', type: 'text', editable: false},
                              
        ]); 
        helper.getData(component, event, helper);
    },
    
    viewRecord : function (component, event, helper) {
        var caseId = component.get('v.recordId');
        var recId = event.getParam('row').Id;
        var modalBody;
        $A.createComponent("c:DefendantCompanyEditForm", {recID: recId, caseID: caseId},
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
        var action = component.get('c.PLELDefendantRelatedList');
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