import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

//Account Related
import fetchAccounts from '@salesforce/apex/fetchAccounts.main'
import insRecords from '@salesforce/apex/fetchAccounts.insRecords'
import fechSelectedRec from '@salesforce/apex/fetchAccounts.fechSelectedRec'
import onSearch from '@salesforce/apex/fetchAccounts.onSearch'

//Contact Related
import fetchContacts from '@salesforce/apex/fetchContacts.main'
import insConRecords from '@salesforce/apex/fetchContacts.insConRecords'
import fechSelectedConRec from '@salesforce/apex/fetchContacts.fechSelectedConRec'
import onSearchCon from '@salesforce/apex/fetchContacts.onSearchCon'

//Opportunity Related
import fetchOpportunity from '@salesforce/apex/fetchOpportunity.fetchOpp'
import insOPPRecords from '@salesforce/apex/fetchOpportunity.insOppRecords'
import fetchSelectedOpp from '@salesforce/apex/fetchOpportunity.fechSelectedConRec'
import onSearchOpp from '@salesforce/apex/fetchOpportunity.onSearchOpp'

export default class DualListboxSimple extends LightningElement {
    //For Account
    Acc_selected = [];
    Acc_options = [];
    AccdefaultOptions=[];

    //For Contacts
    Con_selected = [];
    Con_options = [];
    CondefaultOptions=[];


    //For Opportunity
    Opp_selected = [];
    Opp_options = [];
    OppdefaultOptions=[];


    connectedCallback()
    {
        //Fectching Account Records
        console.log('change');
        fetchAccounts().then(result=>
        {
            console.log(result);
            this.Acc_options=[];
            
            result.forEach(element => {
                this.Acc_options.push({label:element.Name,value:element.Id})
            });
            return this.Acc_options;
        }
        ).catch(error=>
            {
            console.log('error ------------> ',error);
        })

                                            //Feching Selected Account Records
        fechSelectedRec().then(result=>
        {
            console.log('selected');
            console.log(result);

            result.forEach(element=>{
                this.AccdefaultOptions.push(element.Id);
            })
            console.log(this.AccdefaultOptions);
            var temp=this.AccdefaultOptions;
            this.AccdefaultOptions=null;
            this.AccdefaultOptions=temp;

        }).catch(error=>{
            console.log(error);
        })

                                            //Fetching Contact Record
        fetchContacts().then(result=>
        {
            console.log(result);
            this.Con_options=[];
            console.log('result ',result);
            result.forEach(element => {
                console.log(element);
                this.Con_options.push({label:element.LastName,value:element.Id})
            });
            return this.Con_options;
        }
        ).catch(error=>
            {
            console.log('con Fetch error ------------> ',error);
        })

                                    //Feching Selected Contact Records
            fechSelectedConRec().then(result=>
            {
                console.log('selected');
                console.log(result);
    
                result.forEach(element=>{
                    this.CondefaultOptions.push(element.Id);
                })
                console.log(this.CondefaultOptions);
                var temp=this.CondefaultOptions;
                this.CondefaultOptions=null;
                this.CondefaultOptions=temp;
    
            }).catch(error=>{
                console.log('con selected fetch error---> ',error);
            })




                                            //Fetch Opportunity Record
        fetchOpportunity().then(result=>
        {
            console.log(result);
            this.Opp_options=[];
            console.log('result ----> ',result);
            result.forEach(element => {
                console.log(element);
                this.Opp_options.push({label:element.Name,value:element.Id})
            });
            return this.Opp_options;
        }
        ).catch(error=>
        {
            console.log('opp Fetch error ------------> ',error);
        })


                                    //Feching Selected Opportunity Records
            fetchSelectedOpp().then(result=>
            {
                console.log('selected');
                console.log(result);
    
                result.forEach(element=>{
                    this.OppdefaultOptions.push(element.Id);
                })
                console.log(this.OppdefaultOptions);
                var temp=this.OppdefaultOptions;
                this.OppdefaultOptions=null;
                this.OppdefaultOptions=temp;
    
            }).catch(error=>{
                console.log(error);
            })


    }

    // get selected() {
    //     return this.Acc_selected.length ? this.Acc_selected : 'none';
    //     return this.Con_selected.length ? this.Con_selected : 'none';
    //     return this.Opp_selected.length ? this.Opp_selected : 'none';
    // }

                                    //Inserting Records of Acount in custom Setting
    onSave1()
    {
        console.log(this.Acc_selected);
        insRecords({ acc:this.Acc_selected }).then(result=>
        {
            console.log('inserted');
            
            let toastMessage = new ShowToastEvent({
                title: 'Sucessfully Saved',
                variant: 'Success',
                message: 'Your records get successfully saved ...'
            });
            
            this.dispatchEvent(toastMessage);
               
            }
            ).catch(error=>
            {
                console.log('error-----> ',error);
            })
        }
            

                                //Inserting Records of Contact in custom Setting
    onSave2()
    {
        console.log(this.Con_selected);
        insConRecords({ con:this.Con_selected }).then(result=>
        {
            console.log(result);
            console.log('inserted');
            
            let toastMessage = new ShowToastEvent({
                title: 'Sucessfully Saved',
                variant: 'Success',
                message: 'Your records get successfully saved ...'
            });
            
            this.dispatchEvent(toastMessage);
                
            }
            ).catch(error=>
            {
                console.log('error-----> ',error);
            })
        }



    onSave3()
    {
        console.log(this.Acc_selected);
        insOPPRecords({ opp:this.Opp_selected }).then(result=>
        {
            console.log(result);
            console.log('inserted');
            
            let toastMessage = new ShowToastEvent({
                title: 'Sucessfully Saved',
                variant: 'Success',
                message: 'Your records get successfully saved ...'
            });
            
            this.dispatchEvent(toastMessage);
            
            }
            ).catch(error=>
            {
                console.log('error-----> ',error);
            })
        }

                                                    //For Account on search
        searchAcc()
        {
            let a = this.template.querySelector('[data-id="searchAcc"]').value;
            console.log(a);
            if(a != null )
            {
                onSearch({val:a}).then(result=>
                {
                    console.log(result);
                    this.Acc_options=[];
                    
                    result.forEach(element => 
                    {
                        this.Acc_options.push({label:element.Name,value:element.Id})
                        console.log(result);
                    });
                    return this.Acc_options;
                    
                }).catch(error=>
                {
                    console.log('error ------------> ',error);
                })
            }
            else
            {
                console.log('Enter Some value first ');
            }
        }


                                        //For Contact on search
        searchCon()
        {
            let a = this.template.querySelector('[data-id="sCon"]').value;
            console.log(a);
            if(a != null )
            {
                onSearchCon({val:a}).then(result=>
                {
                    console.log(result);
                    this.Con_options=[];
                    
                    result.forEach(element => 
                    {
                        this.Con_options.push({label:element.LastName,value:element.Id})
                        console.log(result);
                    });
                    return this.Con_options;
                    
                }).catch(error=>
                {
                    console.log('error ------------> ',error);
                })
            }
            else
            {
                console.log('Enter Some value first ');
            }
                
        }

                                            //For opportunity on search
        searchOpp()
        {
            let a = this.template.querySelector('[data-id="searchOpp"]').value;
            console.log(a);
            if(a != null )
            {
                onSearchOpp({val:a}).then(result=>
                {
                    console.log(result);
                    this.Opp_options=[];
                    
                    result.forEach(element => 
                    {
                        this.Opp_options.push({label:element.Name,value:element.Id})
                        console.log(result);
                    });
                    return this.Opp_options;
                    
                }).catch(error=>
                {
                    console.log('error ------------> ',error);
                })
            }
            else
            {
                console.log('Enter Some value first ');
            }
                
        }
    



    //For Account
    AcchandleChange(e) 
    {
        console.log('Account Change');
        this.Acc_selected = e.detail.value;
        console.log(this.Acc_selected);
    }   
    
    //For Contact
    ConhandleChange(e)
    {
        console.log('Contact Change');
        this.Con_selected = e.detail.value;
        console.log(this.Con_selected);
    }
    
    //For Opportunity
    OpphandleChange(e)
    {
        console.log('Opportunity Change');
        this.Opp_selected = e.detail.value;
        console.log(this.Opp_selected);
    }

}