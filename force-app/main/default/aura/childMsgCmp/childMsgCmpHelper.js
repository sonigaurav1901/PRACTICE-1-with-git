({
	showMessageHelper : function(component , event, severity) {
		var message = event.getParam("arguments");
        var displayMessage = '';
        if(message) {
            displayMessage = message.message ;
        }
        
        var messagePanel = component.find("messages");
        
        $A.createComponents([
            [
                "ui:message", {"title" : severity.toUpperCase(), 
                                "severity": severity ,
                                "closable": true
                               }
            ],
            [
                "ui:outputText", {"value" : displayMessage} 
            ]
            ],
            
                function(components, status, statusMessagesList) {
                    if(status === "SUCCESS") {
                        var uimessage = components[0];
                        var uioutput = components[1];
                        uimessage.set("v.body", uioutput);
                        messagePanel.set("v.body", uimessage);
                    }    
                }
        );
        
	},
    
    removeMessageHelper : function(component , event, severity) {
        var messagePanel = component.find("messages");
        messagePanel.set("v.body", []);
    }
    
})