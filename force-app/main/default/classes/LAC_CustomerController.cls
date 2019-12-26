public with sharing class LAC_CustomerController {
    //String userID = UserInfo.getUserId();
    //User user = database.query('Select FirstName, LastName From User Where Id=:userID Limit 1'); 
    

    // getting personal customer info based on the user ID logged in
    @AuraEnabled
    public static Contact getCustomerInfo() {
        String userFullName = UserInfo.getName();
        Contact customer = database.query('Select Id, Name, Email, Phone From Contact Where Name=:userFullName Limit 1');
        return customer;
    }

    // getting List of Appointments based on the user ID logged in
    @AuraEnabled
    public static List<Appointment__c> getAppointments() {
        String userFullName = UserInfo.getName();
        Contact customer = database.query('Select ID From Contact Where Name=:userFullName Limit 1');
        ID customerID = customer.ID;
        List<Appointment__c> appList = new List<Appointment__c>();
        appList = database.query('Select ID, Name, Start_Time__c, End_Time__c, Status__c, Message__c, Customer_Contact__c, Doctor_Contact__c from Appointment__c where Customer_Contact__c=:customerID');
        
        return appList; 
        // datetime present = system.now();
        // String confirmed = 'Confirmed';
        
    }

    // getting List of default doctors based on the user ID logged in
    //@AuraEnabled
    //public static List<Contact> getAvailableDoctors() {

        /*
        List<String> pickListValuesList= new List<String>();
		Schema.DescribeFieldResult fieldResult = ObjectApiName.FieldApiName.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for( Schema.PicklistEntry pickListVal : ple){
			pickListValuesList.add(pickListVal.getLabel());
		}     
		return pickListValuesList;
        */


    //} 

    @AuraEnabled
    public static List<String> getAvailableDoctorSpecialtyOptions() {
        List<String> pickListValuesList= new List<String>();
		Schema.DescribeFieldResult fieldResult = Contact.Speciality__c.getDescribe();
		List<Schema.PicklistEntry> spec = fieldResult.getPicklistValues();
		for( Schema.PicklistEntry pickListVal : spec){
			pickListValuesList.add(pickListVal.getValue());
		}     
		return pickListValuesList;
    }

     @AuraEnabled
    public static List<String> getAvailableDoctorGenderOptions() {
        List<String> pickListValuesList= new List<String>();
		Schema.DescribeFieldResult fieldResult = Contact.Gender__c.getDescribe();
		List<Schema.PicklistEntry> gend = fieldResult.getPicklistValues();
		for( Schema.PicklistEntry pickListVal : gend){
			pickListValuesList.add(pickListVal.getValue());
		}     
		return pickListValuesList;
    }
}
