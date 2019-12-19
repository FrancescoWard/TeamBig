public with sharing class LAC_CustomerController {
    String userID = UserInfo.getUserId();
    User user = database.query('Select FirstName, LastName From User Where Id=:userID Limit 1');
    

    // getting personal customer info based on the user ID logged in
    @AuraEnabled
    public static Contact getCustomerInfo() {
        String userFullName = UserInfo.getUserName();
        Contact customer = database.query('Select Id, Name, Email, Phone From Contact Where Name=:userFullName Limit 1');
        return customer;
    }

    // getting List of Appointments based on the user ID logged in
    @AuraEnabled
    public static List<Appointment__c> getAppointments() {
        String userFullName = UserInfo.getUserName();
        Contact customer = database.query('Select Id From Contact Where Name=:userFullName Limit 1');
        ID customerID = customer.ID;
        return database.query('select Name, Start_Time__c, End_Time__c, Status__c, Message__c from Appointment__c where Id IN:(select Appointment__c from AppointmentContact__c where Contact__c:=customerID');


        //datetime present = system.now();
        //String confirmed = 'Confirmed';
        
    }
}
