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
The below code will generate 10 logfiles of 10 entries and store them in the directory `logs/`.
```
python -m generate_logs logs/ -n 10 -l 10
```
Sample output:
```bash
❯ python -m generate_logs logs/ -n 10 -l 10
Sample log file generated: logs/sample_log_1.log
Sample log file generated: logs/sample_log_2.log
Sample log file generated: logs/sample_log_3.log
...
Sample log file generated: logs/sample_log_8.log
Sample log file generated: logs/sample_log_9.log
Sample log file generated: logs/sample_log_10.log

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
- To filter logs, adjust the `filtered_logs/warning` and `Warning` value as per the filter requirements.

Sample output:
```bash
❯ ./log_processing.sh logs filtered_logs Warning
File: logs/sample_log_1.log, Timestamp: 2023-07-07 15:23:00, Log Level: INFO
File: logs/sample_log_1.log, Timestamp: 2023-07-07 15:23:00, Log Level: INFO
File: logs/sample_log_1.log, Timestamp: 2023-07-07 15:23:00, Log Level: ERROR
...
File: logs/sample_log_8.log, Timestamp: 2023-07-07 15:23:00, Log Level: INFO
File: logs/sample_log_8.log, Timestamp: 2023-07-07 15:23:00, Log Level: INFO
File: logs/sample_log_8.log, Timestamp: 2023-07-07 15:23:00, Log Level: Warning
Finished processing 10 log files and 100 log entries.
```


# Ideas for Improvement
1. Configurability: Introduce a configuration file or additional command-line arguments to allow users to customize various aspects of the log processing script, such as log format, log level mappings, log file extensions, or output file naming conventions.

2. Performance Optimization: If dealing with large log files or a significant number of log entries, consider optimizing the processing logic for better performance. Techniques like parallel processing, optimized file I/O operations, or using more efficient tools like `awk` or `sed` can significantly improve performance.

3. Enhanced Filtering: Provide additional filtering options, such as filtering based on log message content, specific time periods, or combining multiple filter conditions using logical operators (AND, OR).

4. Unit Testing: Develop comprehensive unit tests to verify the correctness and reliability of the script. Automated testing ensures that the script behaves as expected in different scenarios and helps catch potential bugs or issues.

5. Performance Monitoring: Implement performance monitoring capabilities to track the script's execution time, resource utilization, and log processing throughput. This helps identify bottlenecks, optimize resource allocation, and fine-tune the script for better performance.
