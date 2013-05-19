cfpersona
=========

CFML Based Implementation of Mozilla Persona

## What is Mozilla Person / cfpersona

Persona is an "identity system for the web".  Basically it allows users to authenticate on your website by only using their e-mail address, and NO PASSWORD.
This means no storing passwords, just email addresses. Sound like magic??? it is!

cfpersona is a simple example application as well as a component that is used to send https request in order to authenticate on the server side persona based assertions.  In addition cfpersona.cfc automatically defines a standard of `session.cfpersona` that stores authentication information to be used by your applicaiton.

Currently cfpersona offloads the keg generation to Mozilla via http, in the future this implimentation will also support doing the crypto directly on your server so that you do not need to rely on any 3rd party vender (mozilla).  Persona is still in development, and the spec is evolving so they currently recommend using their servers via https to authenticate.

Read more about the details of Persona here: http://www.mozilla.org/en-US/persona/


## Requirements

This implimentation of persona uses Adobe ColdFusion 9+ or Railo 3+ because of the full script based component.  However Persona does not require anything specific about the server, and if you convert cfpersona to a tag bassed component it should work on any version of CF.

## License

This software is distributed open source under the MIT License which can be found in "mit-license.txt" or on the web at: http://opensource.org/licenses/MIT
