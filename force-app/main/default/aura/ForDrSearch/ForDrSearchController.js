({
    //Doctor search controller
    onInit: function (component, event, helper) {
    
           
        var cols = [
            {label: 'Full Name', fieldName: 'Name', type: 'text'},
                {label: 'Speciality', fieldName: 'Speciality__c', type: 'Picklist'},
                {label: 'Gender', fieldName: 'Gender__c', type: 'Picklist'},
                {label: 'Language', fieldName: 'Langauges__c', type: 'Picklist'}, 
                {
                             	
        'label': 'Action',
                'type': 'button',
                'typeAttributes': {
        			iconName: 'action:approval',
                    'label': 'Schedule',
                    'name': 'view_details'}}
        
            ];
        
     
        
     component.set( 'v.mycolumns', cols );
       // component.set( 'v.Docs', event.getParam( 'contacts' ) );
        
        //Speciality
        let getSpecialityOptions = component.get("c.getAvailableDoctorSpecialtyOptions");
        
        getSpecialityOptions.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS") {
                component.set("v.specOptions", response.getReturnValue());
            }
        });
        
        //Gender
        let getGenderOptions = component.get("c.getAvailableDoctorGenderOptions");
        
        getGenderOptions.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS") {
                component.set("v.genderOptions", response.getReturnValue());
            }
        });
        
        //Languages
        let getLangOptions = component.get("c.getAvailableDoctorLanguageOptions");
        
        getLangOptions.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS") {
                component.set("v.langOptions", response.getReturnValue());
            }
            
        
        });
                $A.enqueueAction(getSpecialityOptions);
        $A.enqueueAction(getGenderOptions);
        $A.enqueueAction(getLangOptions);
       

    },

    SortDoctor : function (component, event, helper) {
        let specialty = component.find("specialtyId").get("v.value");
        let gender = component.find("genderId").get("v.value");
        let language = component.find("langId").get("v.value");
        let getDoctors = component.get("c.getDoctors");
       
        //alert('Spec:= '+Specialty+'  Gender:='+Gender+'  Lang:='+Language); //+'   Doctors:='+ getDoctors+ '   id=: '+KeyField);
        getDoctors.setParams({"specialty" : specialty, "gender" : gender, "language" : language});
        getDoctors.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS") {
                component.set("v.Docs", response.getReturnValue());
            }
        });
        $A.enqueueAction(getDoctors);
    },
    onRowAction: function( component, event, helper ) {      
        
		let isOpen = component.get('v.isOpen');
        component.set('v.isOpen', !isOpen);
	},
        onAppSave:      function (cmp, event) {
    var selectedRows = event.getParam('selectedRows');
    // Display that fieldName of the selected rows
    for (var i = 0; i < selectedRows.length; i++){
        alert("You selected: " + selectedRows[i].Name);
    }
} 
})