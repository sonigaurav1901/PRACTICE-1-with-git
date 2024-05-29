import { LightningElement } from 'lwc';
import fetchOnLoad from '@salesforce/apex/fetchOppAcc.fetchOnLoad' 
import insertPayment from '@salesforce/apex/fetchOppAcc.insertPayment' 


export default class PaymentTaskOfOpp extends LightningElement 
{
    data ; 
    paymentpopup = false ; 
    rowId = null ;
    rowName = null ;

    // actions = [
    //         { label: 'Payment', name: 'Payment' },
    //         { label: 'Void', name: 'Void' },
    //         { label: 'Refund', name: 'Refund' },.

    // ];
    
    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Account Name', fieldName: 'AccountName' },
        { label: 'Amount', fieldName: 'Amount' },
        { label: 'Opportunity Stage', fieldName: 'StageName' },
        // { label: 'Payment', fieldName: 'payment__c' },
        { label: 'Payment', type: 'paymentss', fieldName: 'Id' },
        {
            type: 'action',
            typeAttributes: { rowActions: this.getRowActions },
        },
    ];



    connectedCallback()
    {
        fetchOnLoad().then(result=> {
            console.log('OUTPUT : ');

            result.forEach(element => {
                console.log('element : ',element);
                if (element.Account)
                {
                    console.log('Account : ',element.Account);
                    element.AccountName = element.Account.Name; 
                }
                else {
                    element.AccountName = '';
                }
                //console.log('element2 : ',element.Account.Name);
            });
            console.log('res--- ', result);
            this.data = result ;    
            
        }).catch(error=> {
            console.log('err--- ',error);    
        })
    }

    getRowActions(row, doneCallback)
    {

        console.log(row);
        console.log('inside get row');
        let actions = [];

        console.log('Amount',row.Amount);
        console.log('row Amount',row.payed_Amount__c);
        
        if(row.payed_Amount__c >= row.Amount )
        {
            console.log('Amount is greator ....');
            actions = [
                //{ label: 'Payment', name: 'Payment' },
                { label: 'Void', name: 'Void' },
                { label: 'Refund', name: 'Refund' },
            ];
        }
        else
        {
            console.log('Amount is less');
            actions = [
                { label: 'Payment', name: 'Payment' },
                { label: 'Void', name: 'Void' },
                { label: 'Refund', name: 'Refund' },
            ];
        }

        doneCallback( actions );

        fetchOnLoad().then(result=> {
            
            result.forEach(element => {
                element.AccountName = element.Account.Name ; 
            });
            console.log('res--- ', result);
            this.data = result ;    
            
        }).catch(error=> {
            console.log('err--- ',error);    
        })
    }


    handleRowAction(event) 
    {

        try {
            console.log('to find id --------> ',event.detail.row.Id);
            const actionName = event.detail.action.name;
            const row = event.detail.row;
            this.rowId = event.detail.row.Id ;
            this.rowName = event.detail.row.Name;
            switch (actionName) {
                // payment working...
                case 'Payment':
                    //this.deleteRow(row);
                    console.log(this.rowName);
    
                    
                    this.paymentpopup=true ;
                    console.log('payment');
                    setTimeout(() => {
                        this.template.querySelector('[data-id="ownerName"]').value = this.rowName;
                    }, 50);
    
                    fetchOnLoad().then(result=> {
                
                        result.forEach(element => {
                            element.AccountName = element.Account.Name ; 
                        });
                        console.log('res--- ', result);
                        this.data = result ;    
                        
                    }).catch(error=> {
                        console.log('err--- ',error);    
                    })
    
                    break;
                // void working...
                case 'Void':
                    // this.showRowDetails(row);
                    console.log('void');
                    break;
                // refund working...
                case 'Refund':
                    // this.showRowDetails(row);
                    console.log('refund');
                    break;
                default:
            }
            
        } catch (error) {
            console.log('error is : ',error);
        }
    }


    closePaymentpopup()
    {
        // console.log('close modal');
        this.paymentpopup=false ;
    }
    submitPaymentpopup()
    {
        // console.log('save modal');

        let ownerNa = this.template.querySelector('[data-id="ownerName"]').value ;
        console.log('Owner Name is --> ',ownerNa);

        let cardNu = this.template.querySelector('[data-id="cardNumber"]').value ;
        console.log('Card Number is --> ',cardNu);
        
        let mon = this.template.querySelector('[data-id="month"]').value ;
        let ye = this.template.querySelector('[data-id="year"]').value ;
        let cv = this.template.querySelector('[data-id="cvv"]').value ;
        
        console.log('Card Month year and cvv is --> ',mon,'--',ye,'--',cv);
        
        let amtPay = this.template.querySelector('[data-id="amountPayable"]').value ;
        console.log('Amount payable --> ',amtPay);
        console.log('ROW ID ---> '+this.rowId);
        insertPayment({'ownerNa':ownerNa,'cardN':cardNu,'mont':mon,'yea':ye,'cv':cv,'amt':amtPay,'rowId':this.rowId }).then(result=>{
            console.log('inserted rec ',result);
        }).catch(error=>{
            console.log(error);
        });

        this.paymentpopup=false ;

        // updated data display after submit
        fetchOnLoad().then(result=> {
            
            result.forEach(element => {
                if(element.payed_Amount__C >= element.Amount )
                {
                    this.actions = [
                        //{ label: 'Payment', name: 'Payment' },
                        { label: 'Void', name: 'Void' },
                        { label: 'Refund', name: 'Refund' },
                    ];
                }
                else
                {
                    this.actions = [
                        { label: 'Payment', name: 'Payment' },
                        { label: 'Void', name: 'Void' },
                        { label: 'Refund', name: 'Refund' },
                    ];
                }
                element.AccountName = element.Account.Name ; 
            });
            //console.log('res--- ', result);
            this.data = result ;    
            
        }).catch(error=> {
            console.log('err--- ',error);    
        })

    }
}