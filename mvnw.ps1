# ----------------------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
# ----------------------------------------------------------------------------

<# ----------------------------------------------------------------------------
Apache Maven Wrapper startup batch script, version 3.2.0

Required ENV vars:
JAVA_HOME - location of a JDK home dir

Optional ENV vars
MAVEN_BATCH_ECHO - set to 'on' to enable the echoing of the batch commands
MAVEN_BATCH_PAUSE - set to 'on' to wait for a keystroke before ending
MAVEN_OPTS - parameters passed to the Java VM when running Maven
    e.g. to debug Maven itself, use
set MAVEN_OPTS=-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8000
MAVEN_SKIP_RC - flag to disable loading of mavenrc files
----------------------------------------------------------------------------
#>

# Find the project base dir, i.e. the directory that contains the folder ".mvn".
# Fallback to current working directory if not found.
function Get-Project-Base-Dir {
    $MAVEN_PROJECTBASEDIR = $env:MAVEN_BASEDIR;

    if (-not [string]::IsNullOrWhiteSpace($MAVEN_PROJECTBASEDIR)) {
        return $MAVEN_PROJECTBASEDIR;
    }

    $EXEC_DIR = $PWD.path;
    $WDIR = $EXEC_DIR;

    while ($true) {
        if (Test-Path "$WDIR\.mvn") {
            # Base dir found
            $MAVEN_PROJECTBASEDIR = $WDIR;
            Set-Location $EXEC_DIR;
            return $MAVEN_PROJECTBASEDIR;
        }

        Set-Location "..";

        if ($WDIR -eq $PWD.path) {
            # Base dir not found
            $MAVEN_PROJECTBASEDIR = $EXEC_DIR;
            Set-Location $EXEC_DIR;
            return $MAVEN_PROJECTBASEDIR;
        }

        $WDIR = $PWD.path;
    }
}

# Warning: Not protected against arbitrary code execution in Batch
function Write-Custom-Error {
    param (
        [string]$Message
    )

    # Printing error message to stderr without traceback from Write-Error
    foreach ($line in $Message -split "`n") {
        cmd.exe /C "echo $line >&2";
    }
}

function Invoke-Cleanup {
    param (
        [Int32]$ERROR_CODE = 0
    )

    if (-not $env:MAVEN_SKIP_RC) {
        # check for post script, once with legacy .bat ending and once with .cmd ending
        if (Test-Path "$HOME\mavenrc_post.bat") {
            cmd.exe /C "$HOME\mavenrc_post.bat";
        }
        if (Test-Path "$HOME\mavenrc_post.cmd") {
            cmd.exe /C "$HOME\mavenrc_post.cmd";
        }
    }

    # pause the script if MAVEN_BATCH_PAUSE is set to 'on'
    if ($env:MAVEN_BATCH_PAUSE -eq "on") {
        pause;
    }

    if ($env:MAVEN_TERMINATE_CMD -eq "on") {
        $Host.SetShouldExit($ERROR_CODE);
    }

    exit $ERROR_CODE;
}

# set title of command window
$Host.UI.RawUI.WindowTitle = $MyInvocation.MyCommand.Definition;
# enable echoing by setting MAVEN_BATCH_ECHO to 'on'
if ($env:MAVEN_BATCH_ECHO -eq "on") {
    Set-PSDebug -Trace 1
}

# Execute a user defined script before this one
if (-not $env:MAVEN_SKIP_RC) {
    # check for pre script, once with legacy .bat ending and once with .cmd ending
    if (Test-Path "$HOME\mavenrc_pre.bat") {
        cmd.exe /C "$HOME\mavenrc_pre.bat" $args;
    }
    if (Test-Path "$HOME\mavenrc_pre.cmd") {
        cmd.exe /C "$HOME\mavenrc_pre.cmd" $args;
    }
}

# ==== START VALIDATION ====
if ([string]::IsNullOrWhiteSpace($env:JAVA_HOME)) {
    Write-Output ".";
    Write-Custom-Error ( `
        "Error: JAVA_HOME not found in your environment.`n" + `
        "Please set the JAVA_HOME variable in your environment to match the`n" + `
        "location of your Java installation.");
    Write-Output ".";
    Invoke-Cleanup 1;
}

if (-not (Test-Path "$env:JAVA_HOME\bin\java.exe")) {
    Write-Output ".";
    Write-Custom-Error("Error: JAVA_HOME is set to an invalid directory.`n" + `
        "JAVA_HOME = $env:JAVA_HOME`n" + `
        "Please set the JAVA_HOME variable in your environment to match the`n" + `
        "location of your Java installation.");
    Write-Output ".";
    Invoke-Cleanup 1;
}

# ==== END VALIDATION ====

$MAVEN_PROJECTBASEDIR = Get-Project-Base-Dir;

if (Test-Path "$MAVEN_PROJECTBASEDIR\.mvn\jvm.config") {
    $JVM_CONFIG_MAVEN_PROPS = (Get-Content "$MAVEN_PROJECTBASEDIR\.mvn\jvm.config").Split("`n") -join ' ';
}

$MAVEN_JAVA_EXE = "$env:JAVA_HOME\bin\java.exe";
$WRAPPER_JAR = "$MAVEN_PROJECTBASEDIR\.mvn\wrapper\maven-wrapper.jar";
$WRAPPER_LAUNCHER = "org.apache.maven.wrapper.MavenWrapperMain";

$DEFAULT_WRAPPER_URL = "https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar";

$WRAPPER_PROPERTIES = Get-Content("$MAVEN_PROJECTBASEDIR\.mvn\wrapper\maven-wrapper.properties").Split("`n");
$WRAPPER_URL = ($WRAPPER_PROPERTIES `
    | Where-Object { $_ -match "^wrapperUrl=" } `
    | ForEach-Object { $_.Split("=")[1] }) ?? $DEFAULT_WRAPPER_URL;
$WRAPPER_SHA_256_SUM = $WRAPPER_PROPERTIES `
    | Where-Object { $_ -match "^wrapperSha256Sum=" } `
    | ForEach-Object { $_.Split("=")[1] };

# Extension to allow automatically downloading the maven-wrapper.jar from Maven-central
# This allows using the maven wrapper in projects that prohibit checking in binary data.
if (Test-Path $WRAPPER_JAR) {
    if ($env:MVNW_VERBOSE -eq $true) {
        Write-Output "Found $WRAPPER_JAR"
    }
} else {
    if ($env:MVNW_REPOURL) {
        $WRAPPER_URL = "$env:MVNW_REPOURL/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar";
    }
    if ($env:MVNW_VERBOSE -eq $true) {
        Write-Output "Couldn't find $WRAPPER_JAR, downloading it ...";
        Write-Output "Downloading from: $WRAPPER_URL";
    }

    $webclient = new-object System.Net.WebClient;

	if (-not ([string]::IsNullOrEmpty($env:MVNW_USERNAME) -and [string]::IsNullOrEmpty($env:MVNW_PASSWORD))) {
		$webclient.Credentials = new-object System.Net.NetworkCredential($env:MVNW_USERNAME, $env:MVNW_PASSWORD);
    }

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $webclient.DownloadFile($WRAPPER_URL, $WRAPPER_JAR);

    if ($env:MVNW_VERBOSE -eq $true) {
        Write-Output "Finished downloading $WRAPPER_JAR";
    }
}
# End of extension

# If specified, validate the SHA-256 sum of the Maven wrapper jar file
if (-not [string]::IsNullOrWhiteSpace($WRAPPER_SHA_256_SUM)) {
    $hash = (Get-FileHash $WRAPPER_JAR -Algorithm SHA256).Hash.ToLower();
    if ($WRAPPER_SHA_256_SUM -ne $hash) {
        Write-Custom-Error( `
            "Error: Failed to validate Maven wrapper SHA-256, your Maven wrapper might be compromised.`n" + `
            "Investigate or delete $WRAPPER_JAR to attempt a clean download.`n" + `
            "If you updated your Maven version, you need to update the specified wrapperSha256Sum property.");
        Invoke-Cleanup 1;
    }
}

# Provide a "standardized" way to retrieve the CLI args that will
# work with both Windows and non-Windows executions.
#
# Requires the program to be run as:
# . "./mvnw"
# See: https://stackoverflow.com/a/14685254
$MAVEN_CMD_LINE_ARGS = $args;
# For running the program as:
# & "./mvnw"
# Use the following line of code instead:
# Set-Variable -scope 1 -Name "MAVEN_CMD_LINE_ARGS" -Value $args

& $MAVEN_JAVA_EXE `
  $JVM_CONFIG_MAVEN_PROPS `
  $env:MAVEN_OPTS `
  $env:MAVEN_DEBUG_OPTS `
  -classpath $WRAPPER_JAR `
  "-Dmaven.multiModuleProjectDirectory=$MAVEN_PROJECTBASEDIR" `
  $WRAPPER_LAUNCHER $env:MAVEN_CONFIG $args;

Invoke-Cleanup ($? ? 0 : 1);
