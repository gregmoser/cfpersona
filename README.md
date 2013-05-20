cfpersona
=========

CFML Based Implementation of Mozilla Persona

## What is Mozilla Person / cfpersona

Persona is an "identity system for the web".  Basically it allows users to authenticate on your website by only using their e-mail address, and NO PASSWORD.
This means no storing passwords, just email addresses. Sound like magic??? It is!

cfpersona is a simple example application as well as a component that is used to authenticate users based on Persona identity assertions.  In addition cfpersona.cfc automatically defines a standard of `session.cfpersona` that stores authentication information to be used by your applicaiton.

Currently cfpersona offloads certificate verification to Mozilla via https. In the future this implementation will also support doing the crypto directly on your server so that you do not need to rely on any 3rd party vendor (Mozilla).  Persona is still in development, and the spec is evolving so Mozilla currently recommends using their servers via https to verify the cryptographic signatures on users' identity certificates.

Read more about the details of Persona here: http://www.mozilla.org/en-US/persona/


## Requirements

This implementation of persona uses Adobe ColdFusion 9+ or Railo 3+ because of the full script based component.  However Persona does not require anything specific about the server, and if you convert cfpersona to a tag bassed component it should work on any version of CF.

## License

This software is distributed open source under the MIT License which can be found in "mit-license.txt" or on the web at: http://opensource.org/licenses/MIT
