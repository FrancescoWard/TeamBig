@IsTest
public with sharing class TestLAC_CustomerController 
{
    @IsTest (seeAllData=true)
    static public void runTest() 
    {	
        System.debug( LAC_CustomerController.getDoctors('any', 'any', 'any') );
     	System.debug( LAC_CustomerController.getDoctors('Anesthesiology', 'Male', 'English') );
        
        String userFullName = UserInfo.getName();
        Contact customer = database.query('Select Id, Name, Email, Phone From Contact Where Name=:userFullName Limit 1');
        System.AssertEquals( LAC_CustomerController.getCustomerInfo(), customer );
        
        User u = [ SELECT Id, ContactId FROM User WHERE id =: userInfo.getUserId()];
        Contact cust = [ SELECT Id FROM Contact WHERE id =: u.ContactId ];
        List<Appointment__c> appList = database.query('SELECT Id, Start_Time__c, Message__c, Status__c, Doctor_Contact__r.Id, Doctor_Contact__r.Name FROM Appointment__c WHERE Customer_Contact__c = :cust.Id Limit 1');
        System.AssertEquals(LAC_CustomerController.getCustomerAppts(), appList);
        
        List<String> genders = new List<String>{};
           	genders.add('Any');
        	genders.add('Male');
        	genders.add('Female');
        	genders.add('Other');
        	
            
        
        List<String> languages = new List<String>{};
            for ( PicklistEntry lang : 	Contact.Languages__c.getDescribe().getPicklistValues() ) {
                languages.add( lang.getLabel() );
            }
        	languages.add('Any');
        
        List<String> specialities = new List<String>{};
        	specialities.add('Any');
        	specialities.add('Immunology');
        	specialities.add('Anesthesiology');
        	specialities.add('Dermatology');
        	specialities.add('Neurology');
        	specialities.add('Ophthalmology');
        	specialities.add('Pathology');
        	specialities.add('Psychiatry');
        	specialities.add('Urology');
        
        
        
        
        
        
        System.AssertEquals(LAC_CustomerController.getAvailableDoctorSpecialtyOptions(), specialities);
        System.AssertEquals(LAC_CustomerController.getAvailableDoctorGenderOptions(), genders);
        System.AssertEquals(LAC_CustomerController.getAvailableDoctorLanguageOptions(), languages);
        
        
        //LAC_CustomerController.CreateApp()
    }
}