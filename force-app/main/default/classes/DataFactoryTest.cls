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
}