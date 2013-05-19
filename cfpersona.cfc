component output="false" {

	remote boolean function login( required string assertion, string audience=CGI.HTTP_HOST, boolean useSession=true ) {
		
		var httpRequest = new http();
		httpRequest.setMethod( "POST" );
		httpRequest.setUrl( "https://verifier.login.persona.org/verify" );
		httpRequest.setPort( 443 );
		httpRequest.setTimeout( 60 );
		httpRequest.setResolveurl( false );
		httpRequest.addParam(type="header",name="Host",value="verifier.login.persona.org");
		httpRequest.addParam(type="formfield", name="assertion", value=arguments.assertion);
		httpRequest.addParam(type="formfield", name="audience", value=arguments.audience);
		
		var response = httpRequest.send().getPrefix();
		var responseString =  response.fileContent.toString( response.charset );
		
		if(isJSON(responseString)) {
			
			var responseStruct = deserializeJSON(responseString);
			
			if(	structKeyExists(responseStruct, "status") &&
				responseStruct.status == "okay" &&
				structKeyExists(responseStruct, "email") &&
				len(trim(responseStruct.email)) &&
				structKeyExists(responseStruct, "expires") &&
				isNumeric(responseStruct.expires) &&
				structKeyExists(responseStruct, "issuer") &&
				len(trim(responseStruct.issuer)) ) {
				
				if(arguments.useSession) {
					
					lock scope="session" timeout="10" {
						session.cfpersona.authenticated = true;
						session.cfpersona.email = responseStruct.email;
						session.cfpersona.expires = responseStruct.expires;
						session.cfpersona.issuer = responseStruct.issuer;
					}
					
				}
				
				return true;
				
			}
		}
		
		// Default Return False
		return false;
	}
	
	remote void function logout( boolean useSession=true ) {
		
		if( arguments.useSession ) {
			
			lock scope="session" timeout="10" {
				
				// Define the logout session values
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
