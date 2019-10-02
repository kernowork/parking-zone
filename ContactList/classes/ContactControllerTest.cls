@isTest
private class ContactControllerTest {
	
    @testSetup
    private static void testData() {
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i<10; i++) {
            Account acc = new Account(Name='Test' + i);
            accounts.add(acc);
        }
        insert accounts;
        
        List<Contact> contacts = new List<Contact>();
        for(Integer i=0; i<10; i++) {
            Contact con = new Contact(FirstName='Test',LastName='Contact'+i);
            con.Birthdate = date.newInstance(1980, i, 1);
            con.HomePhone = '206-555-000'+i;
            con.Email = 'test' + i + '@test.test';
            con.MailingStreet = '100' + i + ' Some Pl';
            contacts.add(con);
        }
        insert contacts;
        
              
    }
    
   //////////////////////////////////////////////////////////////////////////////////////////////////
    
    @isTest static void testGetContactList() {
        List<Contact> result = ContactController.getContactList();
        System.assertEquals(10, result.size());        
    }
    
    @isTest static void testSearchContacts() {
        List<Contact> result;
        
        result = ContactController.searchContacts('');
        System.assertEquals(10, result.size());
        result = ContactController.searchContacts('est'); //name
        System.assertEquals(10, result.size());
        result = ContactController.searchContacts('0001'); //phone
        System.assertEquals(1, result.size());
        result = ContactController.searchContacts('1004 Some Pl'); //address
        System.assertEquals(1, result.size());
        
    }
    
    
}