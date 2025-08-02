Signal-Server
=================

Documentation
-------------

Looking for protocol documentation? Check out the website!

<https://signal.org/docs/>

Configuring
-----------

- Rename [`.env.example`](./docker/mongo/.env.example) of `mongo` to `.env`.
  For your server's security, please change the credentials.
- Rename [`.env.example`](./docker/mongo/debug/.env.example) of `mongo-debug` to `.env`.
  For your server's security, please change the credentials according to the mongo `.env` file.
- Rename [`sample.yml`](./service/config/sample.yml) to `config.yml`.
  The project will not run with these sample credentials, and therefore need to be properly configured.
- Rename [`sample-secrets-bundle.yml`](./service/config/sample-secrets-bundle.yml) to `secrets-bundle.yml`.
  The project will not run with these sample credentials, and therefore need to be properly configured.
- Rename [`sample.yml`](./integration-tests/src/main/resources/sample.yml) to `config.yml`.
  The project will not run with these sample credentials, and therefore need to be properly configured.

How to Build
------------

```shell
./mvnw clean test
```

Security
--------

Security issues should be sent to <mailto:security@signal.org>.

Help
----

We cannot provide direct technical support. Get help running this software in your own environment in our [unofficial community forum][community forum].

Cryptography Notice
-------------------

This distribution includes cryptographic software. The country in which you currently reside may have restrictions on the import, possession, use, and/or re-export to another country, of encryption software.
BEFORE using any encryption software, please check your country's laws, regulations and policies concerning the import, possession, or use, and re-export of encryption software, to see if this is permitted.
See <https://www.wassenaar.org/> for more information.

The U.S. Government Department of Commerce, Bureau of Industry and Security (BIS), has classified this software as Export Commodity Control Number (ECCN) 5D002.C.1, which includes information security software using or performing cryptographic functions with asymmetric algorithms.
The form and manner of this distribution makes it eligible for export under the License Exception ENC Technology Software Unrestricted (TSU) exception (see the BIS Export Administration Regulations, Section 740.13) for both object code and source code.

License
-------

Copyright 2013 Signal Messenger, LLC

Licensed under the GNU AGPLv3: <https://www.gnu.org/licenses/agpl-3.0.html>

Copyright Notices
-------

See: [NOTICE.md](./NOTICE.md)

[community forum]: https://community.signalusers.org
