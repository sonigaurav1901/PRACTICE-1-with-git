import { LightningElement, api } from 'lwc';
import fetchDataOfOpp from '@salesforce/apex/AccountRec_component_assignment.fetchDataOfOpp';
import chartjs from '@salesforce/resourceUrl/chartJsCDN'; 
import { loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class oppComplianceChartLWCAssignment extends LightningElement {

    @api accountId;
    cwPercentage = 0;
    clPercentage = 0;
    openPercentage = 0;
    chart;


    connectedCallback() {
        console.log('inside connected');
        fetchDataOfOpp();
        fetchDataOfOpp({AccId: this.accountId}).then(result => {
            var sum = result.cw + result.cl + result.open;
            console.log('sum is --> '+sum);
            this.cwPercentage =555 - result.cw/sum*555;
            this.clPercentage = 518 - result.cl/sum*518;
            this.openPercentage = 310 - result.open/sum*310;

            // console.log('percentage data of cw is :- ',this.cwPercentage);
            // console.log('percentage data of cl is :- ',this.clPercentage);
            // console.log('percentage data of open is :- ',this.openPercentage);

            var cwCircle = this.template.querySelector(`[data-id="cw"]`);
            cwCircle.style.strokeDashoffset = this.cwPercentage,'px';
            // console.log('cw circle is : ',cwCircle);
            var clCircle = this.template.querySelector(`[data-id="cl"]`);
            clCircle.style.strokeDashoffset = this.clPercentage,'px';
            // console.log('cl circle is : ',clCircle);
            var openCircle = this.template.querySelector(`[data-id="open"]`);
            openCircle.style.strokeDashoffset = this.openPercentage,'px';
            // console.log('open circle is : ',openCircle);

        }).catch(error => {
            console.log(error);
        });
    }

}