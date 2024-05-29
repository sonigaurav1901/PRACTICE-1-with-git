// import { LightningElement } from 'lwc';
// import Object_Name from '@salesforce/schema/Account';
// import FIELD_NAME from '@salesforce/schema/Account.Name';
// import FIELD_INDUSTRY from '@salesforce/schema/Account.Industry';
// export default class LdsExample extends LightningElement {

//     Name='test LDS insert';
//     Industry= '	Agriculture';
//     accountObject = Object_Name;
//     myFields = [FIELD_NAME,FIELD_INDUSTRY];

//     handleAccountCreation(event) {
//         console.log('record got created : ',event.detail);
//     }

// }


import { LightningElement,api } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class FormErrorExample extends LightningElement {
  @api recordId;

  handleError(event) {
    console.log(event.detail);
    this.dispatchEvent(
      new ShowToastEvent({
        title: "Error creating record",
        message: event.detail.message,
        variant: "error",
      }),
    );
  }
}