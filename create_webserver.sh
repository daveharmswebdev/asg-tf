#!/bin/bash

# Define a log file for user data
LOGFILE="/var/log/user-data.log"

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

# Start logging
log "User data script started."

# Update system packages and log output
log "Updating system packages..."
sudo yum update -y >> $LOGFILE 2>&1

# Install Apache (httpd) and log output
log "Installing Apache (httpd)..."
sudo yum install -y httpd >> $LOGFILE 2>&1

# Start and enable Apache to start on boot and log output
log "Starting and enabling Apache..."
sudo systemctl start httpd >> $LOGFILE 2>&1
sudo systemctl enable httpd >> $LOGFILE 2>&1

# Create the index.html file and log output
log "Creating index.html with hostname and public IP..."
echo "Hello World from instance $(hostname) - IP: $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 || echo 'IP not available')" | sudo tee /var/www/html/index.html >> $LOGFILE 2>&1

# Optional: Restart Apache to make sure it's serving the latest content
log "Restarting Apache..."
sudo systemctl restart httpd >> $LOGFILE 2>&1

# Finish logging
log "User data script completed."
