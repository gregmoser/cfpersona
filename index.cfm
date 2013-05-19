<!DOCTYPE html>
<html lang="en">
	<head>
		<title>cfpersona</title>
		
		<!--- REQUIRED: Make sure users of Internet Explorer can't use Compatibility Mode, as this will break Persona. --->
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		
		<!--- OPTIONAL: This is only added for the demo --->
		<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">
	</head>
	<body>
		
		<div class="container">
			
			<div class="row">
				
				<div class="span12">
					
					<h1>cfperson example</h1>
					
				</div>
			</div>
			
			<div class="row">
				
				<div class="span12">
					
					<div class="well">
						
						<!--- NOTE: 																
																									
							For this example we are using the standard convention implimentation	
							of cfpersona which uses a session.cfpersona struct to store details		
							about the current user, but you can impliment however you see fit.		
																									
							If you would not like to use the default cfpersona session struct,		
							you can change the url that is called below to something custom and 	
							then invoke the login() / logout() methods of cfpersona.cfc with:		
																									
							useSession=false														
																									
						--->
						
						<!--- If logged in, the show 'Sign Out' Button --->
						<cfif session.cfpersona.authenticated>
							
							<button id="signout" type="button" class="btn">Sign Out</button>
							
						<!--- Otherwise show 'Sign In' Button --->
						<cfelse>
							
							<button id="signin" type="button" class="btn">Sign In</button>
							
						</cfif>
					</div>
					
				</div>
				
			</div>
			
		</div>
		
		<!--- REQUIRED: This is the persona javascript library that is used to authenticate users --->
		<script src="https://login.persona.org/include.js"></script>
		
		<!--- OPTIONAL / REQUIRED: We are using jQuery for this example in the implimentation below, however it could easily be done with a different library or native javascript but you will need to update the JS below. --->
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		
		<!--- REQUIRED: This bit of javascript is required to make the 'Sign In' and 'Sign Out' buttons work, however it can be modified to fit your application --->
		<script type="text/javascript">
			
			(function($){
				
				$( document ).ready(function() {
					
					// We bind to the body so that the signin / signout dom elements can be added or removed without re-binding
					$( 'body' ).on('click', '#signin', function() {
						navigator.id.request();
					});
					
					$( 'body' ).on('click', '#signout', function() {
						navigator.id.logout();
					});
					
					// Defines the 'watch' configuration so that persona knows what to do on the different events 
					navigator.id.watch({
						
						loggedInUser: '<cfoutput>#session.cfpersona.email#</cfoutput>' || null,
						
						onlogin: function( assertion ) {
							
							// A user has logged in! We now need to send this to cfpersona.cfc so that the session can be updated
							$.ajax({
								type: 'POST',
								url: 'cfpersona.cfc?method=login', // This the url to cfpersona.cfc so that the login method can be called
								data: {assertion: assertion},
								success: function(res, status, xhr) { 
									window.location.reload(); 
								},
								error: function(xhr, status, err) {
									navigator.id.logout();
									alert("Login failure: " + err);
								}
							});
						},
						onlogout: function() {
							
							$.ajax({
								type: 'POST',
								url: 'cfpersona.cfc?method=logout', // This the url to cfpersona.cfc so that the logout method can be called
								success: function(res, status, xhr) { window.location.reload(); },
								error: function(xhr, status, err) { alert("Logout failure: " + err); }
							});
							
						}
					});
	
				});
				
			})(jQuery);
		</script>
	</body>
</html>