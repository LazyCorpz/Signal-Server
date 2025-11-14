# TODOs

Note that "dropping support" means mocking APIs with no-ops,
so as to not break clients, and also to ease integration.

## Planned Changes

This list is obviously incomplete, and these details are subject to change.
This list is roughly in chronologcal order.
(I.e, the last change depends on all or most before it)

- Use TLS certificates with Redis (i.e, `rediss://localhost:PORT/`)
- Don't share Signal-Server configurations between production and development
- Password-protect Redis clusters
- Create and integrate AWS DynamoDB container
- Support [Android][signal-android] clients,
  because Signal accounts must be created on mobile,
  as per their account security mechanisms.
- Support [Desktop][signal-desktop] clients

## Possible changes

Note that these are not necessarily planned changes,
but rather an incomplete list of problems and possible solutions.
These changes have yet to be reviewed, and are thus subject to change.

- Add tags to all images
- Optimize Dockerfile dependency installation with a cache mount
- Migrate all other functionally required external integration services
  to containerized equivalents for self-hosting, if possible
- Drop support for paid services:
  - Stripe
  - Braintree
  - Google Play
  - Apple App Store
  - Drop support for iOS clients, because third-party apps are required
    to sideload apps not published to the Apple App Store,
    which is an inherently insecure practice that cannot be recommended.
    More so than sideloading unverified apps in general.

[signal-android]: https://github.com/Vessel9817/Signal-Android
[signal-desktop]: https://github.com/LazyCorpz/Signal-Desktop
