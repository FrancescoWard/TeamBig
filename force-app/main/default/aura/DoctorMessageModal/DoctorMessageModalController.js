({
	init : function(component, event, helper) 
    {
        // component.set("{!v.appt_status}", "Accept");
        // console.log("{!v.appt_status}");
        // $A.util.addClass(component.get("modalbox"), 'slds-fade-in-open');
	},
    
    sendMessage : function(component, event, helper) 
    {	/*let action = component.get( "c.setApptMsg" );
     	action.setParams( { msg : component.get("v.drmsg") } );
     	action.setCallback( this, function (response)
        {	if ( response.getState() == "SUCCESS" )
            {	
            }
        }
                          );
     	$A.enqueueAction(action);
        */
        var setEvent = component.getEvent("updateAppt");
        setEvent.setParams( { "message" : component.get("v.drmsg") } );
        setEvent.fire();
        component.destroy();
        
    }
})