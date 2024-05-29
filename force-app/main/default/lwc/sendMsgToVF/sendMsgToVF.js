import { LightningElement } from 'lwc';
import sendMsg from '@salesforce/apex/sendMsgToVF.sendMsg';

export default class SendMsgToVF extends LightningElement {

    messageContext;

    sendMsgToVF() {
        console.log('hjvj');
        let msg = this.template.querySelector('[data-id="msg-to-be-send"]').value ; 
        console.log('message is : ',msg);
    
        sendMsg({my_message: msg}).then(res => {
            console.log('res is :- ',res);
        }).catch(err => {
            console.log('err is :- ',err);
        });
    }

}