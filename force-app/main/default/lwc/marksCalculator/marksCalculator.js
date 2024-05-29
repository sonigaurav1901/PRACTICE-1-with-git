import { LightningElement } from 'lwc';

export default class MarksCalculator extends LightningElement {

    Message = '';
    showDiv = false ;

    showResult(event)
    {
        var mathMarks = this.template.querySelector('.mathMarks').value ;

        var scienceMarks = this.template.querySelector('.scienceMarks').value ;

        var percentage = ((parseInt(mathMarks)+parseInt(scienceMarks))/200)*100 ;

        this.showDiv = true ;

        if(percentage >= 60)
        {
            this.Message = 'PASS' ;
            //console.log('Pass');
        }
        else
        {
            this.Message = 'FAIL' ;
            //console.log('Fail');
        }
    } 
}