import { LightningElement, api } from 'lwc';

export default class ContactTile extends LightningElement {
    @api contact;

    handleContactTileClick() {
        console.log('handleContactTileClick');
        const selectEvent = new CustomEvent('contactselected', {
            bubbles: true
        });
        this.dispatchEvent(selectEvent);
    }
}