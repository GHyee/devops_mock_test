# Log Analyzer

## Overview
The log analyzer is a bash tools is for reading log files within a specified directory.
The following attributes will be extracted from the log files:
  1. timestamps
  2. log levels

In addition, the tool can be configured to filter out logs based on certain rules such as
log level higher than or equal to a specified threshold. For e.g. "Warning".

## Usage
## Generating Logs
You can use a python tool to generate logs and store them in a specific directory.
```
python -m generate_logs -d logs/
```

## Extracting attributes and Filtering log entries
The script `log_processing.sh` will identify all log files within the specified directory, extract the timestamps and log levels from each log file, and filter out logs with a log level higher than or equal to the specified threshold. It will then print the filtered logs and perform any desired actions based on the filtered logs.
This solution assumes that the log files have a specific format where timestamps are in the format "YYYY-MM-DD HH:MM:SS" and log levels are either "INFO," "Warning," or "ERROR." You may need to modify the regular expressions used in the script to match the format of your log files.

To extract the attributes from the logs, 
1. Make `log_processing.sh` executable using the command `chmod +x log_processing.sh`. 
2. Run the script using `./log_processing.sh logs filtered_logs Warning`. 
Note:
- Make sure to replace `logs/` with the actual directory path where your log files are located.
- To filter logs, adjust the `filtered_logs/warning` and `Warning` value as per the filter requirements.
