# Linux_Assignment
## Practice Assignment on Testing, Linux and Servers
This repository consists of Assignments performed as part of HeroVired Program.

---

## Environment
**OS:** Ubuntu
**Cloud:** AWS

---

## Task-1: System Monitoring Setup

### Steps
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

## Task-2: 
