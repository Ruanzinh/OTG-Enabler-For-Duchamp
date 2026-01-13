# OTG Enabler Script for POCO X6 Pro (duchamp)

This script is a workaround to enable USB OTG on **AOSP-based ROMs** when your USB OTG is **generic** and the **ROM doesn't recognize it.**

It manually enables OTG power and forces the USB controller into **HOST** mode using sysfs.

## Requirements

* Root access
* AOSP-based ROM
* POCO X6 Pro

## How It Works

The script does the following:

1. Enables OTG power by writing to:

```bash
/sys/devices/platform/charger/power_supply/usb/otg_enable
```

2. Forces USB role to **HOST** via:

```bash
/sys/class/usb_role/*/role
```

3. Verifies if the role remains **HOST** after a delay

4. Re-applies **HOST** if the kernel drops the role

This helps stabilize OTG devices like mouse and keyboard that otherwise stop working after a few seconds.

## Usage

Run the script as root:

### Termux

```bash
su -c sh OTG-Enabler-for-duchamp.sh
```

### MT Manager

Just execute the script as root.

## Notes

* If your OTG device works but stops after a few seconds (for example, you are moving the mouse while the script is running and the cursor freezes), re-run the script.

* Fake charging while OTG is active is expected behavior.

* Reboot your phone if you want to charge its battery, as fake charging prevents this from happening.

## Special Thanks

**Luxured**

Huge thanks to Luxured for giving me the first crucial command that made this entire workaround possible — the OTG enable sysfs write. That single command was the turning point that allowed this script to exist and function.

Without that initial hint, this project would not have gone anywhere.
