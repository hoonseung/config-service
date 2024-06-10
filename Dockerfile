FROM eclipse-temurin:17-jdk AS builder
WORKDIR workspace
ARG JAR_FILE=build/libs/*-SNAPSHOT.jar
COPY ${JAR_FILE} config-service.jar
RUN java -Djarmode=layertools -jar config-service.jar extract


FROM eclipse-temurin:17-jdk
RUN adduser config
USER config
WORKDIR workspace
COPY --from=builder workspace/dependencies/ ./
COPY --from=builder workspace/spring-boot-loader/ ./
COPY --from=builder workspace/snapshot-dependencies/ ./
COPY --from=builder workspace/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]