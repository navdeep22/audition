import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  // Singleton instance
  static final SocketManager _instance = SocketManager._internal();

  // Private constructor
  SocketManager._internal();

  // Factory constructor
  factory SocketManager() => _instance;

  // Socket instance
  IO.Socket? _socket; // Nullable to prevent errors

  // Initialize socket connection
  void initSocket({required String url, Map<String, dynamic>? queryParams}) {
    // Avoid reinitializing if already connected
    if (_socket != null && _socket!.connected) {
      debugPrint('Socket already initialized and connected');
      return;
    }

    // Configure socket connection
    _socket = IO.io(
      url,
      IO.OptionBuilder()
          .setTransports(['websocket']) // Specify transport
          .enableAutoConnect() // Auto connect when socket is created

          .build(),
    );

    // Listen for connection events
    _socket!.onConnect((_) => debugPrint('Socket connected'));
    _socket!.onDisconnect((_) => debugPrint('Socket disconnected'));
    _socket!.onError((data) => debugPrint('Socket error: $data'));
    _socket!
        .onReconnect((attempt) => debugPrint('Reconnected: Attempt $attempt'));
  }

  // Get the socket instance (null check added)
  IO.Socket? get socket {
    if (_socket == null) {
      debugPrint('Error: Socket is not initialized. Call initSocket() first.');
    }
    return _socket;
  }

  // Send an event (with null check)
  void emit(String event, dynamic data) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit(event, data);
    } else {
      debugPrint('Cannot emit: Socket is not connected');
    }
  }

  // Listen to an event (with null check)
  void on(String event, Function(dynamic) callback) {
    if (_socket != null) {
      _socket!.on(event, callback);
    } else {
      debugPrint('Error: Socket is not initialized. Call initSocket() first.');
    }
  }

  // Disconnect socket
  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
      debugPrint('Socket disconnected manually');
    } else {
      debugPrint('Error: Socket is not initialized. Call initSocket() first.');
    }
  }

  // Reconnect socket
  void reconnect() {
    if (_socket != null && !_socket!.connected) {
      _socket!.connect();
      debugPrint('Socket reconnected manually');
    } else if (_socket == null) {
      debugPrint('Error: Socket is not initialized. Call initSocket() first.');
    } else {
      debugPrint('Socket is already connected');
    }
  }
}
