({
    getObjectList : function(component) {
        var action = component.get("c.getObjNames");
        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS") {
             console.log('Found objects!'); 
             var result = response.getReturnValue();
             component.set("v.objectList", result);  
            } else {
                console.log('NO GOOD!');
            }
        });
        
        $A.enqueueAction(action);
    },
    
    getFieldList : function(component) {
        console.log('getFieldList');
        var action = component.get("c.getObjCustomFields");
        action.setParams({"objName": component.get("v.selectedValue")});
        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS") {
             console.log('Found fields!'); 
             var result = response.getReturnValue();
             console.log(result);
             component.set("v.customFields", result); 
             console.log(component.get("v.customFields"));
             component.set("v.loading", false);
            } else {
                console.log('NO GOOD!');
            }
        });
        
        $A.enqueueAction(action);
    },

    navigateToRecord: function(component, recId) {
        var navService = component.find("navService");
        
        var pageReference = {
            type: 'standard__recordPage',
            attributes: {
                "recordId": recId,
                "objectApiName": "Workshop__c",
                "actionName": "view"
            }
        }
        
        navService.navigate(pageReference); 
        $A.get('e.force:refreshView').fire();
    },
})