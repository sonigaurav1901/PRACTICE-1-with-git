import { LightningElement, track, wire } from 'lwc';
import Active from '@salesforce/resourceUrl/Active';
import InActive from '@salesforce/resourceUrl/InActive';
import fetchAccountRec from '@salesforce/apex/AccountRec_component_assignment.fetchAccountRec';
import filterRecord from '@salesforce/apex/AccountRec_component_assignment.filterRecord';
import getFields from '@salesforce/apex/AccountRec_component_assignment.getFields';

export default class AccountRec_PaginationAndFilter extends LightningElement {

    coloumns = ["Staff ID", "Name", "Email", "Record Type", "Status"];
    data = [];
    dataToShow = [];
    mainData = [];
    showTable = true;
    showDetailpage = false;
    paginationMap;
    activeImg = Active;
    inactiveImg = InActive;
    searchWord='';
    filterVal='';
    page_index=0;
    currentSelectedRecord='';
    @track deatilPageFields1 = [];
    @track deatilPageFields2 = [];
    @track section1=[];
    @track section2=[];

    nextBtn='->'
    prevBtn='<-'
    currentval = 1 ;
    nextval = 2 ;
    nextval2 = 3 ;

    RecordTypeFilter = [
        { value: "None", label: "None" },
        { value: "Employee Driver", label: "Employee Driver" },
        { value: "Sub Contractor", label: "Sub Contractor" },
    ];

    connectedCallback() {
        // to fetch all records of account
        fetchAccountRec().then(result => {
            // console.log(result);
            result.forEach(element => {
                this.data.push({Id: element.Id ,Staff_Id__c: element.Staff_ID__c != undefined? element.Staff_ID__c :"" , Name: element.Name !=undefined? element.Name:"" , Email: element.Email__c !=undefined ?element.Email__c:"" ,RecordType: element.RecordType == undefined ? "":element.RecordType.Name ,Status: element.Active__c != "No" ? false: true});
            });
            this.page_index = 0;
            this.sortDataAccordingToPagination(this.data);
            
        }).catch(error => {
            console.log(error);
        });
        

    }

    searchRecords(event) {
        this.data = [];
        this.searchWord = event.target.value;
        console.log('search ',event.target.value);
        filterRecord({NameLike: this.searchWord,recordTypeName: this.filterVal}).then(result => {
            // console.log(result);
            result.forEach(element => {
                this.data.push({Id: element.Id ,Staff_Id__c: element.Staff_ID__c != undefined? element.Staff_ID__c :"" , Name: element.Name !=undefined? element.Name:"" , Email: element.Email__c !=undefined ?element.Email__c:"" ,RecordType: element.RecordType == undefined ? "":element.RecordType.Name ,Status: element.Active__c != "No" ? false: true});
            });

            this.sortDataAccordingToPagination(this.data);
        }).catch(error => {
            console.log(error);
        });
    }

    filterApply(event) {
        // console.log('filter Value',event.detail.value);
        this.filterVal = event.detail.value;
        event.detail.value=='None'? this.filterVal='' :event.detail.value;
        // console.log('filter Value',event.detail.value);

        this.data = [];
        filterRecord({NameLike: this.searchWord,recordTypeName: this.filterVal}).then(result => {
            result.forEach(element => {
                this.data.push({Id: element.Id ,Staff_Id__c: element.Staff_ID__c != undefined? element.Staff_ID__c :"" , Name: element.Name !=undefined? element.Name:"" , Email: element.Email__c !=undefined ?element.Email__c:"" ,RecordType: element.RecordType == undefined ? "":element.RecordType.Name ,Status: element.Active__c != "No" ? false: true});
            });
            // console.log('data --> ',this.data);

            this.sortDataAccordingToPagination(this.data);
        }).catch(error => {
            console.log(error);
        });
    }

    openRec(event) {
        this.section1=[];
        this.section2=[];
        console.log('event id --> ',event.currentTarget.dataset.id);
        this.currentSelectedRecord = event.currentTarget.dataset.id;
        this.showTable = false;
        this.showDetailpage = true;
        // to fetch all fields from Metadata
        getFields({AccountId:event.currentTarget.dataset.id}).then(result => {
            // console.log('fields are -> ', result);
            this.deatilPageFields1 = JSON.parse(JSON.stringify(result[0]));
            this.deatilPageFields2 = JSON.parse(JSON.stringify(result[1]));
            // console.log('detail pg ',JSON.stringify(this.deatilPageFields1));
            var conts = JSON.parse(JSON.stringify(this.deatilPageFields1));
            // console.log('const ',conts);
                for(var key in conts){
                    console.log(conts[key] ,' ----- ',key);
                    this.section1.push({value:conts[key], key:key}); //Here we are creating the array to show on UI.
                }
            // console.log('field one ',JSON.stringify(this.section1));
            var conts1 = JSON.parse(JSON.stringify(this.deatilPageFields2));
            // console.log('const ',conts1);
                for(var key in conts1){
                    console.log(conts1[key] ,' ----- ',key);
                    this.section2.push({value:conts1[key], key:key}); //Here we are creating the array to show on UI.
                }
            // console.log('field one ',JSON.stringify(this.section1));
            // console.log('field one ',JSON.stringify(this.section2));
            // console.log('field two ',this.deatilPageFields2);


        }).catch(error => {
            console.log(error);
        });
    }

    closeDetail() {
        this.showTable = true;
        this.showDetailpage = false;
    }


    pageNumber(event) {
        try {
            
                // console.log('number pressed is :- ',event.currentTarget.dataset.id);
                this.page_index = parseInt(event.currentTarget.dataset.id) -1;

                // console.log('page index is ',this.page_index);
                
                if (this.page_index >= 0) {
                    if (this.page_index == 0) {
                        this.currentval = 1 ;
                        this.nextval = 2 ;
                        this.nextval2 = 3 ;
                        // this.template.querySelector(`[data-id="prevButton"]`).style.display = 'none';
                    }
                    else if (this.page_index > 0 && this.page_index <= this.mainData.length - 3 ) {
                        this.currentval = this.page_index + 1  ;
                        this.nextval = this.currentval + 1 ;
                        this.nextval2 = this.currentval + 2 ;    
                        // this.template.querySelector(`[data-id="prevButton"]`).style.display = 'block';
                    }
                }
                else {
                    if (this.page_index >= this.mainData.length - 3) {
                        if (this.page_index <= this.mainData.length-3) {
                            this.currentval = 1 ;
                            this.nextval = 2 ;
                            this.nextval2 = 3 ;
                            // this.template.querySelector(`[data-id="prevButton"]`).style.display = 'none';
                        }
                        else {
                            this.currentval = this.mainData.length - 2 ;
                            this.nextval = this.mainData.length - 2 ;
                            this.nextval2 = this.mainData.length - 1 ;
                        }
                    }
                }
                
                if (this.currentval == 1) {
                    this.template.querySelector(`[data-id="prevButton"]`).style.display = 'none';
                }
                else if (this.currentval >= 1) {
                    this.template.querySelector(`[data-id="prevButton"]`).style.display = 'block';
                }
                if (this.currentval >= this.mainData.length-2) {
                    this.template.querySelector(`[data-id="nextButton"]`).style.display = 'none';
                }
                else {
                    this.template.querySelector(`[data-id="nextButton"]`).style.display = 'block';
                }
                
                // to make selected page number bold
                
                this.dataToShow = this.mainData[this.page_index];
        } catch (error) {
            console.log(error);
        }
    }

    previusPage() {
        if (this.currentval > 1) {
            this.currentval = this.currentval - 1;
            this.nextval = this.nextval - 1;
            this.nextval2 = this.nextval2 - 1 ;
        }
    }

    nextPage() {
        if (this.currentval < this.mainData.length-2 ) {
            this.currentval = this.currentval + 1;
            this.nextval = this.nextval + 1;
            this.nextval2 = this.nextval2 + 1 ;
        }
    }

    sortDataAccordingToPagination (da) {
        this.mainData = [];
        console.log('da is :- ',da);
        var temp = [];
        for (let i = 0; i < da.length; i++) {
            console.log('Inside loop');
            temp.push( da[i] );
            if(temp.length % 10 == 0 ) {
                console.log('inside if');
                this.mainData.push(temp);
                temp = [];
            }            
        }
        if (temp.length > 0 && temp.length < 10) {
            this.mainData.push(temp);
        }
        this.dataToShow = [];
       //////// 
        // this.mainData = [...this.mainData,this.mainData];
        ///////
        this.dataToShow = this.mainData[0];
        // console.log('data sahi he kyaaaa 🤨 ',this.dataToShow);
    }

}