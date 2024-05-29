import { LightningElement , api , wire} from 'lwc';

import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import LEAFLET from '@salesforce/resourceUrl/leafLet';

import relatedContact from '@salesforce/apex/fetchContactsAccRelated.relatedContact';
import latitudeLongitude from '@salesforce/apex/fetchContactsAccRelated.latitudeLongitude';


export default class FoodDeliveryApplication extends LightningElement {

    @api recordId;
    @api height;
    @api objectApiName;
    dataFromApex ;
    
    fields = [];


    async connectedCallback()
    {
        
        console.log('Record id is => ',this.recordId);
        var city = [];
        await relatedContact({'i':this.recordId}).then(result => {
            console.log('result is : ',result);

            this.dataFromApex = result ;
            
            result.forEach(element => {

                city.push(element.MailingCity) ;

            });
            
        }).catch(error => {
            console.log('error is : ',error);
        })
        console.log('cities are ()==> ',city);



        await latitudeLongitude({'loc':city}).then(res =>{
            // =========================working=================
            console.log('res is : ',res);

            this.fields = res; 
        }).catch(err =>{
            console.log('error of api : ',err);
        });



        await Promise.all([
            loadStyle(this, LEAFLET + '/leaflet.css'),
            loadScript(this, LEAFLET + '/leaflet.js'),
        ]).then(() => {
            this.draw();
        });


        
    }
    
    renderedCallback() {
        this.template.querySelector('div').style.height = `${this.height}px`;
    }

    draw() 
    {

        console.log('fields in draw method == > ',this.fields);

        let container = this.template.querySelector('div');

        let map = L.map(container, { scrollWheelZoom: true });
            
        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 12,
            attribution: '© OpenStreetMap'
        }).addTo(map);

        this.fields.forEach(element => {
                
                let cord = element.split(',');
                // let data = cord[0]+''+cord[1];

                
                let position = [cord[0],cord[1]];
                
                // L.geoJson({"type": "Polygon", "coordinates": cord}).setStyle(defaultStyle).addTo(map);

                let marker = L.marker(position).addTo(map);
                let featureGroup = L.featureGroup([marker]).addTo(map);
                map.fitBounds(featureGroup.getBounds());
        });

        
    }

}