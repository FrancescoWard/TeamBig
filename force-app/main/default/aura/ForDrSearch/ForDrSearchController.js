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

    onRowAction : function ( component, event, helper ) {      
        
		let isOpenComp = component.get('v.isOpen');
        var content = event.getParam("row").Id;
  		component.set('v.rowLast',content);
        component.set('v.isOpen', !isOpenComp);
	},
        
    //book the appointment
    onAppSave : function (component, event, helper) {
        try
        {

            var doctorID = component.get("v.rowLast");
            var time = component.find("dateId");
            var bookAppointment = component.get('c.CreateApp');
            bookAppointment.setParams({ "docID" : doctorID,
                                        "startTime" : time.value });
        
            bookAppointment.setCallback(this, function(response) {
                if(response.getState() === "SUCCESS") {
                    
                }
            });
            $A.enqueueAction(bookAppointment);
            let isOpenComp = component.get('v.isOpen');
            component.set('v.isOpen', !isOpenComp);
            alert('Appointment created');

            
        }
        catch(err)
        {
            alert(err);
        }
    },
})