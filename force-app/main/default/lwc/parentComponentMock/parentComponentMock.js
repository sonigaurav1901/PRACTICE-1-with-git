import { LightningElement } from 'lwc';
export default class ParentComponentMock extends LightningElement {

    datafromchild = '';
    handleData(event) {
        console.log('data from child is :- ',event.detail.data);
        this.datafromchild = event.detail.data;
    }
}