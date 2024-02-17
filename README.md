# siemens-assignment
1. This project was created to deploy highly available and scalable infrastructure in aws using terraform.
2. The project serve the web application running behind the nginx web server which is deployed on multiple Ec2 instances.
3. There auto scaling policy scale down the infra to 1 ec2 instance and scale up to 3 ec2 instances depending upon the load.
4. To login to the web server, I have deployed a bastion host in public subnet and from the bastion host we can connect to the web server.
5. There is no need to have key file for web server as it was deployed to accept only login through username and password. The web server is only access for management purpose.
6. I have created 2 private subnet and 2 public subnet each in different availability zone to make the application highly available. The web servers has been deployed in private subnets. The ALB has been deployed to public subnet. You will get the dns name of ALB as an terraform output after the deployment gets complete.
7. Since the Nginx server was installed and configured through Ansible after ec2 boots hence I have deployed NAT Gateway to get this done.
8. I have downloaded the nginx config file and html file on the web server with help of public git repository which I have created during the process.
9. The deployment has created a private hosted zone which has created a record set so that test.example.com points to the ALB dns although, it gets resolved internally inside the vpc as it is in private hosted zone.
10. Bash script in user data has created the self-signed certificate for test.example.com and thereby nginx configuration consumes the certificate.
11. We have encrypted the root file system and the other volume that was attached to the instance. The other volume has been mounted on /var/log path. This ensures the data is encrypted at rest.

#Inputs:
1. The terraform deployment will accept the aws profile name so If you want to run it on your system, you need to first create the aws profile on your system using aws configure --profile <profile_name>.
2. You need to make sure that the aws user has administrator rights on the aws account on which you want to deploy the whole infrastructure.
3. Only you have to give the porfile name as an input rest all the inputs are provided in tfvars file. You can change those values as per your requirement.
4. Caution: If you need to change the AWS Region then accordingly you need to change the image id as image id is region specific.
5. All Ec2 instances are ubuntu based so all the commands passed on user data script is for ubuntu only. You can choose any OS type but accordingly you have to make modification to user data script.



