import { LightningElement,api } from 'lwc';

export default class Child2LwcAss extends LightningElement {

    @api count2 = 0;

    check = false;
    
    @api c_btn_2() 
    {
        console.log("btn1");
        //this.count= this.count+1;

        let num = this.template.querySelector('.btn2') ;
        
        if(this.count2 % 2 === 0)
        {
            this.count2++;
            num.variant="destructive";
            num.label = "Deselect";

            let customevent = new CustomEvent('countofchild2',
            {
                detail: this.count2,
                bubbles:true ,
                composed:true
            })
            this.dispatchEvent(customevent);
        }
        else
        {
            this.count2--;
            num.variant="success";
            num.label = "Select";

            let customevent = new CustomEvent('countofchild2',
            {
                detail: this.count2,
                bubbles:true ,
                composed:true
            })
            this.dispatchEvent(customevent);
        }
        
        console.log(this.count2);
        
    }
}