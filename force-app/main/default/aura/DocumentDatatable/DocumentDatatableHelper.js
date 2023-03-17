({
    requiredValidation : function(component,event) {
        // get all accounts.. 	
        var allRecords = component.get("v.DocumentList");
        var isValid = true;
        // play a for loop on all account list and check that account name is not null,   
        for(var i = 0; i < allRecords.length;i++){
            if(allRecords[i].Title == null || allRecords[i].Title.trim() == ''){
                alert('Complete this field : Row No ' + (i+1) + ' Title is null' );
                isValid = false;
            }  
        }
        return isValid;
    },
})