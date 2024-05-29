import { LightningElement } from 'lwc';

export default class ChildComponentMock extends LightningElement {

    connectedCallback() {
        
	    var customeve = new CustomEvent('customeve',{detail: {data:"Data from child component is there"}});
	    this.dispatchEvent(customeve);
    }

}