({
    // Called when user pushes the "Accept/Reject" button
    sendMessage : function(component, event, helper) 
    {	var setEvent = component.getEvent("updateAppt");
        setEvent.setParams(	{ "message" : component.find("v.drmsg"),
                           	  "status" : component.get("v.appt_status") }
                          );
        setEvent.fire();
        component.destroy();
        
    }
})