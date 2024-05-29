({
	handleSubmit : function(component, event, helper) {
        try {
            //console.log(component.find("userInput").get("v.value"));
            //component.set( "v.valueForParent", component.find("userInput").get("v.value"));
        	component.set( "v.valueForParent", event.target.value);
        } catch(e) {
            console.log(e.message);
        }
	}
})