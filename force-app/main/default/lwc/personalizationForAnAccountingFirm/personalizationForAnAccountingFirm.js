import { api, LightningElement } from 'lwc';
import fetchFilesData from '@salesforce/apex/fetchRelatedFillesFileManagement.fetchFilesData';
import sendEmail from '@salesforce/apex/fetchRelatedFillesFileManagement.sendEmail';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';


export default class PersonalizationForAnAccountingFirm extends NavigationMixin(LightningElement) {

    @api recordId ; 
    data ;
    showEmailMod = false ;
    conVersion ; 

    actions = [
        { label: 'preview', name: 'preview' },
        { label: 'download', name: 'download' },
        { label: 'email', name: 'email' },
    ];
    
    columns = [
        { label: 'Name', fieldName: 'Title' },
        { label: 'FileType', fieldName: 'FileType'},
        // { label: 'Icon', cellAttributes:{iconName : {fieldName: 'FileType'} }},
        {
            type: 'action',
            typeAttributes: { rowActions: this.actions },
        },
    ];

    connectedCallback()
    {
        console.log('it is working buddy');
        console.log('record id is :-> ',this.recordId);

        if (this.recordId != null) {
            
            fetchFilesData({'recId':this.recordId}).then(result=>{
                
                this.data = result ;
                console.log('result is : ',result);


            }).catch(error=>{
                console.log('error is : ',error);
            });

        }

    }


    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        this.conVersion = event.detail.row.Id ;
        console.log('conVersion Id is -> ',this.conVersion);
        // console.log('Action Name ---> ',actionName);
        // console.log('row -->',row);
        // console.log('EventazaD:', JSON.stringify(row));
        // console.log('event -->',event.detail.row.Id);
        // console.log('Row Document Id is :::: ',row.ContentDocumentId);
        switch (actionName) 
        {
            case 'preview':
                // this.PreviewDoc(row);
                this[NavigationMixin.Navigate]({
                    type: 'standard__namedPage',
                    attributes: {
                        pageName: 'filePreview'
                    },
                    state : {
                        selectedRecordId: row.Id
                    }
                });
                break;

            case 'download':

            console.log('row.ContentDocument Id is => ',row.Id);
                this[NavigationMixin.Navigate]({
                    type: 'standard__webPage',
                    attributes: {
                        url: `/sfc/servlet.shepherd/document/download/${row.Id}`
                    }
                }, false 
            );
                break;

            case 'email':
                this.showEmailMod = true ;
                let te = JSON.parse(JSON.stringify(row));
                console.log( 'Content version Id is ' , te.Id);
                // console.log(JSON.stringify(row));
                // console.log(te.Id);

                


                // console.log(this.emailContentVersionId);
                break;
            
            default:
        }
    }


    closeModal(){
        this.showEmailMod = false
    }
    
    saveModal()
    {

        let em = this.template.querySelector('[data-em="email"]').value;

        console.log(em);
        this.currentEmail = em ;


        sendEmail({'i': this.conVersion, 'email': em}).then(result=>{
                
            // this.data = result ;
            console.log('email class is : ',result);


        }).catch(error=>{
            console.log('error is : ',error);
        });


        this.showEmailMod = false;
    }

}