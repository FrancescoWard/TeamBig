@isTest
public class DataFactoryTest {
	@isTest (seeAllData = true)
    public static void testWithAccount ()
    {
        Test.startTest();
        DataFactory.createData();
        Test.stopTest();
    }
    
    @isTest
    public static void testWithoutAccount ()
    {	Test.startTest();
        DataFactory.createData();
        Test.stopTest();
    }
}