import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import csvFileRead from '@salesforce/apex/fetchDataOfFile.csvFileRead';
import fetchFieldsOfAcc from '@salesforce/apex/fetchDataOfFile.fetchFieldsOfAcc';
import callBatchClass from '@salesforce/apex/fetchDataOfFile.callBatchClass';

export default class CsvFileUploadCreateAccount extends LightningElement
 {
    showPopUp = false;

    columns = [];
    data ; 
    AccFields ; 
    value;

    finalDataMap ={};

    // accepted parameters
    get acceptedCSVFormats()
     {
        return ['.csv'];
    }
    
    da = [];

    async uploadFileHandler(event) 
    {
        // Get the list of records from the uploaded files
        const uploadedFiles = event.detail.files;

        await fetchFieldsOfAcc()
        .then(result => {
            console.log('Inside log',JSON.stringify(result));
            let arr = [];
            result.forEach(element => {
                arr = element.split('='); 
                element = arr[4];

                arr = arr[4].split('}');
                console.log('befor } ==> ',arr[0].split('<'));
                let n = arr[0].split('.') ;

                // console.log('N is ===> ',n[1].text.replace("</span>", ""));
                
                this.da.push(n[1]);
                console.log('element is --> ',n[1]);
            });

            this.AccFields = this.da ;
        }).catch(err =>{
            console.log(err);
        })
        console.log('sending data as fields is : ====----=====>>>>> ',this.AccFields);

        // calling apex class csvFileread method
        csvFileRead({contentDocumentId : uploadedFiles[0].documentId})
        .then(result => {
            window.console.log('result => '+result);
            this.data = result;
            

            console.log('coloumn is -=-=> ',result[1]);
            console.log('Key is -=-=> ',result[0]);
        
            result[0].forEach(element => {
                this.columns.push( { label:element, value:element });
            });
            
            console.log('coloumn are : ',this.columns);
            this.data = result[1] ;
            console.log('data  --> ',this.data);
            
            this.showPopUp = true ;
           
        })
        .catch(error => {
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error!!',
                    message: JSON.stringify(error),
                    variant: 'error',
                }),
                );     
                console.log('error is --> ',error);
        })
    }

    closeModal()
    {
        this.showPopUp = false ;
        this.data = '';
        this.columns = [];

        this.finalDataMap = {};
    }
    
    saveDetails()
    {

        this.AccFields.forEach(ele => 
        {
            try {
                let i = '[data-id="'+ele+'"]'.toString;
    
                let val = this.template.querySelector(i);
                console.log('value is : ++>>> ',val);
                console.log('====================');
            } catch (error) {
                console.log('error is =-=> ',error);
            }

        });
        // this.data.forEach(element => {
            
        //     let a = JSON.stringify(element);
        //     console.log('a is ===> ',a);
            
        //     a.splice(a.indexOf('\r'), 2);
        //     console.log('a after splice is  ===> ',a);
        //     element = JSON.parse(a);
            
        // }); 

        console.log('Final data is --> ',this.data);
        console.log('Final data Map is --> ',this.finalDataMap);
        
        let da = JSON.stringify(this.data);
        let fda = JSON.stringify(this.finalDataMap);
        console.log('fda is --> ',this.finalDataMap);
        
        callBatchClass({'data':da ,'fdata':fda })
        .then(result => {
            console.log('result of batch --> ',result);
        }).catch(error=>{
            console.log('error kya he ? -=> ',error);
        })

        this.dispatchEvent(
            new ShowToastEvent(
            {
                title: 'Success!!',
                message: 'Accounts are created according to the CSV file upload!!!',
                variant: 'Success',
            }),
            
        );
        
        
        this.showPopUp = false ;
        this.data = '';
        this.columns = [];
    }

    selectionChangeHandler(event)
    {
            let ans = new Map();
            try {
                console.log('data is is ===+++>>>',JSON.stringify(event.currentTarget.dataset));
                console.log('option is :::>> ',event.detail.value);
    
                let k = JSON.stringify(event.currentTarget.dataset.id) ;
                let v = event.detail.value ;
                console.log('key is : '+k);

                this.finalDataMap[k]=v ; 

                // this.finalDataMap.set( k,v );
                // this.finalDataMap.push(ans)
                console.log('final data is ::: ', this.finalDataMap); 
            } catch (error) {
                console.log(error);
            }

            
        // });
    }
    // this.myMap.push({key:"name",value:element.value})
}