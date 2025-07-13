# TODOs

## Planned Changes

This list is obviously incomplete, and these details are subject to change.
This list is roughly in chronologcal order.
(I.e, the last change depends on all or most before it)

- Create Redis cluster for integration testing
- Support [Android][signal-android] clients,
  because Signal will not let you create an account on desktop.
- Support [Desktop][signal-desktop] clients

## Possible changes

Note that these are not necessarily planned changes,
but rather an incomplete list of problems and possible solutions.
These changes have yet to be reviewed, and are thus subject to change.

- Migrate AWS DynamoDB to MongoDB
- Migrate AWS S3/CDN to MongoDB with [GridFS](https://www.mongodb.com/docs/manual/core/gridfs)
- Migrate all other functionally required external integration services
  to containerized equivalents for self-hosting, if possible
- Drop support for paid services:
  - Stripe
  - Braintree
  - Google Play
  - Apple App Store
  - Consequently, badges will be unused, and thus, should also be removed,
    unless a developer badge exists, or is wanted.
  - Consequently, paid backup tier permissions should be allowed
    based on a new config flag. See:
    [the backup system](https://deepwiki.com/signalapp/Signal-Server/7-backup-system)
    and [SubscriptionConfiguration.java](./service/src/main/java/org/whispersystems/textsecuregcm/configuration/SubscriptionConfiguration.java)
  - Drop support for iOS clients, because third-party apps are required
    to sideload apps not published to the Apple App Store,
    which is an inherently insecure practice that cannot be recommended.
    More so than sideloading unverified apps in general.
  - Modify Signal to not require creating an account on a mobile device.
    Since PQXDH may require some PID to verify a message exchange upon
    the initial handshake, for security reasons, this may be best left alone,
    which is why Android support is currently in the
    [Planned Changes](#planned-changes) phase.

<!-- [signal-android]: https://github.com/lazycorpz/signal-android -->
[signal-android]: https://github.com/signalapp/signal-android
[signal-desktop]: https://github.com/lazycorpz/signal-desktop
