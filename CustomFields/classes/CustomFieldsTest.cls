@isTest
private class CustomFieldsTest {
    
    @isTest
    private static void testGetObjNames() {
        CustomFields.getObjNames();
    }

    @isTest 
    private static void testGetObjCustomFields() {
        CustomFields.getObjCustomFields('Contact');
    }
}
