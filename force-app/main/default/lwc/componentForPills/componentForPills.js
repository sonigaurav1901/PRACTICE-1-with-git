import { LightningElement , api } from 'lwc';
import fetchPayment from '@salesforce/apex/fetchOppAcc.fetchPayment'
import fetchPaymentdetails from '@salesforce/apex/fetchOppAcc.fetchPaymentdetails'

export default class ComponentForPills extends LightningElement {
    @api value;
    data ;
    // idd = value ;
    connectedCallback()
    {

        fetchPayment({'i':this.value}).then(result=> {
           
            console.log('res--- ', result);
            this.data = result ;    
            
        }).catch(error=> {
            console.log('err--- ',error);    
        })

    }

    handleClick(event)
    {
        let ide ; 
        let sno = event.target.label ;
        console.log('idee is --> ',sno);

        fetchPaymentdetails({'i':sno}).then(result=> {
           
            //console.log('payment deatils are --- ', result);
            
            console.log(result[0].Id);
            ide = 'https://cyntexa92-dev-ed.lightning.force.com/lightning/r/Payment_obj__c/'+ result[0].Id+'/view';
            
            location.replace(ide);
        }).catch(error=> {
            console.log('err--- ',error);    
        })

    }

}