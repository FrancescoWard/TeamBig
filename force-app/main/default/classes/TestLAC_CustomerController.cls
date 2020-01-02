@IsTest
public with sharing class TestLAC_CustomerController 
{
    @IsTest (seeAllData=true)
    static public void runTest() 
    {	System.debug( LAC_CustomerController.getDoctors('any', 'any', 'any') );
     	System.debug( LAC_CustomerController.getDoctors('Anesthesiology', 'Male', 'English') );
     	LAC_CustomerController.getAvailableDoctorGenderOptions();
        //Test.stopTest();
        
        //Test.startTest();
        LAC_CustomerController.getAvailableDoctorLanguageOptions();
        //Test.stopTest();
        
        //Test.startTest();
        LAC_CustomerController.getAvailableDoctorSpecialtyOptions();
     
     	LAC_CustomerController.getAppointments();
    }
}