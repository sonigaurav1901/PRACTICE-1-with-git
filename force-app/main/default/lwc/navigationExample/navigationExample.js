import { LightningElement, wire } from 'lwc';
import {currentPageReference} from 'lightning/navigation' ;
import {NavigationMixin} from 'lightning/navigation' ;
import { createRecord } from 'lightning/uiRecordApi';

export default class NavigationExample extends NavigationMixin(LightningElement) {

    @wire(currentPageReference)pageRef ;
    accountPageRedirect ; //property
    navigateToObject ;
    handleClick()
    {
        console.log(this.pageRef);
        let nameField = this.template.querySelector('.nameField').value ;
        let noeField = this.template.querySelector('.noeField').value ;

        let fields = {};

        fields.Name = nameField ;
        fields.NumberOfEmployees = noeField;

        createRecord({'apiName':'Account',fields}).then(result =>{
            console.log(result);
            this.accountPageRedirect ={
                type : 'standard__recordPage' ,
                attributes : {
                    
                    recordId : result.id ,
                    objectApiName : 'Account' ,
                    actionName : 'view'

                }
            }

            this[NavigationMixin.Navigate](this.accountPageRedirect) ;

        }).catch(error =>{
            console.log(error);
        });


    }

    
    handleNavigation()
    {
        this.navigateToObject = {
            type : 'standard__objectPage' ,
            
            attributes : {
                objectApiName : 'Account' ,
                actionName : 'list'
            } ,

            state : {
                filterName : 'Recent'
            }
        }

        this[NavigationMixin.Navigate](this.navigateToObject) ;

    }

}