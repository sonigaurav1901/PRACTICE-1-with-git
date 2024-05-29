import { LightningElement } from 'lwc';

export default class ParentComponentOfConstructor extends LightningElement {

    display = true ;

    handleClick()
    {
        if(this.display)
        {
            this.display=false ;
        }
        else
        {
            this.display=true ;
        }
    }


        //Life Cycle of Component

    testProperty = '';

    constructor()
    {
        super();

        console.log('Parent Constructor') ;
    }

    connectedCallback()
    {
        this.testProperty = '' ;
        console.log('Parent Connected Call Back') ;
    }

    renderedCallback()
    {
        console.log('Parent Renderd Call Back') ;
    }

    disconnectedCallback()
    {
        console.log('Parent Disconected Call Back') ;
    }

    // eslint-disable-next-line no-unused-vars
    errorCallback(error , _stack)
    {
        console.log(error);
        console.log('Hello from Error Call Back') ;
    }

}