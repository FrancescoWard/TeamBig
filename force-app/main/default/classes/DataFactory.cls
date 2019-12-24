public class DataFactory {

    public static void createData(){
        
          final String STREET_ADDR_1 = '11730 American Plaza Blvd';
          final String STREET_ADDR_2 = '2282 Astoria Drive';
          final String CITY_1        = 'Reston';
          final String CITY_2        = 'Herndon';
          final Decimal ZIP_1         = 20170;
          final Decimal ZIP_2         = 20190;
          final String STATE         = 'VA';
          final String COUNTRY       = 'US';
        

         List<Appointment__c> appList = new List<Appointment__c>();
         List<AppointmentContact__c> aconList = new List<AppointmentContact__c>();
         List<Contact> conList = new List<Contact>();
         List<Residence__c> resList = new List<Residence__c>();
         List<ContactResidence__c> conResList = new List<ContactResidence__c>();
         List<Account> testAccts = new List<Account>();

        //Accounts 
        testAccts.add(new Account(Name='Helloworld'));
        insert testAccts;
        
        String recTypeDoc = Schema.SObjectType.Contact.getRecordTypeInfosByName()
                  .get('Doctor').getRecordTypeId();
        String recTypeCust = Schema.SObjectType.Contact.getRecordTypeInfosByName()
                  .get('Customer').getRecordTypeId();  

        testAccts = new List<Account>([SELECT Id, Name FROM Account]);
        //Contacts
        for(Integer i = 0 ; i < 20; i++)
        {
            Contact obj = new Contact();
        
            if(i < 10)
            { 
                obj.AccountId = testAccts.get( 0 ).Id;
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


        conList = new List<Contact>([SELECT Id, Name FROM Contact]);
        //Appointments
        for(Integer j = 0; j < 10; j++)
        {
                appList.add(new Appointment__c(Status__c = 'Pending',
                                               Start_Time__c = DateTime.now().addDays(j),
                                               Customer_Contact__c = conList.get( 10 ).Id,
                                               Doctor_Contact__c = conList.get( 0 ).Id));
        }

        insert appList;

        //Residences
        for(Integer k = 0; k < conList.size(); k++)
        {
            Residence__c obj = new Residence__c();
            obj.City__c = (0 == Math.mod(k, 2) ? CITY_1 : CITY_2);
            obj.Country__c = COUNTRY;
            obj.Street_Address__c = (0 == Math.mod(k, 2) ? STREET_ADDR_1 : STREET_ADDR_2);
            obj.Postal_Code__c = (0 == Math.mod(k, 2) ? ZIP_1 : ZIP_2);
            obj.State__c = STATE;
            //obj.Full_Address__c = (0 == Math.mod(k, 2) ? (STREET_ADDR_1 + CITY_1 + ZIP_1 + STATE + COUNTRY) : (STREET_ADDR_2 + CITY_2 + ZIP_2 + STATE + COUNTRY));
            resList.add(obj);
        }
        insert resList;

        //Contact Residence
        resList = new List<Residence__c>([SELECT Id FROM Residence__c]);
        for(Residence__c x : resList)
        {
            ContactResidence__c obj = new ContactResidence__c();
            obj.Contact__c = conList.get( 0 ).Id;
            obj.Residence__c = x.Id;
            conResList.add(obj);
        }
        insert conResList;
            
    }
}