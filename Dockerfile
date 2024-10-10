# Use a base image with Maven and JDK 17
FROM maven:3.8.4-openjdk-17 as build

# Set the working directory in the container
WORKDIR /app

# Copy only the pom.xml initially to cache Maven dependencies
COPY pom.xml .

# Download dependencies as a separate layer for caching
RUN mvn dependency:go-offline

# Copy the rest of the project files into the container
COPY . .

# Ensure the generate_lock_file.sh script is executable
RUN chmod +x generate_lock_file.sh

# Build the dependency tree and dependency lock file
RUN mvn dependency:tree -DoutputFile=dependency-tree.txt -DoutputType=text
RUN ./generate_lock_file.sh dependency-tree.txt dependency-lock.xml

# Compile and package the application
RUN mvn clean install

# Command to run the application
CMD ["mvn", "spring-boot:run"]