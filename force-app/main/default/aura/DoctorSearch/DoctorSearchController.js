({
    doInit : function(component, event, helper) {
        let getDocs = component.get("c.getDoctors");
        
        getDocs.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS") {
                console.log(response.getReturnValue());
                component.set("v.Docs", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(getDocs);
        
	},
})