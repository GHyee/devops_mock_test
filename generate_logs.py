import os
import argparse
import random
import datetime

from typing import NoReturn


def generate_sample_logs(log_directory: str, num_log_files: int, lines_per_log_file: int) -> NoReturn:
    """
    Generate sample log files.

    Args:
        log_directory (str): Directory where log files will be generated.
        num_log_files (int): Number of log files to generate.
        lines_per_log_file (int): Number of lines per log file.

    Returns:
        NoReturn
    """
    os.makedirs(log_directory, exist_ok=True)  # Create directory if it does not exist

    for i in range(num_log_files):
        log_file_path = os.path.join(log_directory, f"sample_log_{i+1}.log")

        with open(log_file_path, "w") as log_file:
            for _ in range(lines_per_log_file):
                timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                log_level = random.choice(["INFO", "Warning", "ERROR"])
                message = f"This is a sample log message. Timestamp: {timestamp}, Log Level: {log_level}\n"
                log_file.write(message)

        print(f"Sample log file generated: {log_file_path}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate sample log files")
    parser.add_argument("log_directory", help="Directory where log files will be generated")
    parser.add_argument("-n", "--num-log-files", type=int, dest="num_log_files", default=1,
                        help="Number of log files to generate (default: 1)")
    parser.add_argument("-l", "--lines-per-log-file", type=int, dest="lines_per_log_file", default=10,
                        help="Number of lines per log file (default: 10)")

    args = parser.parse_args()

    log_directory: str = args.log_directory
    num_log_files: int = args.num_log_files
    lines_per_log_file: int = args.lines_per_log_file

    generate_sample_logs(log_directory, num_log_files, lines_per_log_file)
