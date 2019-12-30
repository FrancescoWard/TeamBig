({
    //Doctor search controller
    onInit: function (component, event, helper) 
    {	component.set( 'v.mycolumns', helper.setCols() );
     	helper.loadPicklists(component);     
     	helper.loadDrs(component);
    },

    SortDoctor : function (component, event, helper) { helper.loadDrs(component); },

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
        /*let specialty = component.find("specialtyId").get("v.value");
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
        $A.enqueueAction(getDoctors);*/