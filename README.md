# Jenkins-Salesforce Integration Guide

This guide outlines the steps to integrate Jenkins, a popular automation server, with Salesforce, a leading CRM platform. By integrating Jenkins with Salesforce, you can automate various tasks like testing and source code deployment from one org to another.

## Prerequisites

- Jenkins: Ensure Jenkins is installed and running on your system.
- Salesforce: Have access to a Salesforce Developer Hub org and necessary permissions to create Connected Apps.
- GitHub: Have your Salesforce project hosted on GitHub for version control.

## Setup JWT Flow to Integrate Jenkins with Salesforce

1. **Create Connected App for JWT-Based Flow:**
   - Log in to your Salesforce Developer Hub org.
   - Navigate to Setup > App Manager > New Connected App.
   - Fill out the required information, including Callback URL (can be any valid URL), and enable OAuth settings.
   - Make sure to select "Use digital signatures" and "Enable for Device Flow" checkboxes.
   - Save the Connected App and note down the Consumer Key.

2. **Configure Environment Variables in Jenkins:**
   - Set the following environment variables in Jenkins:
     - **SF_USERNAME**: The username for the Salesforce Developer Hub org.
     - **SF_INSTANCE_URL**: The login URL of the Salesforce instance that hosts the Dev Hub org. Update to My Domain login URL if applicable.
     - **SF_CONSUMER_KEY**: The Consumer Key generated for the Connected App.
     - **SERVER_KEY_PASSWORD**: The password used to encrypt the server.key.enc file.

3. **Download Salesforce CLI in Jenkins User:**
   - Switch to the Jenkins user:
     ```bash
     sudo -su jenkins
     ```
   - Install Node.js and npm:
     ```bash
     curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
     sudo apt-get install -y nodejs
     ```
   - Install Salesforce CLI:
     ```bash
     npm install @salesforce/cli --global
     ```

## Connect Jenkins with GitHub using SSH

1. Generate SSH key pair in Jenkins:
   - Switch to Jenkins user.
   - Generate SSH key pair using `ssh-keygen`.
2. Add SSH public key to GitHub:
   - Copy the public key generated in the previous step.
   - Add it to your GitHub account's SSH keys.
3. Test the SSH connection:
   - Run `ssh -T git@github.com` to verify the SSH connection to GitHub.

## Configure Jenkins

1. **Add New Item:**
   - Go to Jenkins Dashboard and click on **New Item**.
   - Provide the project name and select the type of project as Multibranch.
2. **Add Source:**
   - Provide the repository URL and configure branch sources.
3. **Start a Build:**
   - Trigger a build to test the Salesforce integration.


