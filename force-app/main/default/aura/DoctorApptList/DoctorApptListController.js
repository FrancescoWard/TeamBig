({
	init : function(component, event, helper) 
    {	component.set( "v.columns", helper.setCols() );
		// helper.getUser(component);
     	helper.loadAppts(component);
	},
    
    handleRowAction : function(component, event, helper) 
    {	let row = event.getParam('row');
     	let action = event.getParam('action');
     	helper.changeStatus(row, action, component);
    	// helper.changeStatus(row, action, component);
    	// console.log(event.getParam('action').name);
     	// console.log(row.Status__c);
     	let box = component.find('modalbox');
     	// $A.util.addClass(box, 'slds-fade-in-open');
	}
})