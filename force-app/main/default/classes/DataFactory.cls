public class DataFactory 
{
    public static void createData()
    {   // Save record type ID's for contact as final strings
    	final String recTypeDoc = Schema.SObjectType.Contact.getRecordTypeInfosByName()
                                        .get('Doctor').getRecordTypeId();
        final String recTypeCust = Schema.SObjectType.Contact.getRecordTypeInfosByName()
                                        .get('Customer').getRecordTypeId();

        // Initialize list objects to populate and insert
        List<Appointment__c> appList = new List<Appointment__c>();
        List<Contact> conList = new List<Contact>();
        List<ContactResidence__c> conResList = new List<ContactResidence__c>();
        Account southernHeart;
        try // Look for Southern Heart account in the org
        {	southernHeart = [ SELECT Id, Name FROM Account WHERE Name = 'Southern Heart' LIMIT 1 ];
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
            conList.add(obj);
        } 
        insert conList;
        // After adding new, fetch all doctors and customers from the org to add appointments/residences
        List<Contact> drList = [ SELECT Id, RecordTypeId FROM Contact WHERE RecordTypeId = :recTypeDoc ];
        List<Contact> custList = [ SELECT Id, RecordTypeId FROM Contact WHERE RecordTypeId = :recTypeCust ];

        // Create 10 appointments between random doctors and customers
        for(Integer j = 0; j < 10; j++)
        {
            appList.add (new Appointment__c(    Status__c = 'Pending',
                                                Start_Time__c = DateTime.now().addDays(j),
                                                Customer_Contact__c = custList.get( j ).Id,
                                                Doctor_Contact__c = drList.get( j ).Id));
        }

        insert appList;

        // Create 2 residences
        Residence__c reston = new Residence__c 
            (	Street_Address__c = '11730 Plaza America Blvd',
             	City__c = 'Reston',
             	Postal_Code__c = 20170,
             	State__c = 'VA',
             	Country__c = 'US'
            ); insert reston;
        Residence__c herndon = new Residence__c
        	(	Street_Address__c = '2282 Astoria Drive',
             	City__c = 'Herndon',
             	Postal_Code__c = 20190,
             	State__c = 'VA',
             	Country__c = 'US'
            ); insert herndon;

        // Add each doctor to the Reston residence through a junction object
        for( Contact dr : drList )
        {
            ContactResidence__c obj = new ContactResidence__c();
            obj.Contact__c = dr.Id;
            obj.Residence__c = reston.Id;
            conResList.add(obj);
        }
        insert conResList;
    }
}