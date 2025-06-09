# wg-easy Setup Script

A minimal guide to install and run the `wg-easy-setup.sh` script.

## Prerequisites

* Ensure you have `sudo` privileges on an Ubuntu/Debian system.
* Download or place `wg-easy-setup.sh` in your working directory.

## Steps

1. **Install Git**

   ```bash
   sudo apt install -y git
   ```
2. **Clobe Git**

   ```bash
   git clone https://github.com/srimankatipally/SetupWireGuard.git
   ```
3. **Going to folder**

   ```bash
    cd SetupWireGuard
   ```
4. **Make the setup script executable**

   ```bash
   chmod +x wg-easy-setup.sh
   ```

5. **Run the setup script**

   ```bash
   sudo ./wg-easy-setup.sh
   ```

After these steps, the `wg-easy` container will be up and running.
