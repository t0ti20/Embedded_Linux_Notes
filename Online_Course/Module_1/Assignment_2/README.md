# Networking Assignment

## Setup

![Setup](https://github.com/t0ti20/Embedded_Linux/assets/61616031/05273faf-d4f3-4707-a9e0-a349aa338631)

## Requirements

### 1. Get IP for Each Board

![IPs](https://github.com/t0ti20/Embedded_Linux/assets/61616031/19b49294-7d9a-4095-98e2-19442153543a)

### 2. Test Connectivity

Check the connectivity between the boards by sending ICMP packets using the `ping` command.

![Ping Test](https://github.com/t0ti20/Embedded_Linux/assets/61616031/477dbaa7-87ae-47d8-8b15-42869cae77dc)

### 3. Monitor ICMP Packets

Use Wireshark to monitor the ICMP packets.

![Wireshark](https://github.com/t0ti20/Embedded_Linux/assets/61616031/3561a60a-9ef1-4167-959e-b3e1fe9a7d66)

### 4. Ethernet Card Status

Change the status of the Ethernet card on PC2 to down using the `ifconfig` command.

![Ethernet Down](https://github.com/t0ti20/Embedded_Linux/assets/61616031/0332bc6c-cc95-4710-ab9b-fd97d1f18f7f)

### 5. Monitor Packets Again

Use Wireshark to monitor the packets after changing the Ethernet status.

![Wireshark 2](https://github.com/t0ti20/Embedded_Linux/assets/61616031/33dda39e-acd3-48f9-845c-76a5b83208ee)

---

## Extra

### 1. Sockets Listened to by the `ping` Command

Check if the `ping` command listens to any sockets using the `ss` command. Note: The `ping` command does not keep or listen to open sockets.

![ss Command](https://github.com/t0ti20/Embedded_Linux/assets/61616031/77bff635-7cef-4c1f-ad15-05c67f95b1f7)

### 2. `strace` the `ping` Command

Use `strace` to observe the main system calls sent to the network stack by the `ping` command.

![strace](https://github.com/t0ti20/Embedded_Linux/assets/61616031/9cf671d0-1a46-44f5-8ce6-d6c45b5c12b0)

- **socket()**: Creates sockets required for ICMP packet transmission and receiving replies.
  
- **setsockopt()**: Configures the socket behavior.
  
- **sendto()**: Sends the ICMP echo request.
  
- **getsockopt()**: Retrieves socket options, in this case, checking the receive buffer size.

Note: ICMP is connectionless and doesn't establish connections like TCP.

