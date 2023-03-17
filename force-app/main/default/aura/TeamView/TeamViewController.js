({
    init: function (component, event, helper) {
        component.set('v.mycolumns', [
            { label: 'Team Member', fieldName: 'Name', editable: false, type: 'text', sortable: true},
            { label: 'Team Name', fieldName: 'Team', editable: false, type: 'text', sortable: true},
            { label: 'Role', fieldName: 'Role', editable: false, type: 'text', sortable: true},
            { label: 'Email', fieldName: 'Email', editable: false, type: 'email', sortable: true},
            { label: 'Status', fieldName: 'Status', editable: false, type: 'text', sortable: true}
        ]); 
        var action = component.get("c.getFirmTeamRoles");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.teams", response.getReturnValue());
                helper.sortData(component, component.get("v.sortedBy"), component.get("v.sortedDirection"));
            }
        });
        $A.enqueueAction(action);
    },
    
    updateColumnSorting: function (component, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        component.set("v.sortedBy", fieldName);
        component.set("v.sortedDirection", sortDirection);
        helper.sortData(component, fieldName, sortDirection);
    }
    
})