import { api, LightningElement } from 'lwc';

export default class ParentLwcAss extends LightningElement {
    c1Val = "Deselected";
    c2Val = "Deselected";
    c3Val = "Deselected";
    
    count1;
    count2;
    count3;
    @api finalCount = this.child1+this.child2+this.child3 ;

    child1Fun(event)
    {
        this.count1 = event.detail ; 
        console.log('event : '+event.detail);
        console.log(this.count1);
        if(this.count1 === 0)
        {
            this.c1Val = "Deselected" ;
        }
        else
        {
            this.c1Val = "Select" ;
        }

        let customevent = new CustomEvent('fcount',
            {
                detail: this.count1,
                bubbles:true ,
                composed:true
            })
            this.dispatchEvent(customevent);
        
    }
    child2Fun(event)
    {
        this.count2 = event.detail ; 
        console.log(this.count2);

        if(this.count2 === 0)
        {
            this.c2Val = "Deselected" ;
        }
        else
        {
            this.c2Val = "Select" ;
        }
        let customevent = new CustomEvent('fcount',
            {
                detail: this.count2,
                bubbles:true ,
                composed:true
            })
            this.dispatchEvent(customevent);
    }
    child3Fun(event)
    {
        this.count3 = event.detail ; 
        console.log(this.count3);

        if(this.count3 === 0)
        {
            this.c3Val = "Deselected" ;
        }
        else
        {
            this.c3Val = "Select" ;
        }
        let customevent = new CustomEvent('fcount',
        {
            detail: this.count3,
            bubbles:true ,
            composed:true
        })
        this.dispatchEvent(customevent);

    }
    

    @api listen()
    {
        if(this.count1===1)
        {
            this.template.querySelector('c-child1-lwc-ass').c_btn_1();
        }
        if(this.count2===1)
        {
            this.template.querySelector('c-child2-lwc-ass').c_btn_2();
        }
        if(this.count3 ===1)
        {
            this.template.querySelector('c-child3-lwc-ass').c_btn_3();
        }
           
    }
}