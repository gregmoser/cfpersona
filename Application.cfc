component {

	// OPTIONAL: Just added for example purposes
	this.name = hash(getCurrentTemplatePath());
	
	// OPTIONAL: The cfpersona.cfc does not actually need session management enabled, but for the sake of convention (and this example) we are using session management
	this.sessionManagement = true;
	
	// OPTIONAL: This is just to setup to 
	public any function onRequestStart() {
		
		// If the cfpersona session element is not yet setup, then we will instantiate it
		if(!structKeyExists(session, "cfpersona")) {
			
			// Lock the session scope so that there are not concurrency issues
			lock scope="session" timeout="10" {
				
				// Define the default session values
				session.cfpersona = {
					authenticated = false,
					email = "",
					expires = 0,
					issuer = ""
				};
				
			}
		}
	}
	
}