public class DataFactory 
{
    
    public static void createData()
    {   // Save record type ID's for contact as final strings
    	final String recTypeDoc = Schema.SObjectType.Contact.getRecordTypeInfosByName()
                  						.get('Doctor').getRecordTypeId();
    	final String recTypeCust = Schema.SObjectType.Contact.getRecordTypeInfosByName()
                  						.get('Customer').getRecordTypeId();
        List<Appointment__c> appList = new List<Appointment__c>();
        List<Contact> conList = new List<Contact>();
        List<Residence__c> resList = new List<Residence__c>();
        Account southernHeart = [ 	SELECT Id, Name 
                                 	FROM Account 
                                 	WHERE Name = 'Southern Heart' 
                                 	LIMIT 1 
                                ];

        // Add Southern Heart account if it doesn't exist already
        if ( southernHeart == null )
        {	southernHeart = new Account(name = 'Southern Heart');
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
            
    }
}