import { LightningElement,track } from 'lwc';
import {subscribe} from 'lightning/empApi';
export default class PlatformEventTest extends LightningElement {

    Subscription = null;
    channelName = '/event/Test_Platform_Event__e';
     recordDetail='';

    connectedCallback() {
        this.handleSubscribe();
    }

    handleSubscribe() {
        const messageCallback = (response) => {
            console.log('response is :- ',JSON.parse(JSON.stringify(response)));
            console.log('response is :- ',JSON.parse(JSON.stringify(response)).data.payload.Description__c);
            this.recordDetail = JSON.parse(JSON.stringify(response)).data.payload.Description__c; 
            
        }

        subscribe(this.channelName , -1 , messageCallback).then((response) => {
            console.log('Subscription request send to : ' ,JSON.parse(JSON.stringify(response)) );
        })

        console.log('record details are : ',this.recordDetail);
    }

}