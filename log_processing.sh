#!/bin/bash

# Log directory
log_directory="logs"

# Filtered log directory
filtered_log_directory="filtered_logs"

# Log level threshold (1: INFO, 2: Warning, 3: ERROR)
log_level_threshold=2

# Check if log directory is provided as an argument
if [ "$1" ]; then
    log_directory="$1"
fi

# Check if filtered log directory is provided as an argument
if [ "$2" ]; then
    filtered_log_directory="$2"
fi

# Check if log level threshold is provided as an argument
if [ "$3" ]; then
    case "$3" in
        "INFO")
            log_level_threshold=1
            ;;
        "Warning")
            log_level_threshold=2
            ;;
        "ERROR")
            log_level_threshold=3
            ;;
        *)
            echo "Invalid log level threshold. Using default threshold: Warning"
            ;;
    esac
fi

# Create the filtered log directory if it does not exist
mkdir -p "$filtered_log_directory"

# Define log level names and values using hashtable
# declare -A log_levels=(
#     ["INFO"]=1
#     ["Warning"]=2
#     ["ERROR"]=3
# )

# Identify all log files within the specified directory
log_files=$(find "$log_directory" -type f -name "*.log")

# Loop through each log file
log_file_counter=0
log_entry_counter=0
for log_file in $log_files; do
    log_file_counter=$((log_file_counter+1))
    # Extract the timestamps and log levels from the log file
    log_entries=$(grep -E '([0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}).*(INFO|Warning|ERROR)' "$log_file")

    # Loop through each log entry and filter based on the log level threshold
    while IFS= read -r log_entry; do
        log_entry_counter=$((log_entry_counter+1))
        timestamp=$(echo "$log_entry" | grep -Eo '[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}')
        log_level=$(echo "$log_entry" | grep -Eo 'INFO|Warning|ERROR')

        # Get the log level value based on the log level name from the hashtable
        case "$log_level" in
            "INFO")
                log_level_value=1
                ;;
            "Warning")
                log_level_value=2
                ;;
            "ERROR")
                log_level_value=3
                ;;
            *)
                echo "Invalid log level threshold. Using default threshold: Warning"
                ;;
        esac
        
        echo "File: $log_file, Timestamp: $timestamp, Log Level: $log_level" 

        # Filter out logs with a log level higher than or equal to the threshold
        if [[ $log_level_value -le $log_level_threshold ]]; then
            # Create the filtered log file based on the log level threshold
            filtered_log_file="$filtered_log_directory/filtered.log"

            # Append the filtered log entry to the filtered log file, including the log file name
            echo "File: $log_file, Timestamp: $timestamp, Log Level: $log_level" >> "$filtered_log_file"
        fi
    done <<< "$log_entries"
done
echo "Finished processing $log_file_counter log files and $log_entry_counter log entries."
echo