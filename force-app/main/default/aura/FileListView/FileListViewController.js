({
    
    
    init : function(component, event, helper) {
  
      // call the fetchPickListVal(component, field_API_Name, aura_attribute_name_for_store_options) -
      // method for get picklist values dynamic   
        helper.fetchPickListVal(component, 'INAP_Doc_Type__c', 'inapDocTypePicklist');
        helper.fetchPickListVal(component, 'Sharing_Permissions__c', 'sharingPermissionsPicklist');
    }, 
    
    
    
    inlineEditName : function(component,event,helper){   
        // show the name edit field popup 
        component.set("v.nameEditMode", true); 
        // after the 100 millisecond set focus to input field   
        setTimeout(function(){ 
            component.find("inputId").focus();
        }, 100);
    },
    
            
    inlineEditDocType : function(component,event,helper){   
        // show the rating edit field popup 
        component.set("v.inapDocTypeEditMode", true); 
        // after set ratingEditMode true, set picklist options to picklist field 
        component.find("docType").set("v.options" , component.get("v.inapDocTypePicklist"));
        // after the 100 millisecond set focus to input field   
        setTimeout(function(){ 
            component.find("docType").focus();
        }, 100);
    },
    
    inlineEditSharingPermissions : function(component,event,helper){   
        // show the rating edit field popup 
        component.set("v.sharingPermissionsEditMode", true); 
        // after set ratingEditMode true, set picklist options to picklist field 
        component.find("sharingPermissions").set("v.options" , component.get("v.sharingPermissionsPicklist"));
        // after the 100 millisecond set focus to input field   
        setTimeout(function(){ 
            component.find("sharingPermissions").focus();
        }, 100);
    },
    
     onNameChange : function(component,event,helper){ 
        // if edit field value changed and field not equal to blank,
        // then show save and cancel button by set attribute to true
        if(event.getSource().get("v.value").trim() != ''){ 
            component.set("v.showSaveCancelBtn",true);
        }
    },
 
    onDocTypeChange : function(component,event,helper){ 
        // if picklist value change,
        // then show save and cancel button by set attribute to true
        component.set("v.showSaveCancelBtn",true);
    },
    
    onSharingPermissionsChange : function(component,event,helper){ 
        // if picklist value change,
        // then show save and cancel button by set attribute to true
        component.set("v.showSaveCancelBtn",true);
    },
    
    closeNameBox : function (component, event, helper) {
      // on focus out, close the input section by setting the 'nameEditMode' att. as false   
        component.set("v.nameEditMode", false); 
      // check if change/update Name field is blank, then add error class to column -
      // by setting the 'showErrorClass' att. as True , else remove error class by setting it False   
        if(event.getSource().get("v.value").trim() == ''){
            component.set("v.showErrorClass",true);
        }else{
            component.set("v.showErrorClass",false);
        }
    }, 
    
    closeDocTypeBox : function (component, event, helper) {
       // on focus out, close the input section by setting the 'ratingEditMode' att. as false
        component.set("v.inapDocTypeEditMode", false); 
    },
    
    closeSharingPermissionsBox : function (component, event, helper) {
       // on focus out, close the input section by setting the 'ratingEditMode' att. as false
        component.set("v.sharingPermissionsEditMode", false); 
    },
    
   
})