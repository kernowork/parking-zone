public with sharing class CustomFields {
    @AuraEnabled
    public static List<Option> getObjNames(){
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        List<String> keyNames = new List<String> (schemaMap.keySet());
        keyNames.sort();

        List<Option> objNames = new List<Option>();

        
        //find objects with custom fields
        for(String objName: keyNames) { 
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
        //the FieldDefinition query requires "Use default data sensitivity level to be check on Data Classification Settings"
        //this is the only way to easily retrieve the Description value (not available via DescribeFieldResult)
        List<FieldDefinition> fields = [SELECT Label, QualifiedApiName, (Select DataType From Particles), Description, DurableId FROM FieldDefinition 
                                        WHERE EntityDefinitionId = :objName ORDER BY Label];
        List<CustomField> fieldsList = new List<CustomField>();
        for(FieldDefinition f: fields) {
            if(f.QualifiedApiName.right(3) == '__c') {
                CustomField cf = new CustomField();
                cf.fieldName = f.QualifiedApiName;
                cf.fieldLabel = f.Label;
                String ep = String.valueOf(f.Particles);
                cf.fieldType = ep.substringBetween('DataType=','})');
                cf.fieldDescription = f.Description;
                cf.fieldDurableId = f.DurableId.substringAfter('.'); //DurableId has format 'objname.XXXXXXXXXXXXXXX'
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
        @AuraEnabled
        public String fieldDurableId {get; set;}
            
    }
        

}