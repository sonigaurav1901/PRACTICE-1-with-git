import { LightningElement,api } from 'lwc';
import getFieldLableAndFieldAPI from '@salesforce/apex/fieldSetController.getFieldLableAndFieldAPI';
import showAccount from '@salesforce/apex/fieldSetController.showAccount';
export default class TestFieldSetOnAccount extends LightningElement {

    @api recordId;
    FieldsApiNames = [];
    ObjectApiName = 'Account';

    connectedCallback() {
        try {
            if(this.recordId != null) {
                console.log('record id is : ',this.recordId);
            } else {
                console.log('Error : Record Id is not found');
            }

            getFieldLableAndFieldAPI({}).then( result => {
                JSON.parse(result).forEach(obj => {
                    this.FieldsApiNames = this.FieldsApiNames.concat(Object.values(obj));
                });

                console.log('values are : ',JSON.stringify(this.FieldsApiNames));
            }).catch(error => {
                console.log('apex data exception = ',error);     
            })

        } catch(error) {
            console.log('Exception occur = ',error);
        }
        

    }

    showAccount() {
        let stringField = JSON.stringify(this.FieldsApiNames);
        stringField = stringField.replaceAll('\"', '');
        stringField = stringField.replaceAll('[', '');
        stringField = stringField.replaceAll(']', '');
        console.log('fields : ',stringField);

        showAccount({ recID:this.recordId , fields:stringField , ObjectName:this.ObjectApiName }).then(accRec => {
            console.log('accRec is : ',accRec);
        }).catch(error => {

        })

    }

}