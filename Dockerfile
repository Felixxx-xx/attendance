# Use the official Tomcat 9 image with Java 11 (Servlet 4.0 / javax namespace).
# If Docker Hub reports "manifest unknown" for this tag, the equivalent tag is
#   FROM tomcat:9.0-jdk11-temurin
FROM tomcat:9.0-jdk11-corretto

# Remove the default Tomcat welcome applications (optional)
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager

# Copy the war file into Tomcat's webapps folder.
# The file name decides the context path: attendance.war -> /attendance
COPY attendance.war /usr/local/tomcat/webapps/attendance.war

# Use an entry point that adapts the port to Render's PORT variable
COPY entrypoint.sh /usr/local/tomcat/bin/entrypoint.sh
RUN chmod +x /usr/local/tomcat/bin/entrypoint.sh

EXPOSE 8080
CMD ["/usr/local/tomcat/bin/entrypoint.sh"]
