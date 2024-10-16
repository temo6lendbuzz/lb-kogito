# Use a base image with Maven and JDK 17
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy only the pom.xml initially to cache Maven dependencies
COPY pom.xml .

# Download dependencies as a separate layer for caching
RUN mvn dependency:go-offline

# Copy the rest of the project files into the container
COPY . .

# Compile and package the application
RUN mvn clean install

# Command to run the application
CMD ["mvn", "spring-boot:run"]