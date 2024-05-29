({
	methodCalledFromChild : function(component, event, helper) {
		var childCmp = component.find("msg");
        
        try {
        	component.set("v.valueFromChild", childCmp.get("v.valueForParent"));    
        } catch(e) {
            System.debug('The following exception has occurred: ' + e.message);
        }
        
    }
})