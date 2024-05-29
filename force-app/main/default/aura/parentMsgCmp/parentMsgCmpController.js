({
	handleShow : function(component, event, helper) {
		component.find("messages").show("confirmation message");
	},
    handleError : function(component, event, helper) {
		component.find("messages").error("Error message");
	},
    handleRemove : function(component, event, helper) {
		component.find("messages").remove();
	}
})