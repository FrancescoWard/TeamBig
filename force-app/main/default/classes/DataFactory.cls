public class DataFactory 
{
    
    public static void createData()
    {   // Save record type ID's for contact as final strings
    	final String recTypeDoc = Schema.SObjectType.Contact.getRecordTypeInfosByName()
                                        .get('Doctor').getRecordTypeId();
        final String recTypeCust = Schema.SObjectType.Contact.getRecordTypeInfosByName()
                                        .get('Customer').getRecordTypeId();
        // Save dummy residence data for residences as final strings
        final String STREET_ADDR_1 = '11730 American Plaza Blvd';
        final String STREET_ADDR_2 = '2282 Astoria Drive';
        final String CITY_1        = 'Reston';
        final String CITY_2        = 'Herndon';
        final Decimal ZIP_1        = 20170;
        final Decimal ZIP_2        = 20190;
        final String STATE         = 'VA';
        final String COUNTRY       = 'US';

        // Initialize list objects to populate and insert
        List<Appointment__c> appList = new List<Appointment__c>();
        List<Contact> conList = new List<Contact>();
        List<Residence__c> resList = new List<Residence__c>();
        List<ContactResidence__c> conResList = new List<ContactResidence__c>();
        Account southernHeart;
        try 
        {	southernHeart = [ 	SELECT Id, Name 
            	                FROM Account 
                	            WHERE Name = 'Southern Heart' 
                    	        LIMIT 1 
                        	];
        } catch ( QueryException qe )
        {	// Add Southern Heart account if it doesn't exist already
        	southernHeart = new Account(name = 'Southern Heart');
            southernHeart.IsPartner = true;
         	insert southernHeart;
        }
        // Create 20 contacts, 10 Doctors and 10 Customers
        for(Integer i = 0 ; i < 20 ; i++)
        {
            Contact obj = new Contact();
        
            if(i < 10)	// customer
            { 
                obj.AccountId = southernHeart.Id;
                obj.LastName = 'Last'+i;
                obj.recordTypeId = recTypeDoc;
            }
            if(i >= 10)	// doctor
            {
                obj.AccountId = southernHeart.Id;
                obj.LastName = 'DrLast'+i;
                obj.recordTypeId = recTypeCust;
                obj.Gender__c = (0 == Math.mod( i , 2 ) ? 'Female': 'Male');
            }
        }

        // Appointments
        for(Integer j = 0; j < 10; j++)
        {
            appList.add (new Appointment__c(    Status__c = 'Pending',
                                                Start_Time__c = DateTime.now().addDays(j),
                                                Customer_Contact__c = conList.get( j ).Id,
                                                Doctor_Contact__c = conList.get( 10 - j - 1 ).Id));
        }

        insert appList;

        // Residences
        for(Integer k = 0; k < conList.size(); k++)
        {
            Residence__c obj = new Residence__c();
            obj.City__c = (0 == Math.mod(k, 2) ? CITY_1 : CITY_2);
            obj.Country__c = COUNTRY;
            obj.Street_Address__c = (0 == Math.mod(k, 2) ? STREET_ADDR_1 : STREET_ADDR_2);
            obj.Postal_Code__c = (0 == Math.mod(k, 2) ? ZIP_1 : ZIP_2);
            obj.State__c = STATE;
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