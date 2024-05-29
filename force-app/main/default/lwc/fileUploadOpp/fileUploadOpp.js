import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import uploadFile from '@salesforce/apex/FileUploaderClass.getId';
import fetchRec from '@salesforce/apex/FileUploaderClass.getRec1';
import sendEmail from '@salesforce/apex/FileUploaderClass.sendEmail';
import { refreshApex } from '@salesforce/apex';

const actions = [
    { label: 'Preview', name: 'Preview'   },
    { label: 'Download', name: 'Download' },
    { label: 'Email',name: 'Email' },
    { label: 'Delete' , name: 'Delete' },
];

const columns = [
    { label: 'Type',cellAttributes:{iconName : {fieldName: 'FileType'} }},
    { label: 'File-Name', fieldName: 'Title', type: 'text' },
    { label : 'Icon' ,fieldName: 'FileExtension'},
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];


export default class FileUploaderCompLwc extends NavigationMixin (LightningElement) 
{

    @track glo ;
    showEmailMod = false;
    emailContentVersionId ;
    data1 ;
    columns = columns;
    record = {};

    // for upload file.....
    
    @api recordId;
    fileData

    @wire(fetchRec, {oppId:'$recordId'} )
    
    wiredContacts(result){
        this.glo = result
        if(result.data){
            this.data1=result.data;
            // console.log('this.data1  ',this.data1);
            // console.log('Only data -- > ',data);
            let demo = [...result.data];
            console.log('demo is --> ',demo);

            let arr = [] ;
            
            demo.forEach(element => {
                console.log('run',element);
                if(element.FileExtension == 'png')
                {
                    element={...element,FileType : 'doctype:image'};
                    arr.push(element);
                }
                else if(element.FileExtension == 'xlsx' || element.FileExtension == 'xls')
                {
                    element={...element,FileType : 'doctype:xml'};
                    arr.push(element);
                }
                else if(element.FileExtension == 'csv')
                {
                    element={...element,FileType : 'doctype:csv'};
                    arr.push(element);
                }
                else if(element.FileExtension == 'pdf')
                {
                    element={...element,FileType :  'doctype:pdf'};
                    arr.push(element);
                }
                else if(element.FileExtension == 'doc' || element.FileExtension == 'docx')
                {
                    element={...element,FileType :  'doctype:word'};
                    arr.push(element);
                }
                else if(element.FileExtension == 'txt')
                {
                    element={...element,FileType :  'doctype:txt'};
                    arr.push(element);
                }
    
            })
            this.data1 = arr ;
            console.log('arr Array ',this.data1);
            
        }
        else if (result.error) {
            console.log('sab gol mall he ',result.error);
        }
    }


    closeMadal()
    {
        this.showEmailMod = false ; 
    }
    SendMail()
    {
        console.log('Mail Send to User '); 
        let em = this.template.querySelector('[data-id="emailId"]').value ;   
        console.log( em );

        sendEmail({demooemail:em , verId:this.emailContentVersionId }).then(result=>
        {
            console.log(result);
        }
        ).catch(error=>{
            console.log('email Error ---> ',error);
        })

        this.closeMadal();
    }

    openfileUpload(event) {
        const file = event.target.files[0]
        var reader = new FileReader()
        reader.onload = () => {
            var base64 = reader.result.split(',')[1]
            this.fileData = {
                'filename': file.name,
                'base64': base64,
                'recordId': this.recordId
            }
            console.log(this.fileData)
        }
        reader.readAsDataURL(file)
    }
    
    handleClick(event){

        const uploadedFiles = event.detail.files[0].contentVersionId;
        console.log(uploadedFiles);
    
        console.log('success');

        uploadFile({oppId:this.recordId , conVerId:uploadedFiles}).then(result=>
        {
            console.log(result);
            refreshApex(this.glo);
            // window.location.reload();
        }
        ).catch(error=>{
            console.log('error ----> ',error);
            refreshApex(this.glo);
            // window.location.reload();
        })

        // window.location.reload();
    }

    toast(title){
        const toastEvent = new ShowToastEvent({
            title, 
            variant:"success"
        })
        this.dispatchEvent(toastEvent)
    }


    // Data table .....

    connectedCallback()
    {
        console.log('Connected CallBack');
        // fetchRec({oppId:this.recordId}).then(result=>{
        //     console.log(result);
        //     this.data1=result;
        //     let demo = [...result];
        //     demo.forEach(element => {
        //         if(element.FileExtension == 'png')
        //         {
        //             element.FileType = 'doctype:image';
        //         }
        //         if(element.FileExtension == 'xlsx' || element.FileExtension == 'xls')
        //         {
        //             element.FileType = 'doctype:xml';
        //         }
        //         if(element.FileExtension == 'csv')
        //         {
        //             element.FileType = 'doctype:csv';
        //         }
        //         if(element.FileExtension == 'pdf')
        //         {
        //             element.FileType = 'doctype:pdf';
        //         }
        //         if(element.FileExtension == 'doc' || element.FileExtension == 'docx')
        //         {
        //             element.FileType = 'doctype:word';
        //         }
        //         if(element.FileExtension == 'txt')
        //         {
        //             element.FileType = 'doctype:txt';
        //         }

        //     });
            

        // }).catch(error=>{
        //     console.log('error---------> ',error);
        // })
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        // console.log('Action Name ---> ',actionName);
        // console.log('row -->',row);
        // console.log('EventazaD:', JSON.stringify(row));
        // console.log('event -->',event.detail.row.Id);
        // console.log('Row Document Id is :::: ',row.ContentDocumentId);
        switch (actionName) 
        {
            case 'Preview':
                // this.PreviewDoc(row);
                this[NavigationMixin.Navigate]({
                    type: 'standard__namedPage',
                    attributes: {
                        pageName: 'filePreview'
                    },
                    state : {
                        selectedRecordId: row.ContentDocumentId
                    }
                });
                break;

            case 'Download':
                this[NavigationMixin.Navigate]({
                    type: 'standard__webPage',
                    attributes: {
                        url: `/sfc/servlet.shepherd/document/download/${row.ContentDocumentId}`
                    }
                }, false 
            );
                break;

            case 'Email':
                this.showEmailMod = true ;
                let te = JSON.parse(JSON.stringify(row));
                console.log( 'Content version Id is ' , te.Id);
                // console.log(JSON.stringify(row));
                // console.log(te.Id);

                this.emailContentVersionId = te.Id ;
                // console.log(this.emailContentVersionId);
                break;
            case 'Delete':
                deleteRecord(row.ContentDocumentId).then(result=>
                    {
                        refreshApex(this.glo);
                    }).catch(error=>
                    {
                        console.log('error-->',error);
                    });;
                // this.deleteRow(row);
                // window.location.reload();
                break;
            default:
        }
    }


    findRowIndexById(id) {
        let ret = -1;
        this.data1.some((row, index) => {
            if (row.id === id) {
                ret = index;
                return true;
            }
            return false;
        });
        return ret;
    }

}