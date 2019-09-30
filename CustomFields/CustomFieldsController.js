({
    doInit : function(component, event, helper) {
        component.set('v.columns', [
            {label: 'Label', fieldName: 'fieldLabel', type:'text'},
            {label: 'Type', fieldName: 'fieldType', type:'text'},
            {label: 'Description', fieldName: 'fieldDescription', type:'text'},
        ]);
        helper.getObjectList(component);
    },
            
    getFields : function(component, event, helper) {
    	helper.getFieldList(component);
    },
            
    handleRowSelection : function(component, event, helper) {
        var selectedRow = component.find('dataTable').getSelectedRows();
        component.set("v.selectedId", selectedRow[0].Id);
    },
            
})