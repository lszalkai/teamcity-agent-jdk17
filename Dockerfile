FROM jetbrains/teamcity-agent

USER root

RUN curl -L "https://github.com/docker/compose/releases/download/2.2.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN mkdir /opt/java/jdk-17

RUN curl -fsSL https://download.java.net/java/GA/jdk17.0.1/2a2082e5a09d4267845be086888add4f/12/GPL/openjdk-17.0.1_linux-x64_bin.tar.gz | tar -xvzf - -C /opt/java/jdk-17 --strip-components=1 

ENV JDK_17_64 /opt/java/jdk-17

ENV JRE_HOME /opt/java/jdk-17
ENV JAVA_HOME /opt/java/jdk-17
ENV PATH="$JAVA_HOME/bin:$PATH"

RUN update-alternatives --install /usr/bin/java java ${JRE_HOME}/bin/java 1 && \
    update-alternatives --set java ${JRE_HOME}/bin/java && \
    update-alternatives --install /usr/bin/javac javac ${JAVA_HOME}/bin/javac 1 && \
    update-alternatives --set javac ${JAVA_HOME}/bin/javac
