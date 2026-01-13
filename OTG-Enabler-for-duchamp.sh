clear

if [ "$(id -u)" -ne 0 ]; then
    echo "run as root, dumb fuck." >&2
    exit 1
fi

OTG_PATH="/sys/devices/platform/charger/power_supply/usb/otg_enable"
ROLE_PATH="/sys/class/usb_role/11201000.usb0-role-switch/role"

echo "----------- ENABLE OTG IN AOSP (duchamp) -----------"
echo "Script made by @Papagaio_Verdadeiro"
echo "BIG CREDITS TO LUXURED FOR THE WORKAROUND, Without this guy, I wouldn't be coding this script."
sleep 2

# Enable OTG power
echo 1 > "$OTG_PATH"
sleep 1
echo "OTG_ENABLE = $(cat "$OTG_PATH")"

# First force to HOST
echo host > "$ROLE_PATH"
sleep 5

ROLE_1=$(cat "$ROLE_PATH")
echo "Check 1 → USB role = $ROLE_1"

if [ "$ROLE_1" != "host" ]; then
    echo "❌ Failed to enter HOST on first try. Kernel being a bitch."
    echo "Changing to HOST again."
    echo host > "$ROLE_PATH"
fi

# Second check after 5 seconds
sleep 5
ROLE_2=$(cat "$ROLE_PATH")
echo "Check 2 → USB role = $ROLE_2"

if [ "$ROLE_2" != "host" ]; then
    echo "⚠️ Role dropped after 5s, re-forcing HOST like a fuckin hammer"
    echo host > "$ROLE_PATH"
    sleep 1
    ROLE_FINAL=$(cat "$ROLE_PATH")
    echo "Final role after re-force = $ROLE_FINAL"
else
    echo "✅ HOST stayed stable after 5s. This shit is locked."
fi

echo "-----------------------"
echo "FINAL STATE:"
echo "OTG_ENABLE = $(cat "$OTG_PATH")"
echo "USB_ROLE   = $(cat "$ROLE_PATH")"
echo ""
echo "NOTE:"
echo "- Fake charging is normal as fuck"
echo "- If kernel freaks out again, rerun script"
