import { LightningElement } from 'lwc';

export default class seatingArrangeMent extends LightningElement {

    showTabel = false;
    showGraphical = false ;
    value ;
    data ;

    // Student Info properties...
    n ;   //name
    rn ;  //rollnumber
    m ;   //marks
    scl ; //Selected Class

    actions = [
        { label: 'Add Student', name: 'add' },
        { label: 'Delete Student', name: 'del' },
    ];
    columns = [
        { label: 'sNo', fieldName: 'sno' },
        { label: 'Roll No.', fieldName: 'rollno' },
        { label: 'Student Name', fieldName: 'stname' },
        {
            type: 'action',
            typeAttributes: { rowActions: this.actions },
        },
    ];




    //Json 0
    rowsOfClasses = {class11:0 , class12:0}

    // Json 1
    class11 = [ {sno:1 , rollno:101 , stname:'Gaurav' , marks:95},
                {sno:2 , rollno:102 , stname:'Karan' , marks:40},
                {sno:3 , rollno:103 , stname:'Kunal' , marks:76}];
    // Json 2
    class12 = [ {sno:1 , rollno:101 , stname:'Navneet' , marks:88},
                {sno:2 , rollno:102 , stname:'Charchit' , marks:90},
                {sno:3 , rollno:103 , stname:'Alok' , marks:95},
                {sno:4 , rollno:104 , stname:'Puneet' , marks:62},
                {sno:5 , rollno:105 , stname:'Bhawesh' , marks:99}
            ];
    nR = [];

    data ;

    get options() {
        return [
            { label: 'Class 11', value: 'class_11' },
            { label: 'Class 12', value: 'class_12' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
        
        if(event.detail.value == 'class_11')
        {
            console.log('1 st classs');
            this.data = this.class11 ;
            this.template.querySelector('[data-id="inpRows"]').value =this.rowsOfClasses.class11;  
        }
        if(event.detail.value == 'class_12')
        {
            console.log('2nd class');
            this.data = this.class12 ;
            this.template.querySelector('[data-id="inpRows"]').value =this.rowsOfClasses.class12;
        }
        this.numberOfRows1();
    }
    // find Rows given by user 
    numberOfRows1()
    {

        let rCount = this.template.querySelector('[data-id="inpRows"]').value ; 
        rCount = parseInt(rCount);
        console.log(Number.isInteger(rCount));
        if( Number.isInteger(rCount) )
        {

            if (this.value == 'class_11') 
            {
                this.rowsOfClasses.class11 = rCount ;  
            }
            if (this.value == 'class_12') 
            {
                this.rowsOfClasses.class12 = rCount ;  
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
    }
    
    clickStudentDetail(event)
    {
        console.log(event.target.dataset.id);
        let ide = event.target.dataset.id ;
        let te = '[data-id="'+ide+'"]' ;
        let d = this.template.querySelector(te);
        console.log(d);
        if(this.m >=75)
        {
            d.style.background = 'green';
            d.innerText = this.n ;
            console.log(d.classList);
            console.log(this.value);
            d.classList.add(this.value+this.rn);
            //d.classList.add(this.value+this.rn) ;
            
            console.log(d.classList);
        }
        else{
            d.style.background = 'red';
            d.innerText = this.n;
            console.log(d.classList);
            d.classList.add(this.value+this.rn);
            console.log(d.classList);
        }
    }

    tableview()
    {
        let ch1 = this.template.querySelector('[data-id="ch1"]');
        console.log(ch1.checked);

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
        console.log(ch2.checked);
        if(ch2.checked == true)
        {
            this.showGraphical=true ;
        }
        if(ch2.checked == false)
        {
            this.showGraphical=false ;
        }
    }


    handleRowAction(event)
    {
        // console.log(event);
        this.n = event.detail.row.stname ;
        this.rn = event.detail.row.rollno ;
        this.m = event.detail.row.marks ;
        
        // delete block
        console.log(event.detail.action.name);
        if(event.detail.action.name == 'del')
        {
            console.log('del is pressed');
            let ref = "."+this.value+this.rn;
            console.log( 'ref value ',ref);

            if(this.template.querySelector(ref) != undefined)
            {
                let d = this.template.querySelector(ref);
                d.style.background = 'white';
                // <div data-id={x.id} style="border: 1.5px solid rgb(43, 40, 40); height: 15px; width: 100px; margin: 3px; margin-left: 18px; "></div>
                d.style.border = '1.5px solid rgb(43, 40, 40)';
                d.style.height = '15px';
                d.style.width = '91px';
                d.style.margin = '3px' ; 
                d.style.marginLeft = '25px' ; 
                d.innerText = '';
                console.log(JSON.stringify(d));
            }
            else
            {
                console.log('you not assign any seat till yet to that particular Student');
                
            }
        }
    }

}