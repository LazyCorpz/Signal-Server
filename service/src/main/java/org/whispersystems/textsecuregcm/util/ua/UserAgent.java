/*
 * Copyright 2013-2023 Signal Messenger, LLC
 * SPDX-License-Identifier: AGPL-3.0-only
 */

package org.whispersystems.textsecuregcm.util.ua;

import javax.annotation.Nullable;

import com.vdurmont.semver4j.Semver;

public record UserAgent(ClientPlatform platform, Semver version, @Nullable String additionalSpecifiers) {
}
