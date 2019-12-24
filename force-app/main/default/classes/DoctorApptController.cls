public class DoctorApptController 
{
    @AuraEnabled
    public static User getCurrentUser ()
    {   User u = [ SELECT Id, ContactId FROM User WHERE id =: userInfo.getUserId()];
		return u;
    }
    
    @AuraEnabled
	public static List<Appointment__c> getDoctorAppts ( User u )
    {	// get community contact id from current user id
        Contact dr = [ SELECT Id FROM Contact WHERE Id = :u.ContactId ];
        // returned all appointments connected to doctor along with their related customers
        List<Appointment__c> allAppts = 
        	[ 	SELECT Id, Start_Time__c, Status__c, Customer_Contact__r.Id, Customer_Contact__r.Name
                FROM Appointment__c
             	WHERE Doctor_Contact__c = :dr.Id
            ];
        return allAppts;
    }
}