package org.whispersystems.textsecuregcm.grpc.net.websocket;

enum ApplicationWebSocketCloseReason {
  NOISE_HANDSHAKE_ERROR(4001),
  NOISE_ENCRYPTION_ERROR(4002);

  private final int statusCode;

  ApplicationWebSocketCloseReason(final int statusCode) {
    this.statusCode = statusCode;
  }

  public int getStatusCode() {
    return statusCode;
  }
}
