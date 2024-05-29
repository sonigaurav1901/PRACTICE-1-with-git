import { LightningElement, track } from 'lwc';
import getOptions from '@salesforce/apex/getClassRecords.getOptions';
import getSelectedOptions from '@salesforce/apex/getClassRecords.getSelectedOptions';
import classStudentData from '@salesforce/apex/getClassRecords.classStudentData';
import fetchRows from '@salesforce/apex/getClassRecords.fetchRows';
import fetchSeatAssignedOrNot from '@salesforce/apex/getClassRecords.fetchSeatAssignedOrNot';
import AssignedSeatAndSetInfo from '@salesforce/apex/getClassRecords.AssignedSeatAndSetInfo';

export default class dynamicSeatingArrangeMent extends LightningElement {

    showTabel = false;
    showGraphical = false ;
    value1 ;
    data ;
    currStudent = [];
    curreDivId ;

    // Student Info properties...
    sno ; //Student sNo.
    n ;   //name
    rn ;  //rollnumber
    m ;   //marks
    scl ; //Selected Class
    nR = [];

    data ;
    op=[];
    classRowsInfo = [] ;
    
    actions = [
        { label: 'Add Student', name: 'add' },
        { label: 'Delete Student', name: 'del' },
    ];
    columns = [
        { label: 'sNo', fieldName: 'Name' },
        { label: 'Roll No.', fieldName: 'stRollNo__c' },
        { label: 'Student Name', fieldName: 'stName__c' },
        {
            type: 'action',
            typeAttributes: { rowActions: this.actions },
        },
    ];


    connectedCallback()
    {
        var arr = [];
        getOptions().then(result=>
        {
            result.forEach(element => {
                let x = { label:element.Name , value:element.Id } ;
                arr.push(x);
                this.op.push(x);
            });
            // console.log(this.op);
            this.op = null;
            this.op = arr;
        }).catch(error=>{
            console.log('error-->',error);
        });
    }

    async handleChange(event) {

        this.value1 = event.detail.value;
        let na ;
        
        this.nR = [];
         
        console.log('rest value of rows',this.template.querySelector('[data-id="inpRows"]').value );
        
        // console.log('row value is ',rowValue);
        
        await fetchRows({ide:this.value1}).then(result=>
        {   
            console.log('count of rows ',result.rowsInClass__c);
            this.template.querySelector('[data-id="inpRows"]').value = result.rowsInClass__c ;
            //this.numberOfRows1();
            
        }).catch(error=>
        {
            console.log('uupps -- > ',error);
        });

        await classStudentData({i:event.detail.value}).then(result=>
        {
            na = result[0].Student_Detail__r ; 
        }).catch(error=>
        {
            console.log('error-->',error);
        });
        this.data = na ;

        this.numberOfRows1();
    }


                                            // find Rows given by user 
    numberOfRows1()
    {
        let rCount = this.template.querySelector('[data-id="inpRows"]').value ; 
        rCount = parseInt(rCount);
        console.log(Number.isInteger(rCount));
        console.log(this.value1);
        let selectedClass ;

        if( Number.isInteger(rCount) )
        {   
            if(rCount != null || rCount != undefined || rCount != '')
            {
                getSelectedOptions({i:this.value1 , row:rCount}).then(result=>
                {
                    console.log(result.Name);
                    selectedClass = result.Name ;
                    this.scl = result.Name;
                }).catch(error=>
                {
                    console.log('error-->',error);
                });
            }

            console.log(this.template.querySelector('[data-id="inpRows"]').value);
            let nOfRows = this.template.querySelector('[data-id="inpRows"]').value;
            this.nR = [];
            for(let i = 1 ; i <= nOfRows ; i++)
            {
                this.nR.push({id:'A'+i,id2:'B'+i});   
            }
        }
        else
        {
            this.nR = [] ;
        }
        
        this.fetchSelectedData();

    }

    async fetchSelectedData()
    {
        console.log('fetching data ...... ');

        await classStudentData({i:this.value1}).then(result=>
        {
            
            this.currStudent = result[0].Student_Detail__r ;  
            console.log(result[0].Student_Detail__r);
        }).catch(error=>
        {
            console.log('error-->',error);
        });

        this.currStudent.forEach(element => 
        {
            if(element.studentSeatLoc__c != 0 )
            {
                console.log('only those student ... who got place');
                console.log(element.studentSeatLoc__c);
                let y = element.studentSeatLoc__c;
                console.log('value of y is : ',y);
                
                let d = this.template.querySelector(`[data-id="${y}"]`);
                

                console.log('d is --',JSON.stringify(d));

                if(d != null)
                {
                    d.dataset.class = element.Name ;
                    d.innerText = element.stName__c ;
                    d.style.border = '1.5px solid rgb(43, 40, 40)';
                    d.style.height = '19px';
                    d.style.width = '80px';
                    d.style.margin = '3px' ; 
                    d.style.marginLeft = '24px' ; 
                    d.style.marginTop = '10px' ; 
                    

                    if(element.stMarks__c >= 75)
                    {
                        d.style.background = 'green';
                    }
                    else
                    {
                        d.style.background = 'red';
                    }

                    console.log(d.classList);
                    d.classList.add(this.value1+this.rn);
                    console.log(d.classList);
                }
            }
        });

    }
    
    async clickStudentDetail(event)
    {
        //set Class for clicked div
        let ide = event.target.dataset.id ;
        
        // event.target.dataset.class = this.sno ;
 
        // data-class value is set -- i
        let i = event.target.dataset.class;
        console.log('data-class  -- >',i);

        console.log('ide is ==> ', ide);
      
        let te = '[data-id="'+ide+'"]' ;
        let d = this.template.querySelector(te);
        this.template.querySelector(te).dataset.class = this.sno;

        console.log('hello -->',this.template.querySelector(te));
        console.log('d is ',d.dataset.id);
        this.curreDivId = d.dataset.id ; 
        
        var assignedSeat;
        await fetchSeatAssignedOrNot({sNo:this.sno}).then(result=>
        {
            console.log(JSON.stringify(result));
            assignedSeat = result.assignedSeateOrNot__c ;
            console.log(assignedSeat); 
        }).catch(error=>
        {
            console.log(error);
        });

        if(assignedSeat == 0)
        {
            d.dataset.id = ide ; 
            console.log('inside if',ide);
            
            // let clName = d.className;
            // d.className = clName;
            // console.log('d is ------->',d.className);
            //set seat is assigned AND stored Info
            AssignedSeatAndSetInfo({sNo:this.sno , i:1 , stdSeetingInfo:ide}).then(result=>
            {
                console.log(JSON.stringify(result));
                var assignedSeat = result.assignedSeateOrNot__c ; 
                console.log(assignedSeat);
            }).catch(error=>
            {
                console.log(error);
            });

            d.innerText = this.n ;
            d.style.border = '1.5px solid rgb(43, 40, 40)';
            d.style.height = '19px';
            d.style.width = '80px';
            d.style.margin = '3px' ; 
            d.style.marginLeft = '24px' ; 
            d.style.marginTop = '10px' ;

            if(this.m >=75)
            {
                d.style.background = 'green';
                
                console.log(d.classList);
                d.classList.add(this.value1+this.rn);
                console.log(d.classList);
            }
            else
            {
                d.style.background = 'red';
                
                console.log(d.classList);
                d.classList.add(this.value1+this.rn);
                console.log(d.classList);
            }

            // Storing info of selected div of an particular Student
        }
        else
        {
            console.log('Student alredy assigned seat');
        }
    }
   

    async handleRowAction(event)
    {
        // console.log(JSON.stringify(event.detail.row));

        this.sno = event.detail.row.Name ;
        this.n = event.detail.row.stName__c ;
        this.rn = event.detail.row.stRollNo__c ;
        this.m = event.detail.row.stMarks__c ;
        console.log(this.sno , this.n , this.rn , this.m);
        
                                        // delete block
        console.log(event.detail.action.name);
        if(event.detail.action.name == 'del')
        {

            let x = this.template.querySelector(`[data-class="${this.sno}"]`);
            console.log('deleted div value -->',x);
            x.style.background = 'white';
            x.style.border = '1.5px solid rgb(43, 40, 40)';
            x.style.height = '19px';
            x.style.width = '80px';
            x.style.margin = '3px' ; 
            x.style.marginLeft = '24px' ; 
            x.style.marginTop = '10px' ;
            x.innerText = '';

            await AssignedSeatAndSetInfo({sNo:this.sno , i:0 , stdSeetingInfo:0}).then(result=>
            {
                console.log(JSON.stringify(result));
                // var assignedSeat = result.assignedSeateOrNot__c ; 
            }).catch(error=>
            {
                console.log(error);
            });


            console.log('del is pressed');
            let ref = "."+this.value1+this.rn;
            console.log( 'ref value ',ref);

            if(this.template.querySelector(ref) != undefined)
            {
                let d = this.template.querySelector(ref);
                d.style.background = 'white';
                d.style.border = '1.5px solid rgb(43, 40, 40)';
                d.style.height = '19px';
                d.style.width = '80px';
                d.style.margin = '3px' ; 
                d.style.marginLeft = '24px' ; 
                d.style.marginTop = '10px' ;
                d.innerText = '';
                console.log(JSON.stringify(d));
            }
            else
            {
                console.log('you not assign any seat till yet to that particular Student');
            }
        }
    }


    tableview()
    {
        let ch1 = this.template.querySelector('[data-id="ch1"]');

        if(ch1.checked == true)
        {
            this.showTabel=true ;
        }
        if(ch1.checked == false)
        {
            this.showTabel=false ;
        }
    }
    graphicview()
    {
        let ch2 = this.template.querySelector('[data-id="ch2"]');
        
        if(ch2.checked == true)
        {
            this.showGraphical=true ;
        }
        if(ch2.checked == false)
        {
            this.showGraphical=false ;
        }
    }
}