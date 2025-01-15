# aocli.py

import argparse
import json
import os
import subprocess

# Configuration for the tools
TOOLS = {
    "nuclei": {
        "command": "nuclei",
        "args": "-u {domain} -json -o {output_file}"
    },
    "subfinder": {
        "command": "subfinder",
        "args": "-d {domain} -o {output_file}"
    },
    "amass": {
        "command": "amass",
        "args": "enum -passive -d {domain} -json {output_file}"
    },
    "assetfinder": {
        "command": "assetfinder",
        "args": "--subs-only {domain} > {output_file}"
    },
    "cdncheck": {
        "command": "cdncheck",
        "args": "-i {domain} -j -o {output_file}"
    },
    "trivy": {
        "command": "trivy",
        "args": "fs {domain} -o {output_file}"
    }
}

# Function to run a single tool
def run_tool(tool_name, domain, output_dir):
    if tool_name not in TOOLS:
        print(f"[!] Tool {tool_name} is not configured.")
        return None

    tool = TOOLS[tool_name]
    output_file = os.path.join(output_dir, f"{tool_name}_output.json")
    args = tool["args"].format(domain=domain, output_file=output_file)

    try:
        command = f"{tool['command']} {args}"
        print(f"[+] Running: {command}")
        subprocess.run(command, shell=True, check=True)
        return output_file
    except subprocess.CalledProcessError as e:
        print(f"[!] Error running {tool_name}: {e}")
        return None

# Function to aggregate tool outputs
def aggregate_outputs(output_files, aggregated_file):
    aggregated_data = {}

    for file in output_files:
        if os.path.exists(file):
            with open(file, "r") as f:
                try:
                    data = json.load(f)
                    aggregated_data[file] = data
                except json.JSONDecodeError:
                    print(f"[!] Failed to parse JSON from {file}")

    with open(aggregated_file, "w") as f:
        json.dump(aggregated_data, f, indent=4)

    print(f"[+] Aggregated output saved to {aggregated_file}")

# Main function
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="AO Security Posture CLI")
    parser.add_argument("-d", "--domain", required=True, help="Target domain to scan")
    parser.add_argument("-o", "--output", default="/home/reports/aggregated_output.json", help="Output file for aggregated results")
    parser.add_argument("--exclude", nargs="*", default=[], help="Tools to exclude from the scan")
    args = parser.parse_args()

    domain = args.domain
    output_file = args.output
    excluded_tools = set(args.exclude)

    # Ensure output directory exists
    output_dir = os.path.dirname(output_file)
    os.makedirs(output_dir, exist_ok=True)

    # Run tools and collect outputs
    output_files = []
    for tool_name in TOOLS:
        if tool_name not in excluded_tools:
            result = run_tool(tool_name, domain, output_dir)
            if result:
                output_files.append(result)

    # Aggregate outputs
    aggregate_outputs(output_files, output_file)
