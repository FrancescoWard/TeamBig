({
	init : function(component, event, helper) 
    {	component.set( "v.columns", helper.setCols() );
		helper.getUser(component);
     	// helper.loadAppts(component);
	},
    
    handleRowAction : function(component, event, helper) {
    
	}
})