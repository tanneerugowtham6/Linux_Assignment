# Linux_Assignment

---

## Problem Statement

Rahul, a Senior DevOps engineer at TechCorp, needs to set up and manage development environments for two new developers, Sarah and Mike. The setup must ensure proper system monitoring, user management, troubleshooting capabilities, and automated backup procedures.

As a Fresher DevOps Engineer, you are assisting Rahul in implementing a secure, monitored, and well-maintained development environment that meets the organization’s operational and security standards. Additionally, Sarah and Mike are tasked with setting up automated backups for their respective web servers.

### Task 1: System Monitoring Setup

Install and configure htop or nmon to monitor CPU, memory, and processes, using df and du for disk usage tracking, and identifying resource-intensive processes. Proper logging of system metrics and clear documentation of the setup are essential. 

### Task 2: User Management and Access Control

Evaluation includes creating user accounts for Sarah and Mike with secure passwords, setting up isolated directories with appropriate permissions, and enforcing a password policy with expiration and complexity. Detailed documentation of user management steps is required. 

### Task 3: Backup Configuration for Web Servers

Configure automated backups for Apache (/etc/httpd/, /var/www/html/) and Nginx (/etc/nginx/, /usr/share/nginx/html/), scheduling cron jobs to run every Tuesday at 12:00 AM, using the correct naming convention for backup files, and verifying backup integrity. Proper documentation and logs are necessary. 

Overall Report and Presentation

The report should clearly summarize implementation steps and challenges, including relevant screenshots or terminal outputs demonstrating task completion.

---

## Practice Assignment on Testing, Linux and Servers
This repository consists of Assignments performed as part of HeroVired Program.

---

## Environment
**OS:** Ubuntu
**Cloud:** AWS

---

## Task-1: System Monitoring Setup

### Steps:
1. **Update the repositories and install htop**

    ```sh
    sudo apt update
    sudo apt install -y htop
    ```

    <img width="692" height="164" alt="image" src="https://github.com/user-attachments/assets/6b4fd4c5-9809-43df-8d1e-45ea5776e4a4" />
    <img width="500" height="93" alt="image" src="https://github.com/user-attachments/assets/1b3fe4aa-92c9-471e-a336-f8a60201ff6e" />
    <img width="452" height="115" alt="image" src="https://github.com/user-attachments/assets/c7707d96-d717-48c5-9899-ab3763a34f63" />

2. **Verify the htop installation**
    
    ```sh
    htop
    ```
    <img width="1293" height="817" alt="image" src="https://github.com/user-attachments/assets/8cde10df-dd95-4d8a-b070-07e98678bb46" />

3. **Check Disk Usage using df and du Commands**
    
    ```sh
    df -h
    du -sh /home /var /etc 2>/dev/null
    ```

    <img width="459" height="160" alt="image" src="https://github.com/user-attachments/assets/0aaa0fe7-5f9e-4906-91d9-8099b91b7bc2" />
    <img width="432" height="74" alt="image" src="https://github.com/user-attachments/assets/c8eb6779-1020-4ec0-a807-8043a732368f" />

4. **Create a separate directory for System Monitoring Logs**

    ```sh
    sudo mkdir /var/log/monitoring
    sudo chmod 755 /var/log/monitoring
    ```

    <img width="436" height="46" alt="image" src="https://github.com/user-attachments/assets/dfe3f733-3a06-45a6-a8cc-fc44bd976867" />

5. **Create a script file to Generate the System Monitoring Logs and Execute it**

    ```sh
    sudo nano /usr/local/bin/initial_metrics.sh
    ```

    Add the below script in the file

    ```sh
    #!/usr/bin/env bash

    LOGDIR="/var/log/monitoring"
    mkdir -p "$LOGDIR"
    
    LOGFILE="$LOGDIR/initial_metrics_$(date +%F_%H-%M-%S).log"
    
    {
      echo "=== Initial System Metrics - $(date) ==="
      echo ""
      echo "---- TOP (first 20 lines) ----"
      top -b -n1 | head -n 20
      echo ""
      echo "---- Highest CPU processes ----"
      ps aux --sort=-%cpu | head -n 15
      echo ""
      echo "---- Highest Memory processes ----"
      ps aux --sort=-%mem | head -n 15
      echo ""
      echo "---- Disk usage (df -h) ----"
      df -h
      echo ""
      echo "---- Memory usage (free -h) ----"
      free -h || true
      echo ""
      echo "=== End of Report ==="
    } > "$LOGFILE"
    ```

    <img width="414" height="393" alt="image" src="https://github.com/user-attachments/assets/227dde22-bd58-4601-ad67-b1273b322e1e" />

    Save the file and Exit [`Ctrl+x` & `Enter` (or) `control+x` & `return`]
   
    <img width="503" height="34" alt="image" src="https://github.com/user-attachments/assets/6119ea73-5ed8-41ab-b4c1-90e724b5590d" />

    ```sh
    sudo chmod +x /usr/local/bin/initial_metrics.sh
    ```
    
    <img width="527" height="34" alt="image" src="https://github.com/user-attachments/assets/e416a4c9-9caf-482f-a8b6-d2db1bc7b9d2" />

    Execute the script and check if the file is created.
   
    ```sh
    sudo /usr/local/bin/initial_metrics.sh
    ls -l /var/log/monitoring/
    ```

    <img width="569" height="73" alt="image" src="https://github.com/user-attachments/assets/c1901aa3-0dea-4a38-9a3f-5f4c40766651" />
    
6. **Create a script file to Generate Disk Usage Logs and Execute it**


    ```sh
    sudo nano /usr/local/bin/disk_usage.sh
    ```

    Add the below script in the file
   
    ```sh
    #!/usr/bin/env bash

    LOGDIR="/var/log/monitoring"
    mkdir -p "$LOGDIR"
    
    LOGFILE="$LOGDIR/disk_usage_$(date +%F_%H-%M-%S).log"
    
    {
      echo "=== Disk Usage Report - $(date) ==="
      echo ""
      echo "---- df -h ----"
      df -h
      echo ""
      echo "---- Largest Directories in / ----"
      du -sh /* 2>/dev/null | sort -h | tail -n 10
      echo ""
      echo "=== End of Report ==="
    } > "$LOGFILE"
    ```

    <img width="381" height="269" alt="image" src="https://github.com/user-attachments/assets/384305cf-6b46-4ab4-8358-385c6ec68118" />

    Save the file and Exit [`Ctrl+x` & `Enter` (or) `control+x` & `return`]

    <img width="466" height="29" alt="image" src="https://github.com/user-attachments/assets/ecdcf078-6453-4ca6-8044-8d0af664d429" />

    ```sh
    sudo chmod +x /usr/local/bin/disk_usage.sh
    ```
    
    <img width="494" height="28" alt="image" src="https://github.com/user-attachments/assets/38b2eb1b-ca22-4bf5-9990-6f0a792a4489" />

    Execute the script and check if the file is created.
   
    ```sh
    sudo /usr/local/bin/disk_usage.sh
    ls -l /var/log/monitoring/disk_usage_*.log | tail -n 1
    ```

    <img width="433" height="30" alt="image" src="https://github.com/user-attachments/assets/fb019307-a79c-4b8f-9206-13c5757156e9" />
    <img width="672" height="45" alt="image" src="https://github.com/user-attachments/assets/15801922-c2d9-41aa-a3e4-25008ede7e57" />

7. **Create a Script to identify Resource-Intensive applications**

    ```sh
    sudo nano /usr/local/bin/top_process_report.sh
    ```

    Add the below script in the file
   
    ```sh
    #!/usr/bin/env bash

    LOGDIR="/var/log/monitoring"
    mkdir -p "$LOGDIR"
    
    LOGFILE="$LOGDIR/top_proc_$(date +%F).log"
    
    {
      echo "=== Top Processes Report - $(date) ==="
      echo ""
      echo "---- Top CPU consumers ----"
      ps aux --sort=-%cpu | head -n 15
      echo ""
      echo "---- Top Memory consumers ----"
      ps aux --sort=-%mem | head -n 15
      echo ""
      echo "---- Snapshot of top (first 20 lines) ----"
      top -b -n1 | head -n 20
      echo ""
      echo "=== End of Report ==="
    } > "$LOGFILE"
    ```

    <img width="368" height="311" alt="image" src="https://github.com/user-attachments/assets/80c10fa9-593d-406d-9ec4-67fa2ba88507" />

    Save the file and Exit [`Ctrl+x` & `Enter` (or) `control+x` & `return`]

    <img width="520" height="29" alt="image" src="https://github.com/user-attachments/assets/dff2cc78-c4d8-4e1c-99cf-61d4c0f988aa" />

    ```sh
    sudo chmod +x /usr/local/bin/top_process_report.sh
    ```
    
    <img width="549" height="29" alt="image" src="https://github.com/user-attachments/assets/e90310c2-d193-40ac-81b7-b9ff058a9ebd" />

    Execute the script and check if the file is created.
   
    ```sh
    sudo /usr/local/bin/top_process_report.sh
    ls -l /var/log/monitoring/top_process_report_*.log | tail -n 1
    ```
    
    <img width="597" height="58" alt="image" src="https://github.com/user-attachments/assets/9158437e-4a0d-4d52-a54f-5d7b4a1e2b0c" />

8. **Configure Cron Jobs to Automate Monitoring**

    ```sh
    sudo crontab -e
    Choose 1-4 [1]: 1
    ```

    <img width="401" height="141" alt="image" src="https://github.com/user-attachments/assets/7fd2e068-59fa-4949-850d-e92bd289519b" />

    Add the below cron jobs schedule to the file 

    ```sh
    # initial metrics.sh Cron Job
    */15 * * * * /usr/local/bin/initial_metrics.sh
    # top_process_report.sh Cron Job
    0 0 * * * /usr/local/bin/top_process_report.sh
    # disk_usage.sh Cron Job
    0 0 * * * /usr/local/bin/disk_usage.sh
    ```

    <img width="490" height="438" alt="image" src="https://github.com/user-attachments/assets/a6367e23-506b-4002-875c-9d38bd0d1533" />
    <img width="403" height="156" alt="image" src="https://github.com/user-attachments/assets/3d9c8408-9bd2-4983-8c1a-63092fb17f05" />

---

## Task-2: User Management & Access Control

### Steps:

1. **Create user accounts for Sarah and Mike**

    ```sh
    sudo useradd -m -d /home/Sarah -s /bin/bash Sarah
    sudo useradd -m -d /home/Mike -s /bin/bash Mike
    ```

    <img width="541" height="31" alt="image" src="https://github.com/user-attachments/assets/5ff3d36c-c6f6-41c7-802d-947cf85710a3" />
    <img width="541" height="29" alt="image" src="https://github.com/user-attachments/assets/bc4e0cbe-d4f5-4e22-a1e9-ea18c97b448d" />

2. **Set password for the user's [Sarah & Mike]**

    ```sh
    sudo passwd Sarah
    ```

    <img width="325" height="74" alt="image" src="https://github.com/user-attachments/assets/3ef5b55a-edc7-4c91-a37c-cd79d8cae9eb" />

    ```sh
    sudo passwd Mike
    ```

    <img width="325" height="69" alt="image" src="https://github.com/user-attachments/assets/c0fd97a0-6218-4a5a-b78d-495fe629d0cc" />

3. **Create Workspace Directories for each user**

    ```sh
    sudo mkdir -p /home/Sarah/workspace
    sudo mkdir -p /home/Mike/workspace
    ```

    <img width="443" height="26" alt="image" src="https://github.com/user-attachments/assets/db6e448b-8e9e-48ce-8054-afc7ea8a85a5" />
    <img width="443" height="28" alt="image" src="https://github.com/user-attachments/assets/4256dfde-6e4a-443d-aec5-40017a13997d" />

4. **Apply directory Ownership and Permissions**

    ```sh
    # Assign ownership to each user
    sudo chown -R Sarah:Sarah /home/Sarah
    sudo chown -R Mike:Mike /home/Mike
    ```

    <img width="457" height="29" alt="image" src="https://github.com/user-attachments/assets/4dd70ebf-d728-4cc1-bf40-7eeaafa57ade" />
    <img width="457" height="29" alt="image" src="https://github.com/user-attachments/assets/f40f5ee7-62b7-43bd-afdf-822df7004071" />

    ```sh
    # Restrict access to only the owner to Read/Write/Execute their workspace
    sudo chmod 700 /home/Sarah
    sudo chmod 700 /home/Sarah/workspace

    sudo chmod 700 /home/Mike
    sudo chmod 700 /home/Mike/workspace
    ```

    <img width="457" height="42" alt="image" src="https://github.com/user-attachments/assets/84b91cf3-41cf-43a9-88a1-4e7b86d9543a" />
    <img width="457" height="42" alt="image" src="https://github.com/user-attachments/assets/0a1d51ee-15f7-437b-9da1-6715738b85a6" />

    Verify the permissions of the directories.

    ```sh
    sudo ls -ld /home/Sarah /home/Sarah/workspace /home/Mike /home/Mike/workspace
    ```

    <img width="741" height="87" alt="image" src="https://github.com/user-attachments/assets/4fc703be-6923-49ce-81c0-6e49bc3968e9" />

5. **Configure password expiration policy(30 days)**

    ```sh
    sudo chage -M 30 Sarah
    sudo chage -M 30 Mike
    ```
    
    <img width="364" height="46" alt="image" src="https://github.com/user-attachments/assets/71b14c2f-6192-468c-9b3d-18106fd2bb2d" />

    Verify password expiration policy has been set.

    ```sh
    sudo chage -l Sarah
    sudo chage -l Mike
    ```

    <img width="503" height="126" alt="image" src="https://github.com/user-attachments/assets/f55af2c3-bbd7-444e-8847-f4f996a08740" />
    <img width="503" height="126" alt="image" src="https://github.com/user-attachments/assets/2f1a911a-6843-4e72-b03c-5695b065edd8" />

6. **Configure password complexity requirement**

    Ensure password complexity as below,
    - Minimum length: 8
    - At least 1 uppercase
    - At least 1 lowercase
    - At least 1 digit
    - At least 1 special character
    
    `Ubuntu 24.04 uses pwquality via PAM`
  
    ```sh
    sudo nano /etc/security/pwquality.conf
    ```

    Add the below lines in the `pwquality.conf` file
   
    <img width="574" height="771" alt="image" src="https://github.com/user-attachments/assets/2e13cb04-fda5-4b47-911f-3beeb24f0900" />

    Save the file and Exit [`Ctrl+x` & `Enter` (or) `control+x` & `return`]
   
    <img width="469" height="29" alt="image" src="https://github.com/user-attachments/assets/bab302de-97f8-4772-96c0-9764008acc2d" />

    ```sh
    sudo cp /etc/pam.d/common-password /etc/pam.d/common-password.bak
    ```

    Append `enforce_for_root` at `pam_pwquality.so retry=3`

    <img width="734" height="493" alt="Untitled" src="https://github.com/user-attachments/assets/f849d674-8232-44ec-aac5-27068ed9f7cc" />


7. **Validate password expiration and Complexity policies**

    To confirm Ubuntu is actually enforcing the policy configured.

    ```sh
    grep pwquality /etc/pam.d/common-password
    ```

    <img width="703" height="42" alt="image" src="https://github.com/user-attachments/assets/53525b05-acb9-4ba0-9a7d-c664cbde7b31" />


    Testing the password complexity policy

    ```sh
    sudo passwd Sarah
    sudo passwd Mike
    ```

    <img width="481" height="142" alt="image" src="https://github.com/user-attachments/assets/e310e199-7d6d-4ebe-bcf4-0d7376e6e606" />
    <img width="481" height="141" alt="image" src="https://github.com/user-attachments/assets/f0c693f1-daaf-4b35-8287-a9c1fdeef3d5" />

---

## Task-3: Backup Configuration for Web Servers

### Prerequisites:

This tasks requires two separate servers, Apache Server for Sarah and Niginx Server for Mike.

### Steps:

1. **Install Apache and Nginx on servers**

    Installing Apache2 on Mike's server

    ```sh
    sudo apt update
    sudo apt install -y apache2
    sudo systemctl enable apache2
    sudo systemctl status apache2
    ```

    <img width="743" height="192" alt="image" src="https://github.com/user-attachments/assets/6fd236f1-7df1-4b02-be1e-44fbe344cd3a" />
    <img width="972" height="203" alt="image" src="https://github.com/user-attachments/assets/bfe11481-cd1a-40f9-a4da-1b62a8016c49" />
    <img width="763" height="51" alt="image" src="https://github.com/user-attachments/assets/166ce5ad-c21e-4356-b5af-8292bc6296e3" />
    <img width="703" height="254" alt="image" src="https://github.com/user-attachments/assets/c5f1f03c-6009-49a0-be55-dc4339c668e0" />

    Installing Nginx on Sarah's server
   
    ```sh
    sudo apt update
    sudo apt install -y nginx
    sudo systemctl enable nginx
    sudo systemctl status nginx
    ```

    <img width="745" height="411" alt="image" src="https://github.com/user-attachments/assets/ef0458bd-b47e-4eab-b68a-66dccf2bd4d9" />
    <img width="1097" height="190" alt="image" src="https://github.com/user-attachments/assets/43e25754-7fdd-466c-95a7-510bc443c1ae" />
    <img width="760" height="85" alt="image" src="https://github.com/user-attachments/assets/ef5559d1-127e-4872-b64a-637f506d1732" />
    <img width="918" height="245" alt="image" src="https://github.com/user-attachments/assets/ac56f431-5263-47fe-9ee9-c61ec98abe4b" />
    
2. **Create automated backup scripts for Apache and Nginx**

    ```sh
    sudo nano /usr/local/bin/apache_backup.sh
    ```

    Add `apache_backup.sh` script from the repository.

    <img width="671" height="684" alt="image" src="https://github.com/user-attachments/assets/c9d487e2-0d41-48d7-b510-2edd9ce00f5f" />

    Save the file and Exit [`Ctrl+x` & `Enter` (or) `control+x` & `return`]
   
    <img width="497" height="38" alt="image" src="https://github.com/user-attachments/assets/d86cb27d-8265-40a4-8bf3-fdcce72a7ea3" />

    Execute the script and check if backup is successful

    ```sh
    sudo chmod +x /usr/local/bin/apache_backup.sh
    sudo /usr/local/bin/apache_backup.sh
    ls -lh /backups/apache_backup_*.tar.gz | tail -n 1
    sudo tail -n 60 /var/log/monitoring/apache_backup_$(date +%F).log
    ```
    
    <img width="671" height="1027" alt="image" src="https://github.com/user-attachments/assets/82a495f0-5e54-4103-9e29-a9e9954382f0" /> backup execute

    
    ```sh
    sudo nano /usr/local/bin/apache_backup.sh
    ```

    Add `nginx_backup.sh` script from the repository.
   
    <img width="656" height="790" alt="image" src="https://github.com/user-attachments/assets/8d8e682b-0024-4290-93f5-05d5b509979a" /> nginx bckp script

    
    Save the file and Exit [`Ctrl+x` & `Enter` (or) `control+x` & `return`]
      
    <img width="492" height="33" alt="image" src="https://github.com/user-attachments/assets/1a33873b-a142-4512-b873-72f043c795fd" /> nginx file create

    Execute the script and check if backup is successful

    ```sh
    sudo chmod +x /usr/local/bin/nginx_backup.sh
    sudo /usr/local/bin/nginx_backup.sh
    ls -lh /backups/nginx_backup_*.tar.gz | tail -n 1
    sudo tail -n 60 /var/log/monitoring/nginx_backup_$(date +%F).log
    ```
    
    <img width="646" height="560" alt="image" src="https://github.com/user-attachments/assets/b4fb7ab1-afab-4b57-9014-e3b8b818cd8f" /> backup execute



<img width="519" height="468" alt="image" src="https://github.com/user-attachments/assets/5e4d98e8-840d-4eea-b1ca-5a04f014cf87" /> nginx cronjob

<img width="504" height="420" alt="image" src="https://github.com/user-attachments/assets/bd4eb4af-b1a1-430c-833d-22aa6bc0d1f0" /> apache cronjob


<img width="601" height="986" alt="image" src="https://github.com/user-attachments/assets/94a5be37-76b5-4316-b86d-332269b33d4f" /> nginx cron cofirmation

<img width="601" height="986" alt="image" src="https://github.com/user-attachments/assets/c9e2d094-8d72-42bd-8492-76158c8da716" /> apache cron confirmation




3. **Configure Cron jobs to Automate Backup's**
5. sdjkvbjds
6. djkbvjks
