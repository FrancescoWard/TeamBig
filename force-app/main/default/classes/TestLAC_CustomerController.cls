@isTest
public class TestLAC_CustomerController {

   
    @isTest    
    public static void runTests()
    {
        Test.startTest();

        LAC_CustomerController.getDoctors('Dermatology','Male','English');
        
        LAC_CustomerController.getAppointments();
        //Test.stopTest();
        
        //Test.startTest();
        LAC_CustomerController.getAvailableDoctorGenderOptions();
        //Test.stopTest();
        
        //Test.startTest();
        LAC_CustomerController.getAvailableDoctorLanguageOptions();
        //Test.stopTest();
        
        //Test.startTest();
        LAC_CustomerController.getAvailableDoctorSpecialtyOptions();
        Test.stopTest();
    }
}