({
    myAction : function(component, event, helper) {
        let getAppointments = component.get("c.getAppointments");
        
        getAppointments.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS") {
                console.log(response.getReturnValue());
                component.set("v.Apps", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(getAppointments);
        
	},
})
