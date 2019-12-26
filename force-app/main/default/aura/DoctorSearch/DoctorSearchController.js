({
    //Doctor search controller
    
    init : function (component, event, helper) {
    
        //Specialty
        let getSpecialityOptions = component.get("c.getAvailableDoctorSpecialtyOptions");
        
        getSpecialityOptions.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS") {
                //console.log(response.getReturnValue());
                component.set("v.specOptions", response.getReturnValue());
                //component.set("v.specOptions", response.getReturnValue());
            }
        });
        
        //Gender
        let getGenderOptions = component.get("c.getAvailableDoctorGenderOptions");
        
        getGenderOptions.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS") {
                //console.log(response.getReturnValue());
                component.set("v.gendOptions", response.getReturnValue());
                //component.set("v.specOptions", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(getSpecialityOptions);
        $A.enqueueAction(getGenderOptions);

    
    },
    
})