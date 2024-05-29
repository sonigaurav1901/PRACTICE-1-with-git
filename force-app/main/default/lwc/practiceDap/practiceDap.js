import { LightningElement} from 'lwc';
import Tmain from '@salesforce/apex/fetchTraineer.Tmain';  
import main from '@salesforce/apex/updateTrainer.main';
export default class PracticeDap extends LightningElement 
{   
    isModalOpen=false;
    TraineName ;
    TrainerId ;
    TraineMarks ;
    TraineEmail ;
    isView = false ;
    actions = [
        { label: 'view', name: 'view' , type:'action' },
        { label: 'edit', name: 'edit' , type:'action' }
    ];
    data = [];
    columns = [
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Traineer Email', fieldName: 'Traineer_Email__c', type: 'text' },
        { label: 'Maximum_Marks (out of 5)', fieldName: 'Maximum_Marks__c', type:'number' },
        { label: 'Pass', fieldName: 'pass', type:'icon' , cellAttributes: { iconName: { fieldName: 'dynamicIcon' } }},
        {
            type: 'action',
            typeAttributes: { rowActions: this.actions }
        }
        // { type: 'action', typeAttributes: { rowActions: actions } }
    ];
    handleAction(event){
        console.log(event.detail.action.label);
        console.log(event.detail.row);
        if(event.detail.action.label == 'edit')
        {
            //console.log("Edit karoo bhaii");
            //console.log('Maximum Marks  '+event.detail.row.Maximum_Marks__c );
            //console.log('Name of Trainee  '+event.detail.row.Name );
            this.TraineName = event.detail.row.Name;
            //console.log('ID of Trainee  '+event.detail.row.Id );
            this.TraineMarks = event.detail.row.Maximum_Marks__c;
            //console.log('Email of Trainee  '+event.detail.row.Traineer_Email__c );
            this.TraineEmail = event.detail.row.Traineer_Email__c;
            this.TrainerId = event.detail.row.Id;
            this.isModalOpen = true ;
        }

        if(event.detail.action.label == 'view')
        {
            this.TraineName = event.detail.row.Name;
            this.TraineMarks = event.detail.row.Maximum_Marks__c;
            this.TraineEmail = event.detail.row.Traineer_Email__c;
            this.TrainerId = event.detail.row.Id;
            this.isView = true ;
        }

    }
    closeModal()
    {
        this.isModalOpen = false;
        this.isView = false;
    }
    saveDetails()
    {
        var mark = this. template. querySelector('.tMarks').value;
        console.log(mark);
        //main(this.TrainerId , mark);
        //this.TraineMarks = mark ;
        if(mark == null)
        {
            mark = 0 ;
        }
        main({TrainerId:this.TrainerId,MaxMarks:mark}).then(result =>{
            console.log('Susses');
            this.closeModal();
        }).then(result => {
            this.reload();
        }).catch(err=>{
            console.log(err);
        });
        
    }
    // eslint-disable-next-line @lwc/lwc/no-async-await
    async connectedCallback() 
    {
        console.log('first');
        this.reload();
        // var data = await fetchTraineer();
    }
    
    reload()
    {
        Tmain().then(data =>
            {
                console.log('secound');
                this.data = JSON.parse(JSON.stringify(data));
                console.log(data);
                
                this.data.forEach(element => {
                    console.log("👌",element);
                    element.institute_Trainee__r.forEach(element1 => {
                        console.log("👌",element1);
                        // element1.dynamicIcon = 'action:approval' ;
                        if(element1.Maximum_Marks__c >= 3 && element1.Maximum_Marks__c > 0)
                        {
                            element1.dynamicIcon = 'action:approval' ;
                        }
                        else if(element1.Maximum_Marks__c <= 2 && element1.Maximum_Marks__c >= 0)
                        {
                            element1.dynamicIcon = 'action:close' ;
                        }
                    });
                });
            }).catch(err => {
                console.log(err);
            })
        }
        
    }