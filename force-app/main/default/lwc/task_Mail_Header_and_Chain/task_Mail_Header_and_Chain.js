import { LightningElement } from 'lwc';
import fetchMailHeader from '@salesforce/apex/mailHeaderAndChain.fetchMailHeader'
import fetchMailChain from '@salesforce/apex/mailHeaderAndChain.fetchMailChain'
import fetchAllRelatedRec from '@salesforce/apex/mailHeaderAndChain.fetchAllRelatedRec'
import allRecordOnSearch from '@salesforce/apex/mailHeaderAndChain.allRecordOnSearch'


export default class Task_Mail_Header_and_Chain extends LightningElement {
    
    data = [];
    actions = [
        { label: 'Show Mail Header', name: 'show_details' },
        { label: 'Delete', name: 'delete' },
    ];
    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Id', fieldName: 'Id' },
        { label: 'Date_Recived', fieldName: 'Date_Recived__c' },
        { label: 'Email_Category', fieldName: 'Email_Category__c' },
        { label: 'Email_Subject', fieldName: 'Email_Subject__c' },
        { label: 'Priority At', fieldName: 'Priority__c' },
        { label: 'Tentative_Completion_Date', fieldName: 'Tentative_Completion_Date__c', type: 'date' },
        {
            type: 'action',
            typeAttributes: { rowActions: this.actions },
        },
    ];

    data1 = [];
    
    columns1 = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Id', fieldName: 'Id' },
        { label: 'Date_Recived', fieldName: 'From__c' },
        { label: 'Email_Category', fieldName: 'Email_Body__c' },
        { label: 'Email_Subject', fieldName: 'Mail_Header__c' },
        { label: 'CC', fieldName: 'CC__c' },
        { label: 'BCC', fieldName: 'BCC__c' },
        { label: 'Priority At', fieldName: 'Subject__c' },
        { label: 'Tentative_Completion_Date', fieldName: 'To__c' },
    ];
    // record = {};
    showDetails = false ;
    showBox = false ;

    connectedCallback()
    {
        fetchMailHeader().then(result=> {
            this.data=result ; 
            console.log( 'data is : ',this.data);
            let temp = this.data;
            this.data=[];
            this.data = temp;
        }).catch(error=> {
            console.log(error);
        })
    }

    async handleRowAction(event) 
    {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) 
        {
            case 'delete':
                // this.deleteRow(row);
                    console.log('delete is presed',row);

                    await fetchAllRelatedRec({i:row.Id}).then(result=> {
                        console.log('selected Data is deleted.');
                    }).catch(error=> {
                        console.log(error);
                    })

                    //fetching data again after delete
                    await fetchMailHeader().then(result=> {
                        this.data=result ; 
                        console.log( 'data is : ',this.data);
                        let temp = this.data;
                        this.data=[];
                        this.data = temp;
                    }).catch(error=> {
                        console.log(error);
                    })

                    this.showDetails=false;

                    break;

            case 'show_details':
                // this.showRowDetails(row);
                    this.showDetails=true;
                    console.log('ShowDetail is presed',JSON.parse(JSON.stringify(row)));
                    console.log('row id is : ',row.Id);
0
                    fetchMailChain({i:row.Id}).then(result=> {
                        this.data1=result ; 
                        console.log( 'data1 is : ',this.data1);
                        let temp = this.data1;
                        this.data1=[];
                        this.data1 = temp;
                    }).catch(error=> {
                        console.log(error);
                    })

                    break;

            default:
        }
    }

    async search()
    {
        
        console.log(this.template.querySelector('[data-id="inpEmail"]').value);
        this.showBox=true;
        await allRecordOnSearch({em:this.template.querySelector('[data-id="inpEmail"]').value}).then(result=>{
            console.log('search related records are : ',result);

            if(result != '')
            {
                result.forEach(element => {
                    this.template.querySelector('[data-id="listBox"]').innerText = element.Name;
                    // element.Name
                });
            }
            else
            {
                this.template.querySelector('[data-id="listBox"]').innerText = 'No Result Found' ; 
            }
            
            
        }).catch(error=>{
            console.log(error);
        })
        


    }
}