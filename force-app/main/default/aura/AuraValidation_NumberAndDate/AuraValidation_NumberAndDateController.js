({
	doAction : function(component, event, helper) {
		var inputCmp = component.find("inputCmp");
        var value = inputCmp.get("v.value");
        
        if(isNaN(value)) {
            inputCmp.set("v.errors",
                         [{message: "Input not a number "+value}]);  
        } else {
            inputCmp.set("v.errors",null);
        }
	},
    
    dateUpdate : function(component, event, helper) {
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1;
        var yyyy = today.getFullYear();
        
        //if Date is less then 10 then append 0 before date
        /*if(dd < 10) {
            dd = '0' + dd;
        }*/
        dd = dd < 10 ? dd = '0' + dd : dd ;
        //if month is less then 10 then append 0 before month
        mm = mm < 10 ? mm = '0' + mm : mm ;
        /*if(mm < 10) {
            mm = '0' + dd;
        }*/
        var todayFormatedDate = yyyy + '-' + mm + '-' + dd ;
        
        if(component.get("v.testDate") != '' && component.get("v.testDate") < todayFormatedDate ) {
            component.set("v.dateValidationError" , true);
        } else {
            component.set("v.dateValidationError" , false);
        }
        
    },
 
 	Submit : function(component, event, helper) {
        var isDateError = component.get("v.dateValidationError");
        console.log('is Date Error -> ',isDateError);
        if(isDateError != true) {
            alert('Entered Date is valid');
        }
        
    }
    
})