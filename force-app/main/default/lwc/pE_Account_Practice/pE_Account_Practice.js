import { LightningElement,api } from 'lwc';
import AccName from '@salesforce/schema/Contact.Name';
import Amount from '@salesforce/schema/Contact.Amount__c';
import Email from '@salesforce/schema/Contact.Email';
import AccountId from '@salesforce/schema/Contact.AccountId';

export default class PE_Account_Practice extends LightningElement {

    @api recordId;
    nameField = AccName;

    fields = [AccName , Amount , Email , AccountId];


    // connectedCallback() {
    //     console.log('value of record id is :- ',this.recordId);
        

    // }

    // btn_click() {
    //     console.log( this.template.querySelector["[data-id='name-inp']"].value );
    //     this.template.querySelector["[data-id='name-inp']"].value = '';
    // }

}