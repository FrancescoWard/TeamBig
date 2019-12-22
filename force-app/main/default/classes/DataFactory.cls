public class DataFactory {

    public static void createData(){
        List<Appointment__c> appList = new List<Appointment__c>();
        List<AppointmentContact__c> aconList = new List<AppointmentContact__c>();
        List<Contact> conList = new List<Contact>();
        List<Residence__c> resList = new List<Residence__c>();
        List<Account> testAccts = new List<Account>();

        //Accounts 
        testAccts.add(new Account(Name='Helloworld'));
        //testAccts.add(new Account(Name='Foobar'));
        //testAccts.add(new Account(Name='Barbaz'));
        insert testAccts;

       //testAccts = new List<Account>([SELECT Id, Name FROM Account]);
        String recTypeDoc = Schema.SObjectType.Contact.getRecordTypeInfosByName()
                  .get('Doctor').getRecordTypeId();
        String recTypeCust = Schema.SObjectType.Contact.getRecordTypeInfosByName()
                  .get('Customer').getRecordTypeId();  
        //Contacts
        for(Integer i = 0 ; i < 20; i++)
        {
            Contact obj = new Contact();
        
            if(i < 10)
            { 
                obj.AccountId = testAccts.get( 0 ).id;
                obj.LastName = 'Last'+i;
                obj.recordTypeId = recTypeDoc;
            }
            if(i >= 10)
            {
                obj.AccountId = testAccts.get( 0 ).id;
                obj.LastName = 'Last'+i;
                obj.recordTypeId = recTypeCust;
            }
            obj.Gender__c = (0 == Math.mod( i , 2 ) ? 'Female': 'Male');
            conList.add(obj);
        }
        insert conList;

        //Appointments
        for(Integer j = 0; j < 10; j++)
        {
                appList.add(new Appointment__c(Status__c = 'Pending',
                                                Start_Time__c = DateTime.now().addDays(j)));
        }
        
        insert appList;

        //Appointment-contacts
        conList = new List<Contact>([SELECT Id, Name FROM Contact]);
        
        for(Contact x : conList)
        {
            AppointmentContact__c ac = new AppointmentContact__c();
            ac.Appointment__c = appList.get( 0 ).Id;
            ac.Contact__c = x.Id;
            aconList.add(ac);
        }
        insert aconList;

        for(Integer j = 0; j < 10; j++)
        {
                appList.add(new Appointment__c(Status__c = 'Pending',
                                                Start_Time__c = DateTime.now().addDays(j)));
        }

    }
}