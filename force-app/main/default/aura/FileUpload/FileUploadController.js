({ 
    handleUploadFinished: function (component, event) {
        // Get the list of uploaded files
        var uploadedFiles = event.getParam('files');
        console.log(uploadedFiles);
        component.set("v.fileNames", uploadedFiles);
        
        $A.get('e.force:refreshView').fire();
        
        // Close the action panel
        var dismissActionPanel = $A.get('e.force:closeQuickAction');
        dismissActionPanel.fire();
        
    },
    
})