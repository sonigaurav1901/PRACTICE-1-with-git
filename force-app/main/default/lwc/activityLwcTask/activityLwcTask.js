import { api, LightningElement, track } from 'lwc';
import LoadTask from '@salesforce/apex/activityLwcTaskApex.LoadTask';
import LoadCallLogs from '@salesforce/apex/activityLwcTaskApex.LoadCallLogs';
import LoadEmail from '@salesforce/apex/activityLwcTaskApex.LoadEmail';
import LoadEvent from '@salesforce/apex/activityLwcTaskApex.LoadEvent';
export default class ActivityLwcTask extends LightningElement {

    @api recordId ; 
    
    @track data = [];


    connectedCallback()
    {
        // <lightning:icon iconName="standard:task" alternativeText="Event" title="Event" />
        console.log('record id is : ',this.recordId);
        LoadTask({'AccId':this.recordId}).then(result=>{

            result.forEach(element => {
                this.data.push({'Icon':'standard:task','Subject':element.Subject,'Date':element.ActivityDate,'Id':element.Id,'Status':element.Status});
            });

        }).catch(error=>{
            console.log(error);
        })  

        LoadCallLogs({'AccId':this.recordId}).then(result=>{
            
            result.forEach(element => {
                this.data.push({'Icon':'standard:log_a_call','Subject':element.Subject,'Date':element.ActivityDate,'Id':element.Id,'Status':element.Status});
            });

        }).catch(error=>{
            console.log(error);
        })  

        LoadEmail({'AccId':this.recordId}).then(result=>{

            result.forEach(element => {
                this.data.push({'Icon':'standard:email','Subject':element.Subject,'Date':element.ActivityDate,'Id':element.Id,'Status':element.Status});
            });

        }).catch(error=>{
            console.log(error);
        })  

        LoadEvent({'AccId':this.recordId}).then(result=>{

            result.forEach(element => {
                this.data.push({'Icon':'standard:event','Subject':element.Subject,'Date':element.StartDateTime,'Id':element.Id,'Status':''});
            });

        }).catch(error=>{
            console.log(error);
        })  

        console.log('whole data is : ',this.data);
        
        for(let i = 0 ; i < this.data.length-1 ; i++ )
        {
            for(let j = 1 ; j < this.data.length-1 ; j++)
            {
                if(this.data[i].Date > this.date[j].Date)
                {
                    let temp = this.data[i] ;
                    this.data[i] = this.data[j];
                    this.data[j] = temp ;
                }
            }
        }

        console.log('after sorting : ',this.data);
    }
























    toRefreshPage()
    {
        LoadTask({'AccId':this.recordId}).then(result=>{
            console.log('ye task : ',result);
        }).catch(error=>{
            console.log(error);
        })  
        LoadCallLogs({'AccId':this.recordId}).then(result=>{
            console.log('ye callLogs : ',result);
        }).catch(error=>{
            console.log(error);
        })  
        LoadEmail({'AccId':this.recordId}).then(result=>{
            console.log('ye Email : ',result);
        }).catch(error=>{
            console.log(error);
        })  
        LoadEvent({'AccId':this.recordId}).then(result=>{
            console.log('Ye Event : ',result);
        }).catch(error=>{
            console.log(error);
        })  
    }

}