public class DoctorTraits 
{	// Interior utility class for accessing picklist arrays
    static public List<String> genderOptions()
    {   List<String> genders = new List<String>{};
        for ( PicklistEntry gend : Contact.Gender__c.getDescribe().getPicklistValues() )
            genders.add( gend.getLabel() );
        return genders;
    }
    static public List<String> langOptions()
    {   List<String> languages = new List<String>{};
        for ( PicklistEntry lang : 	Contact.Languages__c.getDescribe().getPicklistValues() )
            languages.add( lang.getLabel() );
        return languages;
    }
    static public List<String> specOptions()
    {   List<String> specialities = new List<String>{};
        for ( PicklistEntry spec : 	Contact.Speciality__c.getDescribe().getPicklistValues() )
            specialities.add( spec.getLabel() );
        return specialities; 
    }
}