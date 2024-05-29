import { LightningElement,api } from 'lwc';

export default class Child3LwcAss extends LightningElement {

    @api count3 = 0;

    check = false;
    
    @api c_btn_3() 
    {
        console.log("btn3");
        
        let num = this.template.querySelector('.btn3') ;
        
        if(this.count3 % 2 === 0)
        {
            this.count3++;
            num.variant="destructive";
            num.label = "Deselect";

            let customevent = new CustomEvent('countofchild3',
            {
                detail: this.count3,
                bubbles:true ,
                composed:true
            })
            this.dispatchEvent(customevent);

        }
        else
        {
            this.count3--;
            num.variant="success";
            num.label = "Select";

            let customevent = new CustomEvent('countofchild3',
            {
                detail: this.count3,
                bubbles:true ,
                composed:true
            })
            this.dispatchEvent(customevent);
        }
        
        console.log(this.count3);
        
    }

}