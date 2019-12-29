public with sharing class LAC_CustomerController {
    @AuraEnabled
    public static List<Contact> getDoctors(String specialty, String gender, String language) {
        List<Contact> Docs = new List<Contact>();
        //Final String recTypeDoc = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Doctor').getRecordTypeId();
        //docList = database.query('Select Id, Name, Speciality__c, Gender__c, Languages__c From Contact Where RecordTypeId=:recTypeDoc AND Speciality__c=:specialty AND Gender__c=:gender AND Languages__c includes :language');
		//docList = database.query('Select Id, Name, Speciality__c, Gender__c, Languages__c From Contact');
        Id recTypeDoc = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Doctor').getRecordTypeId();
        Id devRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Customer').getRecordTypeId();
       // system.debug(recTypeDoc+'  Cust   '+devRecordTypeId);
        //Qyery 10 accounts
        Docs = database.query('Select Id, Name, Speciality__c, Gender__c, Languages__c From Contact Where RecordTypeId=:devRecordTypeId');    

      if (specialty!='Specialty'){Docs = database.query('Select Id, Name, Speciality__c, Gender__c, Languages__c From Contact Where RecordTypeId=:devRecordTypeId AND Speciality__c=:specialty');    }
      system.debug(specialty+' '+gender+' '+language);
      if (gender!='Gender'){Docs = database.query('Select Id, Name, Speciality__c, Gender__c, Languages__c From Contact Where RecordTypeId=:devRecordTypeId AND Gender__c=:gender');     }
      if (language!='Languages'){Docs = database.query('Select Id, Name, Speciality__c, Gender__c, Languages__c From Contact Where RecordTypeId=:devRecordTypeId AND Languages__c includes :language');    }
        
       // Docs = database.query('Select Id, Name, Speciality__c, Gender__c, Languages__c From Contact Where RecordTypeId=:devRecordTypeId');    
        
            
        
        //Docs = database.query('Select Id, Name, Speciality__c, Gender__c, Languages__c From Contact Where RecordTypeId=:devRecordTypeId');

        return Docs;
    }
    
    //String userID = UserInfo.getUserId();
    //User user = database.query('Select FirstName, LastName From User Where Id=:userID Limit 1'); 
    

    // getting personal customer info based on the user ID logged in
   // @AuraEnabled
   // public static Contact getCustomerInfo() {
      //  String userFullName = UserInfo.getName();
       // Contact customer = database.query('Select Id, Name, Email, Phone From Contact Where Name=:userFullName Limit 1');
      //  return customer;
   // }

    // getting List of Appointments based on the user ID logged in
    @AuraEnabled
    public static List<Appointment__c> getAppointments() {
        String userFullName = UserInfo.getName();
      //  Contact customer = database.query('Select ID From Contact Where Name=:userFullName Limit 1');
       // ID customerID = customer.ID;
        List<Appointment__c> appList = new List<Appointment__c>();
        appList = database.query('Select ID, Name, Start_Time__c, End_Time__c, Status__c, Message__c, Customer_Contact__c, Doctor_Contact__c from Appointment__c where Customer_Contact__c=:customerID');
         appList = database.query('Select ID, Name, Start_Time__c, End_Time__c, Status__c, Message__c, Customer_Contact__c, Doctor_Contact__c from Appointment__c');
        return appList; 
        // datetime present = system.now();
        // String confirmed = 'Confirmed';
        
    }

    // getting List of doctors based on the gender, languages, and specialty
    
    

    // Returning a list of Strings filled with the picklist values of Specialty__c
    @AuraEnabled
    public static List<String> getAvailableDoctorSpecialtyOptions() {
        List<String> pickListValuesList= new List<String>();
		Schema.DescribeFieldResult fieldResult = Contact.Speciality__c.getDescribe();
		List<Schema.PicklistEntry> spec = fieldResult.getPicklistValues();
        pickListValuesList.add('Any');
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
        pickListValuesList.add('Any');
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
        pickListValuesList.add('Any');
		for( Schema.PicklistEntry pickListVal : lang){
			pickListValuesList.add(pickListVal.getValue());
		}
		return pickListValuesList;
    }
      
}