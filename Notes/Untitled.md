# TCP Client-Server Project

This project implements a TCP client-server application using C++ and Boost.Asio library.

## TCP Client

The TCP client (`TCP_Client`) is responsible for connecting to the server, sending messages, and handling received messages asynchronously.

### Class Structure

- **TCP_Client**
  - `Message_Received`: Callback function for handling received messages from the server.
  - `_IO_Context`: Boost.Asio IO context for managing asynchronous operations.
  - `_Socket`: Boost.Asio TCP socket for communication with the server.
  - `_Endpoints`: Resolved endpoints of the server to establish a connection.
  - `_Buffer`: Boost.Asio stream buffer for storing received data.
  - `_Messages`: Queue of messages to be sent to the server.

### Functions

- `Run()`: Initiates asynchronous connection to the server and starts the IO context.
- `Stop()`: Stops the client by closing the socket.
- `Send_Message(const std::string &Message)`: Queues a message for sending to the server.
- `Async_Reading()`: Initiates asynchronous reading from the server.
- `Done_Reading(boost::system::error_code &Error, size_t Bytes_Transferred)`: Handles completion of asynchronous reading.
- `Async_Writing()`: Initiates asynchronous writing to the server.
- `Done_Writing(boost::system::error_code &Error, size_t Bytes_Transferred)`: Handles completion of asynchronous writing.

## TCP Server

The TCP server (`TCP_Server`) is responsible for accepting client connections, handling client events, and broadcasting messages to connected clients.

### Class Structure

- **TCP_Server**
  - `Client_Connected`: Callback function for handling client connection events.
  - `Client_Disconnected`: Callback function for handling client disconnection events.
  - `Message_Received`: Callback function for handling received messages from clients.
  - `_Port_Number`: Port number on which the server listens for connections.
  - `_IO_Context`: Boost.Asio IO context for managing asynchronous operations.
  - `_Acceptor`: Boost.Asio acceptor for accepting incoming connections.
  - `_Socket`: Optional TCP socket for accepting connections.
  - `_Connections`: Set of connected clients.

### Functions

- `Run()`: Starts the server and listens for incoming connections.
- `_Start_Accept()`: Initiates asynchronous connection acceptance.
- `Broadcast(const std::string &Message)`: Broadcasts a message to all connected clients.

## Main Functions

### Client Function

The `Client()` function represents a TCP client instance. It creates a client, connects to the server, sends and receives messages.

### Server Function

The `Server()` function represents a TCP server instance. It creates a server, listens for incoming connections, and handles client events.

## Usage

- Compile and run the client and server functions to establish communication.
- Input messages in the client console to send to the server.
- Received messages from the server are displayed in the client console.
## Dependencies

- C++ compiler (supporting C++11 or later)
- Boost C++ Libraries (Boost.Asio)

## Author

- [Khaled El-Sayed] (@t0ti20)