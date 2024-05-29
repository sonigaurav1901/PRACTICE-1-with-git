import { api, LightningElement } from 'lwc';

export default class Child1LwcAss extends LightningElement {

    @api count1 = 0;

    check = false;
    

   @api c_btn_1() 
    {
        console.log("btn1");
        //this.count= this.count+1;

        let num = this.template.querySelector('.btn1') ;
        
        if(this.count1 % 2 === 0)
        {
            this.count1++;
            num.variant="destructive";
            num.label = "Deselect";

            let customevent = new CustomEvent('countofchild1',
            {
                detail: this.count1,
                bubbles:true ,
                composed:true
            })
            this.dispatchEvent(customevent);

        }
        else
        {
            this.count1--;
            num.variant="success";
            num.label = "Select";

            let customevent = new CustomEvent('countofchild1',
            {
                detail: this.count1,
                bubbles:true ,
                composed:true
            })
            this.dispatchEvent(customevent);
        }
        
        console.log(this.count1);
        
    }
}