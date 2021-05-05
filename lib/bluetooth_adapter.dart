import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class BluetoothAdapter {
  static const int STATE_OFF = 10;
  static const int STATE_TURNING_ON = 11;
  static const int STATE_ON = 12;
  static const int STATE_TURNING_OFF = 13;
  static const int STATE_BLE_TURNING_ON = 14;
  static const int STATE_BLE_ON = 15;
  static const int STATE_BLE_TURNING_OFF = 16;
  static const int ERROR = -1;
  static const int CONNECTED = 1;
  static const int DISCONNECTED = 0;

  static const NAMESPACE = 'bluetooth_adapter';

  static const MethodChannel _channel =
      const MethodChannel("$NAMESPACE/methods");

  static const EventChannel _readChannel =
      const EventChannel("$NAMESPACE/read");

  static const EventChannel _stateChannel =
      const EventChannel("$NAMESPACE/state");

  final StreamController<MethodCall> _methodStreamController =
      new StreamController.broadcast();

  BluetoothAdapter._() {
    _channel.setMethodCallHandler((MethodCall call) async {
      _methodStreamController.add(call);
    });
  }

  static BluetoothAdapter _instance = BluetoothAdapter._();

  static BluetoothAdapter get instance => _instance;

  Stream<int> onStateChanged() {
    return _stateChannel.receiveBroadcastStream().map((buffer) => buffer);
  }

  Stream<String> onRead() {
    return _readChannel
        .receiveBroadcastStream()
        .map((buffer) => buffer.toString());
  }

  Future<bool> get isAvailable async {
    final data = await _channel.invokeMethod('isAvailable');
    return data;
  }

  Future<bool> get isOn async {
    final data = await _channel.invokeMethod('isOn');
    return data;
  }

  Future<bool> get isConnected async {
    final data = await _channel.invokeMethod('isConnected');
    return data;
  }

  Future<bool> get openSettings async {
    final data = await _channel.invokeMethod('openSettings');
    return data;
  }

  Future<List<BluetoothDevice>> getBondedDevices() async {
    final List list = await _channel.invokeMethod('getBondedDevices');
    return list.map((map) => BluetoothDevice.fromMap(map)).toList();
  }

  Future<dynamic> connect(BluetoothDevice device) {
    return _channel.invokeMethod('connect', device.toMap());
  }

  Future<dynamic> disconnect() {
    return _channel.invokeMethod('disconnect');
  }

  Future<dynamic> write(Uint8List message) {
    return _channel.invokeMethod('write', {'message': message});
  }
}

class BluetoothDevice {
  final String name;
  final String address;
  final int type = 0;
  bool connected = false;

  BluetoothDevice(this.name, this.address);

  BluetoothDevice.fromMap(Map map)
      : name = map['name'],
        address = map['address'];

  Map<String, dynamic> toMap() => {
        'name': this.name,
        'address': this.address,
        'type': this.type,
        'connected': this.connected,
      };

  operator ==(Object other) {
    return other is BluetoothDevice && other.address == this.address;
  }

  @override
  int get hashCode => address.hashCode;
}
