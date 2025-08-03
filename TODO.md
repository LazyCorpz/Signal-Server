# TODOs

Note that "dropping support" means mocking APIs with no-ops,
so as to not break clients, and also to ease integration.

## Planned Changes

This list is obviously incomplete, and these details are subject to change.
This list is roughly in chronologcal order.
(I.e, the last change depends on all or most before it)

- Optimize Dockerfile dependency installation with a cache mount
- Create and integrate AWS DynamoDB container
- Create Redis cluster for integration testing
- Support [Android][signal-android] clients,
  because Signal accounts must be created on mobile,
  as per their account security mechanisms.
- Support [Desktop][signal-desktop] clients

## Possible changes

Note that these are not necessarily planned changes,
but rather an incomplete list of problems and possible solutions.
These changes have yet to be reviewed, and are thus subject to change.

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
- Migrate YAML configuration files to environment variables to simplify
  multi-stage Docker builds with mounted secrets
<!--
  - Add args to [Dockerfile](./docker/signal-server/Dockerfile) command:
    (from [pom.xml](./service/pom.xml))

    ```xml
    <jvmFlags>
      <jvmFlag>-server</jvmFlag>
      <jvmFlag>-Djava.awt.headless=true</jvmFlag>
      <jvmFlag>-Djdk.nio.maxCachedBufferSize=262144</jvmFlag>
      <jvmFlag>-Dlog4j2.formatMsgNoLookups=true</jvmFlag>
      <jvmFlag>-XX:MaxRAMPercentage=75</jvmFlag>
      <jvmFlag>-XX:+HeapDumpOnOutOfMemoryError</jvmFlag>
      <jvmFlag>-XX:HeapDumpPath=/tmp/heapdump.bin</jvmFlag>
    </jvmFlags>
    <ports>
      <port>8080</port>
    </ports>
    ```
-->

<!-- [signal-android]: https://github.com/LazyCorpz/Signal-Android -->
[signal-android]: https://github.com/signalapp/Signal-Android
[signal-desktop]: https://github.com/LazyCorpz/Signal-Desktop
