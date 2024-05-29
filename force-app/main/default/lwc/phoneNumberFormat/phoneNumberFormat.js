import { LightningElement,api,track } from 'lwc';

//Static resoure
import intelPhoneNumber from '@salesforce/resourceUrl/intelPhoneNumber';
import imaskLib from '@salesforce/resourceUrl/imaskLib';

import { loadScript,loadStyle} from  'lightning/platformResourceLoader';

export default class PhoneNumberFormat extends LightningElement {
    
    @api CountryName = '';
    @track inputElem ;
    @track iti ;
    @track errorMsg;
    @track validMsg;
    @track mask;
    paths = {
        demoCss : intelPhoneNumber+"/build/css/demo.css",
        intlTelInputCss : intelPhoneNumber+"/build/css/intlTelInput.css", 
        utilsJs : intelPhoneNumber+"/build/js/utils.js", 
        intlTelInputJs : intelPhoneNumber+"/build/js/intlTelInput.js"
    };
    
    errorMap = ["Invalid number", "Invalid country code", "Too short", "Too long", "Invalid number"];
    
    connectedCallback() {

        Promise.all([ 
                loadStyle(this, this.paths.demoCss ), 
                loadStyle(this, this.paths.intlTelInputCss ), 
                loadScript(this, this.paths.utilsJs ), 
                loadScript(this, this.paths.intlTelInputJs )
            ]).then(() => {
                console.log('in then');
                this.inputElem = this.template.querySelector("[data-id=country]")
                this.iti = window.intlTelInput(this.inputElem, {
                    utilsScript: this.paths.utilsJs,
                    initialCountry: "IN",
                    preferredCountries: ['IN','US'],
                })  
                this.errorMsg = this.template.querySelector("[data-id=error-msg]");
                this.validMsg = this.template.querySelector("[data-id=valid-msg]");
        });

        loadScript(this, imaskLib).then(() => {
            if (window.IMask) {
                console.log('IMask library loaded successfully');
            } else {
                console.error('IMask is not available in the library');
            }

            try {
                const maskOptions = {
                    mask: '(00-0000-0000)'
                };
                this.mask = IMask(this.inputElem, maskOptions);
                this.mask.updateValue()
            } catch (error) {
                console.log('error :- ',error);
            }

        }).catch(() => {
            console.log('load error');
        })
    }

    reset() {
        this.inputElem.classList.remove("error");
        this.inputElem.classList.remove("slds-has-error");
        this.errorMsg.innerHTML = "";
        this.errorMsg.classList.add("hide");
        this.validMsg.classList.add("hide");
    }

    validateNumber() {
        this.reset();

        console.log('place holder is ',this.inputElem.placeholder);
        console.log('after replace : ',this.inputElem.placeholder.replace(/\d/g, '0'));

        let maskOptions = {
            mask: this.inputElem.placeholder.replace(/\d/g, '0')
        };
        this.mask = IMask(this.inputElem, maskOptions);
        this.mask.updateValue()

        if (this.inputElem.value.trim()) {
            if (this.iti.isValidNumber()) {
                this.validMsg.classList.remove("hide");
            } else {
                this.inputElem.classList.add("error");
                this.inputElem.classList.add("slds-has-error");
                const errorCode = this.iti.getValidationError();
                this.errorMsg.innerHTML = this.errorMap[errorCode];
                this.errorMsg.classList.remove("hide");
            }
        }
    }
}




// import { LightningElement, api, track } from 'lwc';
// // import intlTellinputjs from '@salesforce/resourceUrl/intlTelInputjs';
// // import utils from '@salesforce/resourceUrl/utilsjs';
// // import intlTellinputcss from '@salesforce/resourceUrl/intlTelInputcss';
// // import democss from '@salesforce/resourceUrl/democss';
// // import flags from '@salesforce/resourceUrl/flags';

// import intTelInput from '@salesforce/resourceUrl/intTelInput1';

// import imask from '@salesforce/resourceUrl/imask';
// import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
// // import { imaskutility as imask } from './imask';

// export default class IntelLibs extends LightningElement {
//     @api CountryName = '';
//     @track inputElem;
//     @track iti;
//     @track mask;
//     connectedCallback() {
//         loadStyle(this, intTelInput+'/democss.css')
//             .then(() => {

//             });
//         loadStyle(this, intTelInput+'/intlTelInputcss.css')
//             .then(() => {

//             });
//         // loadScript(this, utils)
//         //     .then(() => {

//         //     });
//         // loadScript(this, imask)
//         //     .then(() => {

//         //     });
//         // loadScript(this, intlTellinputjs)
//         // Promise.all([loadScript(this, utils), loadScript(this, imask), loadScript(this, intlTellinputjs)])
//         Promise.all([loadScript(this, intTelInput + '/utilsjs.js'), loadScript(this, imask), loadScript(this, intTelInput+'/intlTelInputjs.js')])
//             .then(() => {
//                 this.inputElem = this.template.querySelector("[data-id=country]");
//                 this.iti = window.intlTelInput(this.inputElem, {
//                     utilsScript: intTelInput + '/utilsjs.js',
//                     // utilsScript: utils,
//                     initialCountry: "IN",
//                     preferredCountries: ['IN', 'US'],

//                 });

//                 // const countryData = window.intlTelInputGlobals.getCountryData();
//                 // console.log('cd ', JSON.stringify(window.intlTelInputGlobals));

//                 let firstMaskChange = false;
//                 this.inputElem.addEventListener('countrychange', (event) => {

//                     console.log(' event : ', event)

//                     var selectedCountryData = this.iti.getSelectedCountryData();

//                     console.log("selectedCountryData ", JSON.stringify(selectedCountryData, null, 2));
//                     let newPlaceHolder = intlTelInputUtils.getExampleNumber(selectedCountryData.iso2, true, intlTelInputUtils.numberFormat.INTERNATIONAL);

//                     this.iti.setNumber("");
                    

//                     let newmask = newPlaceHolder.replace(/[1-9]/g, "0");
                   

//                     if (firstMaskChange) {

//                         this.mask.destroy();

//                         var maskOptions = {
//                             mask: newmask
//                         };
//                         this.mask = IMask(this.inputElem, maskOptions);
//                         this.mask.updateValue()

//                     } else {
//                         firstMaskChange = true;

//                         var maskOptions = {
//                             mask: newmask
//                         };
//                         this.mask = IMask(this.inputElem, maskOptions);

//                         console.log('mask : ', this.mask.toString());

//                     }

                      
//                 })
                

//                 this.iti.promise.then(() => {
//                     this.inputElem.dispatchEvent(new CustomEvent('countrychange', {bubbles:true, composed:true}));
//                 })
//                 .catch((error)=>{console.log('eeeee2',error)});

               


//             }).catch((error)=>{console.log('eeeee1', error)});

//         // console.log('OUTPUT : Imask', JSON.stringify( imask.toString())  );
//     }
//     handleInputChange() {
//         // this.mask.updateValue();
//         // this.imask._onChange();

//         // console.log('OUTPUT : ', imask.DIRECTION);
//         // console.log('OUTPUT : ', this.imask);
//     }

// }