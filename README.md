# multiple_yi_dash_cam
I've been wondering how to deal with more than one Xiaomi Yi Dash Cam within single system. These are results.

## prerequisites

1. Raspberry Pi N with Raspbian Stretch (but should apply to any Linux)
2. Two WiFi NICs
3. At least two Xiaomi Yi Dash Cam

## how to

1. Setup your cameras to have separated SSIDs (and preferrable — passwords),
2. Make sure your Wifi cards are working under your OS,
3. Connect cards to the cameras,
4. Setup NICs to have static IPs (append to ``/etc/dhcpcd.conf``):
````
interface wlan0
static ip_address=192.168.1.11/24

interface wlan1
static ip_address=192.168.1.22/24
````
4. Use ``firewall.sh`` to setup connectivity within your system,
5. Access camera by requesting its network static IP address of your NIC.

## specifying SSID per NIC

1. Run ``wpa_cli``, then:
````
> add_network
> select_network 0
> set_network 0 ssid "NameOfNetwork"
> set_network 0 psk "Passw0rd"
> save
````
2. If you're using setup with dhcpcd, ``mv /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant-wlan0.conf``
3. Repeat above for the second (following) interfaces
4. Check if everything is ok using ``iwconfig``
