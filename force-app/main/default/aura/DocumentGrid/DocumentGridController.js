({
    
    
    initRecords: function(component, event, helper) {
        // call the apex class method and fetch account list  
        var action = component.get("c.getFiles");
        action.setParams({
            caseID : component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                console.log(JSON.stringify(storeResponse));
                // set AccountList list with return value from server.
                component.set("v.DocumentList", storeResponse);
            }
        });
        $A.enqueueAction(action);
        
        component.set('v.columns', [
            {label: 'No', type: 'number'},
            {label: 'Title', fieldName: 'Title', type: 'text'},
            {label: 'Document Type', fieldName: 'INAP_Doc_Type__c', type: 'text'},
            {label: 'Date / Time', fieldName: 'ContentModifiedDate', type: 'date'}
            ]);
    },
    
    Save: function(component, event, helper) {
        // Check required fields(Name) first in helper method which is return true/false
        if (helper.requiredValidation(component, event)){
            // call the saveAccount apex method for update inline edit fields update 
            var action = component.get("c.saveContentVersion");
            action.setParams({
                'lstContentVersion': component.get("v.DocumentList")
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var storeResponse = response.getReturnValue();
                    // set AccountList list with return value from server.
                    component.set("v.DocumentList", storeResponse);
                    // Hide the save and cancel buttons by setting the 'showSaveCancelBtn' false 
                    component.set("v.showSaveCancelBtn",false);
                    
                    
                }
            });
            $A.enqueueAction(action);
        } 
    },
    
    cancel : function(component,event,helper){
        // on cancel refresh the view (This event is handled by the one.app container. It’s supported in Lightning Experience, the Salesforce app, and Lightning communities. ) 
        $A.get('e.force:refreshView').fire(); 
    }, 
    
    
    
    uploadDocument : function (component, event, helper) {
        var Id = component.get('v.recordId');
        var modalBody;
        $A.createComponent("c:FileUploadModal", {caseID: Id},
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   modalBody = content;
                                   component.find('overlayLib').showCustomModal({
                                       header: "Document Upload",
                                       body: modalBody,
                                       showCloseButton: true,
                                       cssClass: "slds-modal_medium",
                                       closeCallback: function() {
                                           ;
                                       }
                                   })
                               }
                           });
    },
    
    init: function (component, event, helper) {
        component.set('v.columns', [
            {label: 'Opportunity name', fieldName: 'opportunityName', type: 'text'},
            {label: 'Account name', fieldName: 'accountName', type: 'text'},
            {label: 'Close date', fieldName: 'closeDate', type: 'date'},
            {label: 'Confidence', fieldName: 'confidence', type: 'percentage'},
            {label: 'Amount', fieldName: 'amount', type: 'currency', typeAttributes: { currencyCode: 'EUR', maximumSignificantDigits: 5}},
            {label: 'Contact Email', fieldName: 'contact', type: 'email'},
            {label: 'Contact Phone', fieldName: 'phone', type: 'phone'},
            {label: 'Website', fieldName: 'website', type: 'url', typeAttributes: { target: '_self'}},
            {label: 'Address', fieldName: 'address', type: 'location'}
        ]);
        helper.getData();
    }
    
    
    
    
})