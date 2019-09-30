public with sharing class CustomFields {
    @AuraEnabled
    public static List<Option> getObjNames(){
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        List<Option> objNames = new List<Option>();
        
        //find objects with custom fields
        for(String objName: schemaMap.keySet()) { 
            if(objName.endsWith('changeevent')) {
                continue;
            }
            if(hasCustomFields(objName, schemaMap)) {
                Option p = new Option();
                p.label = schemaMap.get(objName).getDescribe().getLabel();
                p.value = objName;
                objNames.add(p);
                continue;
            }
        }  
        return objNames;
    }
    
    @AuraEnabled
    public static List<CustomField> getObjCustomFields(String objName) {
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String,Schema.SObjectField> fieldMap = schemaMap.get(objName).getDescribe().fields.getMap();
        List<CustomField> fieldsList = new List<CustomField>();
        
        for(String fieldName: fieldMap.keySet()) {       
            Boolean customField = fieldMap.get(fieldName).getDescribe().isCustom();
            if(customField) {            
                CustomField cf = new CustomField();
                cf.fieldName = fieldMap.get(fieldName).getDescribe().getName();
                cf.fieldLabel = fieldMap.get(fieldName).getDescribe().getLabel();
                cf.fieldType = String.valueOf(fieldMap.get(fieldName).getDescribe().getType());
                cf.fieldDescription = fieldMap.get(fieldName).getDescribe().getinlineHelpText();
                fieldsList.add(cf);
            }
        }
        return fieldsList;
        
        
    }
    
    public static boolean hasCustomFields(string objName, Map <String, Schema.SObjectType> schemaMap) {
        Map<String,Schema.SObjectField> fieldMap = schemaMap.get(objName).getDescribe().fields.getMap();
        for(String fieldName: fieldMap.keySet()) {       
            Boolean customField = fieldMap.get(fieldName).getDescribe().isCustom();
            if(customField) {
                return true;
            }
        }
        return false;
    }
    
    public class Option {
        @AuraEnabled
        public String label {get; set;}
        @AuraEnabled
        public String value {get; set;}
    }
    
    public class CustomField {
        @AuraEnabled
        public String fieldName {get; set;}
        @AuraEnabled
        public String fieldLabel {get; set;}
        @AuraEnabled
        public String fieldType {get; set;}
        @AuraEnabled
        public String fieldDescription {get; set;}
        
    }
}