**1. Infrastructure setup using Terraform:**

**Creating user in aws for AWS cli:**

<img width="940" height="323" alt="image" src="https://github.com/user-attachments/assets/9aecac26-9d8b-4c1a-99d6-2d2ff8dbd14d" />

**Attached the EC2 access policy and IAM policy for the created user:**

<img width="940" height="303" alt="image" src="https://github.com/user-attachments/assets/5116a62d-4628-46e3-ab7b-c50ea74c461b" />

**Created the access key and secrets using which we connect AWS via CLI:**

<img width="940" height="191" alt="image" src="https://github.com/user-attachments/assets/d2f13989-d1b6-44ac-a9a4-2ef2282e187d" />

<img width="940" height="199" alt="image" src="https://github.com/user-attachments/assets/2d31c36d-3c2e-462e-a807-0e2bed680a43" />

<img width="940" height="451" alt="image" src="https://github.com/user-attachments/assets/1fe8758d-9c33-4cf0-88bd-188f1325e8d6" />

**AWS CLI setup:**

<img width="565" height="79" alt="image" src="https://github.com/user-attachments/assets/cc46c2fa-baf3-4ff7-a6a4-ced3f27e6bc6" />

**Verifying the login:**

<img width="759" height="191" alt="image" src="https://github.com/user-attachments/assets/1d809ee9-cf15-488c-9331-fb275197adb0" />

**Created all the terraform files and the same has been pushed into the repo:**

<img width="389" height="195" alt="image" src="https://github.com/user-attachments/assets/6daa45a7-2bc6-4a04-ab56-90dad1fdbd4b" />

**Initialised terraform:**

<img width="706" height="158" alt="image" src="https://github.com/user-attachments/assets/ee4bc0fe-196a-43a9-9119-151317720faf" />

**Validation check passed:**

<img width="645" height="59" alt="image" src="https://github.com/user-attachments/assets/d7fdbfd6-ff40-4146-a002-ff539856be4b" />

**Plan completed:**

<img width="940" height="398" alt="image" src="https://github.com/user-attachments/assets/4bcf108d-3c07-45ae-b1c6-c11cadc03d2d" />

**Terraform apply done:**

<img width="940" height="347" alt="image" src="https://github.com/user-attachments/assets/8bd4a337-d923-4f45-ab86-7ab8f1ccfb49" />

<img width="694" height="184" alt="image" src="https://github.com/user-attachments/assets/fb8dc868-65f3-4a57-ae15-a2fa3955a732" />

**Checked the created instance from AWS console:**

<img width="940" height="246" alt="image" src="https://github.com/user-attachments/assets/75e88a4f-492e-47b9-b12d-478c3ce21880" />

**2. Ansible setup:**

**Logged in the web server to install ansible into it:**

<img width="940" height="380" alt="image" src="https://github.com/user-attachments/assets/243ae870-924e-4a84-8c06-21517a63829d" />

**Ran the below command to install ansible:**

<img width="940" height="119" alt="image" src="https://github.com/user-attachments/assets/2ddc747e-2de2-43cf-9647-78c99f133440" />

**Verified the installation:**

<img width="1415" height="260" alt="image" src="https://github.com/user-attachments/assets/ecbeb119-f337-4c7f-b72d-d870b75a0551" />

**Uploaded the pem key into the web server and created a directory named ansible:**

<img width="706" height="121" alt="image" src="https://github.com/user-attachments/assets/1f8523fb-6145-4346-b4f1-109c7bec2d2f" />

**Created the inventory.ini file into the ansible directory and have attached the yaml file in repo:**

<img width="878" height="298" alt="image" src="https://github.com/user-attachments/assets/32e84430-9564-4134-a4e3-0a002cd32c0c" />

**Created the web.yml file and have added the yaml file in repo:**

<img width="869" height="646" alt="image" src="https://github.com/user-attachments/assets/ba243983-fd1a-4b2b-9829-205f443423b6" />

**Tested the web.yml file:**

<img width="940" height="114" alt="image" src="https://github.com/user-attachments/assets/f5a52f0c-0d73-4d5c-a94b-a4ee0fb8a258" />

**Created db.yml file and tested it. The same yaml file as been added in repo:**

<img width="940" height="406" alt="image" src="https://github.com/user-attachments/assets/cc855f9b-1f88-44f2-b050-a09fbe01c573" />

<img width="940" height="127" alt="image" src="https://github.com/user-attachments/assets/054dc63c-9e24-46e3-a006-baef20cb9829" />

**Created the deploy.yml and tested it. The deploy.yml is added in the repo:**

  <img width="1902" height="355" alt="image" src="https://github.com/user-attachments/assets/dceed690-fea4-49b5-a96b-95f132104f2c" />

**Verified if the application is working fine:**

<img width="940" height="361" alt="image" src="https://github.com/user-attachments/assets/e0ea20b1-4ca6-4623-8181-a65ed607bbd4" />

**Disabled the root login:**

<img width="940" height="112" alt="image" src="https://github.com/user-attachments/assets/73c0a47d-b23a-4075-b9c4-387c908ff5f8" />

