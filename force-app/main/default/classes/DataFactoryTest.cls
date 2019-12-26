@isTest
public class DataFactoryTest {
	@isTest (seeAllData = true)
    public static void testWithAccount ()
    {
        Test.startTest();
        DataFactory.createData(10);
        Test.stopTest();
    }
    
    @isTest
    public static void testWithoutAccount ()
    {	Test.startTest();
        DataFactory.createData(10);
        Test.stopTest();
    }
    
/*    @isTest
    public static void testAppts ()
    {	Contact dr = new Contact( FirstName = 'Doctor', LastName = 'Test' );
     	Contact cust = new Contact( FirstName = 'Customer', LastName = 'Test' );
     	insert dr; insert cust;
     	DataFactory.createAppts(dr, cust, 4);
        
    }
*/}