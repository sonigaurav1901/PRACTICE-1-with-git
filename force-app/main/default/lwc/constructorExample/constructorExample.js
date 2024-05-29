import { LightningElement } from 'lwc';

export default class ConstructorExample extends LightningElement {

    constructor()
    {
        super();
        console.log('Hello From Child Constructor') ;
    }

    connectedCallback()
    {
        console.log('Hello From connected Call Back') ;
    }

    renderedCallback()
    {
        console.log('Hello From Rerender Call Back') ;
    }

}