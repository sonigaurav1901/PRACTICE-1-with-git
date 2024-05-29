import { LightningElement } from 'lwc';

export default class Upload_file extends LightningElement {
    source;
    show=true;
    on = false;
    selectedObj ; 
    fun(event)
    {
        console.log("bhen dar gayii bhen dar gayii ");
        console.log(event.target.value);
        this.source = 'C:\\Users\\hp\\Downloads\\csv files\\csv1.csv' ; 
    }


    onChange(event)
    {
        this.on = true ;
        console.log("Chal gaya");
        console.log(event.target.value);
        this.selectedObj = event.target.value ;
        if(event.target.value === 'Select…')
        {
            console.log("Select");
            this.on = false ;
            this.selectedObj = "" ;
        }
    }
    
}