@isTest
public class DataFactoryTest {
	@isTest
    public static void runTest()
    {
        try
        {
            Test.startTest();
            DataFactory.createData();
            Test.stopTest();
        }
        catch(Exception e)
        {
            
        }
    }
}