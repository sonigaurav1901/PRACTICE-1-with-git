import { LightningElement } from 'lwc';

export default class Ticket_Question extends LightningElement {

    submitName(event)
    {
        console.log("Hello from submit name");
        console.log(event.target.value);

        console.log(this.template.querySelector('[data-id="name1"]').value);
    }

}