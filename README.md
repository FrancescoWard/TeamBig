Revature Project 2

# Getting the Package to Deploy in Your Org
### Author Brady Achterberg

Either from lack of integration or my own inexperience, the metadata currently provided in our package.xml doesn't let you deploy your community straight from the clone.  You'll get a bunch of complaints like "no CustomSite named Doctor found" and "can't access object permissions".  You can fix all the errors with some light admin-style changes in your target org.

## Enable Communities

Communities can't be enabled straight from the manifest.  Go to Setup, search "Communities", click Enable Communities, set any available domain name.  Community settings like the one in bradys-org-w-community should work then.

## Add Doctor and Customer Communities

A whole community can't be added straight from the manifest.  Go to Setup, click "All Communities", click Add New Community.  Template: Build Your Own.  Name: Customer.  URL: customer.  Then do it again, but name Doctor and URL doctor.  All the metadata for our doctor and customer settings should now work. 

When deploying, you'll also have to replace the username in the <siteAdmin> tag in sites/Customer.size-meta.xml and sites/Doctor.site-meta.xml with your own username.  This sets you as the admin for the community sites instead of a user that's not in your org.  If you can't find it, the errors will tell you where it is.

## Add Community Customer and Partner Users for Testing

