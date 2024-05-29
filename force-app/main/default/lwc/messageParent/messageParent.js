import {   LightningElement , api } from 'lwc';

export default class MessageParent extends LightningElement {

@api parentProperty ;

handleClick()
{
    // eslint-disable-next-line @lwc/lwc/no-api-reassignments
    this.parentProperty = this.template.querySelector('.inputFieldClass').value ;
}


}