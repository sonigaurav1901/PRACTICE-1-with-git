({
	showMessage : function(component, event, helper) {
		helper.showMessageHelper(component, event, 'confirm');
	},
    
    showErrorMessage : function(component, event, helper) {
		helper.showMessageHelper(component, event, 'error');
	},
    
    removeMessage : function(component, event, helper) {
		helper.removeMessageHelper(component);
	}
})