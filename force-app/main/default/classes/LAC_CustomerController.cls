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

<<<<<<< HEAD
    // getting List of doctors based on the gender, languages, and specialty
    @AuraEnabled
    public static List<Contact> getDoctors(String specialty, String gender, String language) {
        List<Contact> docList = new List<Contact>();
        Final String recTypeDoc = Schema.SObjectType.Contact.getRecordTypeInfosByName()
                                        .get('Doctor').getRecordTypeId();
        docList = database.query('Select Id, Name, Speciality__c, Gender__c, Languages__c From Contact Where RecordTypeId=:recTypeDoc AND Speciality__c=:specialty AND Gender__c=:gender AND Languages__c includes :language');
		return docList;
    } 

=======
>>>>>>> 564f9a03ad476b05ce52ee00a3193b527ad75c4f
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
<<<<<<< HEAD
=======


    @AuraEnabled
    public static void CreateApp(String docID, String startTime){
        try 
        {
            //get the user name and get related customer
            String userFullName = UserInfo.getName();
			final String recTypeDoc = Schema.SObjectType.Contact.getRecordTypeInfosByName()
                                        .get('Doctor').getRecordTypeId();
            
            //Contact doc = [Select ID From Contact WHERE ID=:docID Limit 1];
            Contact cust = [Select Id, Name, Email, Phone From Contact Where Name=:userFullName Limit 1];

            Id custId = cust.Id;
            Appointment__c app = new Appointment__c();
            app.Customer_Contact__c = custId;
            app.Doctor_Contact__c = docID;
            app.Start_Time__c = (null != startTime ? DateTime.parse(startTime) : DateTime.now().addDays(1));
            insert app;
        } 
        catch (DmlException exc) 
        {
            System.debug(exc.getMessage());
        } 
    }
>>>>>>> 564f9a03ad476b05ce52ee00a3193b527ad75c4f
}