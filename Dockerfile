FROM ubuntu:16.04

MAINTAINER Feivur

ENV ANDROID_HOME /opt/android-sdk
ENV ANDROID_NDK  /opt/android-ndk
ENV ANDROID_NDK_HOME /opt/android-ndk

# Get the latest version from https://developer.android.com/studio/index.html
ENV ANDROID_SDK_VERSION="25.2.3"

# Get the latest version from https://developer.android.com/ndk/downloads/index.html
ENV ANDROID_NDK_VERSION="13b"

# nodejs version
ENV NODE_VERSION "7.x"

# Set locale
ENV LANG en_US.UTF-8
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen $LANG

COPY README.md /README.md
 
WORKDIR /tmp

# Installing packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        autoconf \
        git \
        curl \
        wget \
        lib32stdc++6 \
        lib32z1 \
        lib32z1-dev \
        lib32ncurses5 \
        libc6-dev \
        libgmp-dev \
        libmpc-dev \
        libmpfr-dev \
        libxslt-dev \
        libxml2-dev \
        m4 \
        ncurses-dev \
        ocaml \
        openssh-client \
        pkg-config \
        python-software-properties \
        software-properties-common \
        ruby-full \
        unzip \
        zip \
        zlib1g-dev && \
    apt-add-repository -y ppa:openjdk-r/ppa && \
    apt-get install -y openjdk-8-jdk && \
    rm -rf /var/lib/apt/lists/ && \
    apt-get clean  && \

    # Install nodejs, npm etc.
    # https://github.com/nodesource/distributions
    # curl -sL -k https://deb.nodesource.com/setup_${NODE_VERSION} | bash -  && \
    # apt-get install -yq nodejs && \
    # apt-get clean && \
    # rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    # npm install -g npm && \
    # npm install --quiet -g npm-check-updates eslint jshint node-gyp gulp bower mocha karma-cli react-native-cli && \
    # npm cache clean

# Install Android SDK
RUN wget -q -O tools.zip https://dl.google.com/android/repository/tools_r${ANDROID_SDK_VERSION}-linux.zip && \
    unzip -q tools.zip && \
    rm -fr $ANDROID_HOME tools.zip && \
    mkdir -p $ANDROID_HOME && \
    mv tools $ANDROID_HOME/tools && \

    # Install Android components
    cd $ANDROID_HOME && \

    echo "Install android-16" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter android-16 && \
    echo "Install android-17" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter android-17 && \
    echo "Install android-18" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter android-18 && \
    echo "Install android-19" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter android-19 && \
    echo "Install android-20" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter android-20 && \
    echo "Install android-21" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter android-21 && \
    echo "Install android-22" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter android-22 && \
    echo "Install android-23" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter android-23 && \
    echo "Install android-24" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter android-24 && \
    echo "Install android-25" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter android-25 && \

    echo "Install platform-tools" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter platform-tools && \

    echo "Install build-tools-21.1.2" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter build-tools-21.1.2 && \
    echo "Install build-tools-22.0.1" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter build-tools-22.0.1 && \
    echo "Install build-tools-23.0.1" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter build-tools-23.0.1 && \
    echo "Install build-tools-23.0.2" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter build-tools-23.0.2 && \
    echo "Install build-tools-23.0.3" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter build-tools-23.0.3 && \
    echo "Install build-tools-24" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter build-tools-24 && \
    echo "Install build-tools-24.0.1" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter build-tools-24.0.1 && \
    echo "Install build-tools-24.0.2" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter build-tools-24.0.2 && \
    echo "Install build-tools-24.0.3" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter build-tools-24.0.3 && \
    echo "Install build-tools-25" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter build-tools-25 && \
    echo "Install build-tools-25.0.1" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter build-tools-25.0.1 && \
    echo "Install build-tools-25.0.2" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter build-tools-25.0.2 && \
    echo "Install build-tools-25.0.3" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter build-tools-25.0.3 && \

    echo "Install extra-android-m2repository" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter extra-android-m2repository && \

    echo "Install extra-google-google_play_services" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter extra-google-google_play_services && \

    echo "Install extra-google-m2repository" && \
    echo y | tools/android --silent update sdk --no-ui --all --filter extra-google-m2repository

# Install Android NDK, put it in a separate RUN to avoid travis-ci timeout in 10 minutes.
RUN wget -q -O android-ndk.zip http://dl.google.com/android/repository/android-ndk-r${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
    unzip -q android-ndk.zip && \
    rm -fr $ANDROID_NDK android-ndk.zip && \
    mv android-ndk-r${ANDROID_NDK_VERSION} $ANDROID_NDK

# Add android commands to PATH
ENV ANDROID_SDK_HOME $ANDROID_HOME
ENV PATH $PATH:$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools:$ANDROID_NDK

# Export JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

# Support Gradle
ENV TERM dumb
ENV JAVA_OPTS "-Xms512m -Xmx1024m"
ENV GRADLE_OPTS "-XX:+UseG1GC -XX:MaxGCPauseMillis=1000"

# Confirms that we agreed on the Terms and Conditions of the SDK itself
# (if we didn’t the build would fail, asking us to agree on those terms).
RUN mkdir "${ANDROID_HOME}/licenses" || true
RUN echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > "${ANDROID_HOME}/licenses/android-sdk-license"

# Install Fastlane
RUN gem install fastlane -NV#!/usr/bin/env bash

##############################################################################
##
##  Gradle start up script for UN*X
##
##############################################################################

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS=""

APP_NAME="Gradle"
APP_BASE_NAME=`basename "$0"`

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

warn ( ) {
    echo "$*"
}

die ( ) {
    echo
    echo "$*"
    echo
    exit 1
}

# OS specific support (must be 'true' or 'false').
cygwin=false
msys=false
darwin=false
case "`uname`" in
  CYGWIN* )
    cygwin=true
    ;;
  Darwin* )
    darwin=true
    ;;
  MINGW* )
    msys=true
    ;;
esac

# For Cygwin, ensure paths are in UNIX format before anything is touched.
if $cygwin ; then
    [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
fi

# Attempt to set APP_HOME
# Resolve links: $0 may be a link
PRG="$0"
# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`"/$link"
    fi
done
SAVED="`pwd`"
cd "`dirname \"$PRG\"`/" >/dev/null
APP_HOME="`pwd -P`"
cd "$SAVED" >/dev/null

CLASSPATH=$APP_HOME/gradle/wrapper/gradle-wrapper.jar

# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
        # IBM's JDK on AIX uses strange locations for the executables
        JAVACMD="$JAVA_HOME/jre/sh/java"
    else
        JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ] ; then
        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
    fi
else
    JAVACMD="java"
    which java >/dev/null 2>&1 || die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
fi

# Increase the maximum file descriptors if we can.
if [ "$cygwin" = "false" -a "$darwin" = "false" ] ; then
    MAX_FD_LIMIT=`ulimit -H -n`
    if [ $? -eq 0 ] ; then
        if [ "$MAX_FD" = "maximum" -o "$MAX_FD" = "max" ] ; then
            MAX_FD="$MAX_FD_LIMIT"
        fi
        ulimit -n $MAX_FD
        if [ $? -ne 0 ] ; then
            warn "Could not set maximum file descriptor limit: $MAX_FD"
        fi
    else
        warn "Could not query maximum file descriptor limit: $MAX_FD_LIMIT"
    fi
fi

# For Darwin, add options to specify how the application appears in the dock
if $darwin; then
    GRADLE_OPTS="$GRADLE_OPTS \"-Xdock:name=$APP_NAME\" \"-Xdock:icon=$APP_HOME/media/gradle.icns\""
fi

# For Cygwin, switch paths to Windows format before running java
if $cygwin ; then
    APP_HOME=`cygpath --path --mixed "$APP_HOME"`
    CLASSPATH=`cygpath --path --mixed "$CLASSPATH"`
    JAVACMD=`cygpath --unix "$JAVACMD"`

    # We build the pattern for arguments to be converted via cygpath
    ROOTDIRSRAW=`find -L / -maxdepth 1 -mindepth 1 -type d 2>/dev/null`
    SEP=""
    for dir in $ROOTDIRSRAW ; do
        ROOTDIRS="$ROOTDIRS$SEP$dir"
        SEP="|"
    done
    OURCYGPATTERN="(^($ROOTDIRS))"
    # Add a user-defined pattern to the cygpath arguments
    if [ "$GRADLE_CYGPATTERN" != "" ] ; then
        OURCYGPATTERN="$OURCYGPATTERN|($GRADLE_CYGPATTERN)"
    fi
    # Now convert the arguments - kludge to limit ourselves to /bin/sh
    i=0
    for arg in "$@" ; do
        CHECK=`echo "$arg"|egrep -c "$OURCYGPATTERN" -`
        CHECK2=`echo "$arg"|egrep -c "^-"`                                 ### Determine if an option

        if [ $CHECK -ne 0 ] && [ $CHECK2 -eq 0 ] ; then                    ### Added a condition
            eval `echo args$i`=`cygpath --path --ignore --mixed "$arg"`
        else
            eval `echo args$i`="\"$arg\""
        fi
        i=$((i+1))
    done
    case $i in
        (0) set -- ;;
        (1) set -- "$args0" ;;
        (2) set -- "$args0" "$args1" ;;
        (3) set -- "$args0" "$args1" "$args2" ;;
        (4) set -- "$args0" "$args1" "$args2" "$args3" ;;
        (5) set -- "$args0" "$args1" "$args2" "$args3" "$args4" ;;
        (6) set -- "$args0" "$args1" "$args2" "$args3" "$args4" "$args5" ;;
        (7) set -- "$args0" "$args1" "$args2" "$args3" "$args4" "$args5" "$args6" ;;
        (8) set -- "$args0" "$args1" "$args2" "$args3" "$args4" "$args5" "$args6" "$args7" ;;
        (9) set -- "$args0" "$args1" "$args2" "$args3" "$args4" "$args5" "$args6" "$args7" "$args8" ;;
    esac
fi

RUN apt-get update && \
    apt-get install -y --no-install-recommends mercurial

ENV HGAPP /usr/bin/hg

# Split up the JVM_OPTS And GRADLE_OPTS values into an array, following the shell quoting and substitution rules
function splitJvmOpts() {
    JVM_OPTS=("$@")
}
eval splitJvmOpts $DEFAULT_JVM_OPTS $JAVA_OPTS $GRADLE_OPTS
JVM_OPTS[${#JVM_OPTS[*]}]="-Dorg.gradle.appname=$APP_BASE_NAME"

exec "$JAVACMD" "${JVM_OPTS[@]}" -classpath "$CLASSPATH" org.gradle.wrapper.GradleWrapperMain "$@"
