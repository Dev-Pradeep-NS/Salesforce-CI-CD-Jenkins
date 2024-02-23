### --> Setup JWT Flow to Integrate Jenkins with Salesforce
### --> Create Connected App for JWT-Based Flow
### --> connect Jenkins with GitHub using SSH.
### --> Configure the Jenkins environment Variable
#### SF_USERNAME—The username for the Dev Hub org, such as juliet.capulet@myenvhub.com.
#### SF_INSTANCE_URL—The login URL of the Salesforce instance that hosts the Dev Hub org. The default is https://login.salesforce.com. We recommend that you update this value to the My Domain login URL for the Dev Hub org. You can find an org’s My Domain login URL on the My Domain page in Setup.
#### SF_CONSUMER_KEY—The consumer key that was returned after you created a connected app in your Dev Hub org.

### --> Download salesforce cli in jenkins user
##### switch to the jenkins user
    sudo -su jenkins
##### install node js(20) and npm in jenkins user using:
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
    sudo apt-get install -y nodejs
##### install salesforce cli
    npm install @salesforce/cli --global

## Configure the Jenkins
Add New Item. Then provide the project name and select type of project as Multibranch.
Add Source and provide repository URL
Start a Build