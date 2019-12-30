public with sharing class LAC_CustomerController 
{
    //String userID = UserInfo.getUserId();
    //User user = database.query('Select FirstName, LastName From User Where Id=:userID Limit 1'); 
    

    // getting personal customer info based on the user ID logged in
    @AuraEnabled
    public static Contact getCustomerInfo() {
        String userFullName = UserInfo.getName();
        Contact customer = database.query('Select Id, Name, Email, Phone From Contact Where Name=:userFullName Limit 1');
        return customer;
    }
    
    @AuraEnabled
	public static List<Appointment__c> getCustomerAppts ( )
    {	// get community contact id from current user id
        User u = [ SELECT Id, ContactId FROM User WHERE id =: userInfo.getUserId()];
        Contact cust = [ SELECT Id FROM Contact WHERE id =: u.ContactId ];
        // return all appointments connected to doctor along with their related customers
        List<Appointment__c> allAppts = 
        	[ 	SELECT Id, Start_Time__c, Message__c, Status__c, Doctor_Contact__r.Id, Doctor_Contact__r.Name
                FROM Appointment__c
             	WHERE Customer_Contact__c = :cust.Id
            ];
        return allAppts;
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

    // getting List of doctors based on the gender, languages, and specialty
    @AuraEnabled
    public static List<Contact> getDoctors(String specialty, String gender, String language) {
        List<Contact> docList = new List<Contact>();
        Final String recTypeDoc = Schema.SObjectType.Contact.getRecordTypeInfosByName()
                                        .get('Doctor').getRecordTypeId();
        docList = database.query('Select Id, Name, Speciality__c, Gender__c, Languages__c From Contact Where RecordTypeId=:recTypeDoc AND Speciality__c=:specialty AND Gender__c=:gender AND Languages__c includes :language');
		return docList;
    } 

    // Returning a list of Strings filled with the picklist values of Specialty__c
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

    // Returning a list of Strings filled with the picklist values of Gender__c
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

    // Returning a list of Strings filled with the picklist values of Languages__c
    @AuraEnabled
    public static List<String> getAvailableDoctorLanguageOptions() {
        List<String> pickListValuesList= new List<String>();
		Schema.DescribeFieldResult fieldResult = Contact.Languages__c.getDescribe();
		List<Schema.PicklistEntry> lang = fieldResult.getPicklistValues();
		for( Schema.PicklistEntry pickListVal : lang){
			pickListValuesList.add(pickListVal.getValue());
		}
		return pickListValuesList;
    }
}