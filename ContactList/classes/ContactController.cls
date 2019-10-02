public with sharing class ContactController {
    
    @AuraEnabled(Cacheable=true)
    public static Contact[] getContactList() {
        return [SELECT Id, AccountId, Name, HomePhone, Email, MailingStreet, Birthdate FROM Contact ORDER BY Name LIMIT 50];
    }
    

    @AuraEnabled(Cacheable=true)
    public static Contact[] searchContacts(String searchTerm) {
        // Return all contacts when no search term
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return getContactList();
        }
        // Prepare query paramters
        searchTerm = '%'+ searchTerm +'%';
        // Execute search query
        return [SELECT Id, AccountId, Name, HomePhone, Email, MailingStreet, Birthdate FROM Contact WHERE Name LIKE :searchTerm 
        OR HomePhone LIKE :searchTerm OR MailingStreet LIKE :searchTerm ORDER BY Name LIMIT 50];
    }
    
}