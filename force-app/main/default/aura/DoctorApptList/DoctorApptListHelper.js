({
    setCols : function ()
    {	const cols =
        [	{ 	label: 'Date', fieldName: 'Start_Time__c', type: 'date' },
         	{	label: 'Time', fieldName: 'Start_Time__c', type: 'time' },
         	{	label: 'Patient', fieldName: 'CustomerName', type: 'text' },
            {	label: 'Status', fieldName: 'Status__c', type: 'text' },
            {	label: '', type: 'button', initialWidth: 135, typeAttributes: 
               	{ 	label : 'Accept', 
                   	name : 'Accept', 
                   	title : 'Click to Accept Appointment',
                 	variant : 'brand'
                }
            },
            { 	label: '', type: 'button', initialWidth: 135, typeAttributes: 
               	{ 	label : 'Reject', 
                   	name : 'Reject', 
                   	title : 'Click to Reject Appointment',
                 	variant : 'destructive'
                }
            }
        ];
     	return cols;        
    },

	loadAppts : function (component) 
    {	let action = component.get( "c.getDoctorAppts" );
     	// action.setParams( { u : $A.get("$SObjectType.CurrentUser.Id") } );
     	action.setCallback( this, function (response)
        {	if ( response.getState() == "SUCCESS" )
            {	let rows = response.getReturnValue();
             	for ( let row of rows )
                    row.CustomerName = row.Customer_Contact__r.Name;
                component.set("v.data", response.getReturnValue() );
            }
        }
                          );
     	$A.enqueueAction(action);
		
	},
    
    openModalBox : function (row, action, component)
    {	let box = component.find('modalbox');
     	$A.createComponent(	"c:DoctorMessageModal",
          					{ "appt_status" : action.name },
                            function(modComponent, status) 
                            { 	if ( status == "SUCCESS" )
                                {	var body = box.get("v.body");
                    				body.push(modComponent);
                    				box.set("v.body", body);
                                } else console.log(status);
                            } 
                          );
    },
    
    updateApptHelper : function (component, event, row) 
    {	let action = component.get( "c.updateAppointment" );
     	action.setParams( 	
        { 	msg : event.getParam('message'), 
            status : event.getParam('status'),
            apptId : row.Id 
        }               );
     	action.setCallback	( this, function (response) 
        {	// refresh the view
            $A.get("e.force:refreshView").fire();
        } 					);
     	$A.enqueueAction(action);
    }
    
})