({
	init : function(component, event, helper) 
    {
	},
    // Called when user pushes the "Accept/Reject" button
    sendMessage : function(component, event, helper) 
    {	var setEvent = component.getEvent("updateAppt");
        setEvent.setParams(	{ "message" : component.get("v.drmsg"),
                           	  "status" : component.get("v.appt_status") }
                          );
        setEvent.fire();
        component.destroy();
        
    }
})