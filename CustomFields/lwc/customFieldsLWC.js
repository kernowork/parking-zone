/* eslint-disable no-console */
import { LightningElement, track, wire } from 'lwc';
import getObjNames from '@salesforce/apex/CustomFields.getObjNames';
import getObjCustomFields from '@salesforce/apex/CustomFields.getObjCustomFields';

const columns = [
    {label: 'Label', fieldName: 'fieldLabel', type:'text'},
            {label: 'Name', fieldName: 'fieldName', type:'text'},
            {label: 'Type', fieldName: 'fieldType', type:'text'},
            {label: 'Description', fieldName: 'fieldDescription', type:'text'},
];

export default class CustomFieldsLWC extends LightningElement {
    
    // get list of objects which have custom fields
    @track objOptions;
    @track loading = true;
    @wire(getObjNames) 
    options({
        error,
        data
    }) {
        if (data) {
            this.objOptions = data;
            console.log(data);
            console.log(JSON.stringify(data, null, '\t'));
            this.loading = false;
        } else if (error) {
            this.error = error;
        }
    }
    
    // get custom fields for selected object
    @track object;
    @track columns = columns;
    @track fields;
    @wire(getObjCustomFields , { objName: '$object' }) 
    customFields({
        error,
        data
    }) {
        if (data) {
            this.fields = data;
            console.log(data);
            console.log(JSON.stringify(data, null, '\t'));
        } else if (error) {
            this.error = error;
        }
    }
  
    handleChange(event) {
        this.object = event.detail.value;
        console.log(this.object);
        
    }
}