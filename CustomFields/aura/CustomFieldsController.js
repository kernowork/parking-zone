({
    doInit : function(component, event, helper) {
        component.set('v.columns', [
            {label: 'Label', fieldName: 'fieldLabel', type:'text'},
            {label: 'Name', fieldName: 'fieldName', type:'text'},
            {label: 'Type', fieldName: 'fieldType', type:'text'},
            {label: 'Description', fieldName: 'fieldDescription', type:'text'},
        ]);
        helper.getObjectList(component);
        helper.getFieldList(component);
    },

    handleChange : function(component, event, helper) {
    	helper.getFieldList(component);
    },
            
            
})