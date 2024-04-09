# WORKING


# Run this script to take the cloud init yaml file and turn it into numbers.

# You have to do this with `grafana-prom-w-gw.yml` as it is too long to be in-line command for ARM templates

# You need Python installed before running this with
# `sudo python3 cloud-init-to-base64.py`

import base64

def main():
    print("Only run if cloud-init is changed, if not Ctl+C to exit. ")
    print("Paste your cloud-init custom data below: ")
    custom_data = input().strip()

    encoded_data = base64.b64encode(custom_data.encode()).decode()

    print("Replace this line for the customData in the associated VM")
    print('"customData": "{}"'.format(encoded_data))

if __name__ == "__main__":
    main()
