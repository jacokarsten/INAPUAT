({
	init: function (component, event, helper) {
        
        component.set('v.columns', [
            { label: 'Name', fieldName: 'Name', editable: false, type: 'text', padding: 20 },
            { label: 'Role', fieldName: 'Role', editable: false, type: 'text'},
            { label: 'Email', fieldName: 'Email', type: 'email', editable: false},
            { label: 'Firm', fieldName: 'FirmName', type: 'text', editable: false},
                              
        ]); 
        helper.getData(component, event, helper);
    }
})