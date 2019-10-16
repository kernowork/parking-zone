import { LightningElement, track, wire} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import searchContacts from '@salesforce/apex/ContactController.searchContacts';

export default class ContactList extends NavigationMixin(LightningElement) {

	@track searchTerm = '';
	@wire(searchContacts, {searchTerm: '$searchTerm'}) contacts;
	@track contactId = '';


	handleSearchTermChange(event) {
		// Debouncing this method: do not update the reactive property as
		// long as this function is being called within a delay of 300 ms.
		// This is to avoid a very large number of Apex method calls.
		window.clearTimeout(this.delayTimeout);
		const searchTerm = event.target.value;
		// eslint-disable-next-line @lwc/lwc/no-async-operation 	 
		this.delayTimeout = setTimeout(() => {
			this.searchTerm = searchTerm;
		}, 300);
	}

	get hasResults() {
		return (this.contacts.data.length > 0);
	}

	handleContactSelect(event) {
		console.log('handleContactSelect');
		this.contactId = event.target.contact.Id;

		this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.contactId,
                objectApiName: 'Contact',
                actionName: 'view'
            }
        });
		
	}

}