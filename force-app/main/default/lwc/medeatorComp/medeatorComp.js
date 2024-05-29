import LightningDatatable from 'lightning/datatable';
import customNameTemplate from './medComponent.html';
export default class MedeatorComp extends LightningDatatable {

    static customTypes = {
        paymentss: {
            template: customNameTemplate,
        }
    }

}