import { LightningElement } from 'lwc';
import { subscribe} from 'lightning/empApi';
export default class SubscribeUsingPlatformEvent extends LightningElement {

    channelName = '/event/Test_Platform_Event__e';
    subscription = {};

    showMessage = '';
    connectedCallback(){
        this.handleSubscribe();
    }

    // proxyToObj(obj){
    //     return JSON.parse(JSON.stringify(obj));
    // }

    handleSubscribe() {
        const self = this;
        const messageCallback = function (response) {
            console.log('New message received 1: ', JSON.stringify(response));
            console.log('New message received 2: ', response);

            var obj = JSON.parse(JSON.stringify(response));
            console.log(obj.data.payload.Description__c);

            self.showMessage = obj.data.payload.Description__c ; 
            // var obj = JSON.parse(JSON.stringify(response));

            // self.data = self.proxyToObj(self.data);
            // self.data.push({RecordId__c : obj.data.payload.RecordId__c, Change_Type__c : obj.data.payload.Change_Type__c});
            // console.log('this.data -> ' + JSON.stringify(self.data));
        };
 
        subscribe(this.channelName, -1, messageCallback).then(response => {
            console.log('Subscription request sent to: ', JSON.stringify(response.channel));
            this.subscription = response;
        });
    }

}