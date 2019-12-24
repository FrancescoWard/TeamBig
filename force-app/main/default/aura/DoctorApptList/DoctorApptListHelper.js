({
    setCols : function ()
    {	const cols =
        [	{ 	label: 'Date', fieldName: 'Start_Time__c', type: 'date' },
         	{	label: 'Time', fieldName: 'Start_Time__c', type: 'time' },
         	{	label: 'Patient', fieldName: 'Customer_Contact__c.FullName', type: 'text' },
            {	label: 'Status', fieldName: 'Status__c', type: 'text' },
            {	label: '', type: 'button', initialWidth: 135, typeAttributes: 
               	{ 	label : 'Accept', 
                   	name : 'accept_appointment', 
                   	title : 'Click to Accept Appointment'
                }
            },
            { 	label: '', type: 'button', initialWidth: 135, typeAttributes: 
               	{ 	label : 'Reject', 
                   	name : 'reject_appointment', 
                   	title : 'Click to Reject Appointment'
                }
            }
        ];
     	return cols;        
    },
    
    getUser : function (component)
    {  	let action = component.get("c.getCurrentUser");
     	action.setCallback	( this, function (response) 
        {	console.log("Reached Apex function!");
            if ( response.getState() == "SUCCESS" )
                component.set("v.currentuser", response.getReturnValue());
         	else console.log("Something went wrong.");
     	}                  	);
     	$A.enqueueAction(action);
    },
    
	loadAppts : function (component) 
    {	console.log("Loading appointments...");
        let action = component.get( "c.getDoctorAppts" );
     	// action.setParams( { u : $A.get("$SObjectType.CurrentUser.Id") } );
     	action.setCallback( this, function (response)
        {	console.log("Callback returned with state code" + response.getState() );
            if ( response.getState() == "SUCCESS" )
            {	console.log("Apex returned this: " + response.getReturnValue() );
                component.set("v.data", response.getReturnValue() );
            }
        }
                          );
     	$A.enqueueAction(action);
		
	}
})