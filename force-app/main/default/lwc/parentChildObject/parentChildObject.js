import { api, LightningElement, track } from 'lwc';
import childObjOfAcc from '@salesforce/apex/ParentChildObject.childObjOfAcc';
import ParentObjOfAcc from '@salesforce/apex/ParentChildObject.ParentObjOfAcc';
// import childData from '@salesforce/apex/ParentChildObject.childData';
// import fetchRec from '@salesforce/apex/ParentChildObject.fetchRec';
import fetchParentRec from '@salesforce/apex/ParentChildObject.fetchParentRec';


export default class ParentChildObject extends LightningElement {
    data ;
    parent_data ;
    ShowParentdataTable = true ;
    // ShowdataTable = true ;
    // isModalOpen = false ;
    showAccordian = true ; 
    activeSectionMessage = '';
    activeSectionMessage1 = '';
    // selectedViewButton ;

    // forID = 0 ; 
    @api recordId;
    @api objectApiName;
    // @track TableKaData ; 
    @track ParentTableKaData ;

    // @track MLP_options = [] ;
    // @track MLP_SelectedOptions = [] ;

    // @track columns = [];
    @track ParentColumns = [
        {label:'Name' , fieldName:'Name'},
        {label:'OwnerId' , fieldName:'OwnerId'},
    ];
    handleToggleSection(event) {
        this.activeSectionMessage = event.detail.openSections;

        console.log('hell ',event.detail);
    }

    Parent_handleToggleSection(event)
    {
        this.activeSectionMessage1 = event.detail.openSections;
        this.activeSectionMessage1 = this.activeSectionMessage1.slice(1, this.activeSectionMessage1.length - 1);
        console.log(this.activeSectionMessage1);

        fetchParentRec({objName:this.activeSectionMessage1}).then(result=>{
            this.ParentTableKaData = result ;
            console.log(JSON.parse(JSON.stringify(this.ParentTableKaData)));
            console.log(this.ParentColumns);
        }).catch(error=>{
            console.log(error);
            this.ParentTableKaData = [];
        })        


    }


    connectedCallback()
    {
        childObjOfAcc({objName:this.objectApiName}).then(result => 
        {
            this.data = result ;
            console.log('Child Data',this.data);
        }).catch(error =>
        {
            console.log(error);
        })

        ParentObjOfAcc({objName:this.objectApiName}).then(result => 
        {
            this.parent_data = result ;
            // console.log('Parent Data',this.parent_data);
        }).catch(error =>
        {
            console.log(error);
        })

        console.log('Object of current page is -->',this.objectApiName ,  this.recordId);
        
    }
    // renderedCallback()
    // {
    //     console.log('Object of current page is -->',this.objectApiName ,  this.recordId);

    // }
    

    // openChildModal(event)
    // {
    //     this.MLP_options=[];
    //     console.log(event.target.title);
    //     this.selectedViewButton = event.target.title ;

    //     childData({Acc:this.selectedViewButton}).then(result =>
    //     {
    //         console.log(result);
    //         var keys = Object.keys(result[0]);
    //         // this.Acc_options.push({label:element.Name,value:element.Id})
    //         // this.MLP_options = keys ;
    //         keys.forEach(element => {
    //             this.MLP_options.push({label:element , value:element});
    //         });
            
            
    //         console.log('all keys are : ' , this.MLP_options);
            
    //     }).catch(error => 
    //     {
    //         console.log(error);
    //     })
    //     this.isModalOpen = true;
    // }
    // changeOptions(event)
    // {
    //     this.MLP_SelectedOptions=[];
    //     console.log('change call ',event.detail.value);
    //     this.MLP_SelectedOptions = event.detail.value ; 
    // }
    // onSave()
    // {
    //     console.log('save Fields .. ');

    //     let ans='' ;
    //     for(let i = 1;i< this.MLP_SelectedOptions.length ; i++ )
    //     {
    //         ans =ans+','+this.MLP_SelectedOptions[i] ; 
    //     }
    //     ans = this.MLP_SelectedOptions[0]+ans

    //     console.log('Final output of selected items are : ',ans);

    //     this.isModalOpen=false;
       
    //     this.columns=[];
    //         this.MLP_SelectedOptions.forEach(element => 
    //         {
    //             this.columns.push( {label:element , fieldName:element},);
    //             // console.log(`{label:${element} , value:${element}}`);
              
    //         })
    //         console.log('this.columns - ',this.columns);
            
    //     console.log('Coloumns are : ',this.columns);

    //      fetchRec({objName:this.selectedViewButton , fields:ans}).then(result=>{
    //         // console.log(result);
    //         this.TableKaData = result ;

    //     }).catch(error=>{
    //         console.log(error);
    //     })

    // }

    
    // closeModal() {
    //     // to close modal set isModalOpen tarck value as false
    //     this.isModalOpen = false;
    // }

}