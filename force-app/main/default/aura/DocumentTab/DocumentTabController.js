({
	init: function (component, event, helper) {
        
        component.set('v.columns', [
            { label: 'Claimant First Name', fieldName: 'Claimant_First_Name__c', editable: false, type: 'text'},
            { label: 'Claimant Last Name', fieldName: 'Claimant_Last_Name__c', type: 'text', editable: false},
            { label: 'Claimant Date of Birth', fieldName: 'Claimant_Date_of_Birth__c', type: 'text', editable: false},
            { label: 'Vehicle Registration No', fieldName: 'Claimant_Vehicle_Registration_Number__c', type: 'text', editable: false},
            { label: 'Actions',
             type: "button", typeAttributes:
             {
                 label: 'Edit',
                 name: 'Edit',
                 title: 'Edit',
                 disabled: {fieldName: 'Editable__c'},
                 value: 'edit',
                 iconPosition: 'left',
                 variant: 'brand'
             }, initialWidth: 100
            }                  
        ]); 
        helper.getData(component, event, helper);
    },
})