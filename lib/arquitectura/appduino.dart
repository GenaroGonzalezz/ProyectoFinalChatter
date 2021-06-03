// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
//
// class Appduino extends StatefulWidget {
//
//   @override
//   _AppduinoState createState() => _AppduinoState();
//
//
// }
//
//
// class _AppduinoState extends State<Appduino> {
//   BluetoothDevice _device;
//
//   // Initializing the Bluetooth connection state to be unknown
//   BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
//
//   // Get the instance of the Bluetooth
//   FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
//
//
//   // Track the Bluetooth connection with the remote device
//   late BluetoothConnection connection;
//
//   // To track whether the device is still connected to Bluetooth
//   bool get isConnected => connection != null && connection.isConnected;
//
//   late int _deviceState;
//   @override
//   void initState() {
//     super.initState();
//
//     // Get current state
//     FlutterBluetoothSerial.instance.state.then((state) {
//       setState(() {
//         _bluetoothState = state;
//       });
//     });
//
//     _deviceState = 0; // neutral
//
//     // If the Bluetooth of the device is not enabled,
//     // then request permission to turn on Bluetooth
//     // as the app starts up
//     enableBluetooth();
//
//
//
//     // Listen for further state changes
//     FlutterBluetoothSerial.instance
//         .onStateChanged()
//         .listen((BluetoothState state) {
//       setState(() {
//         _bluetoothState = state;
//
//         // For retrieving the paired devices list
//         getPairedDevices();
//       });
//     });
//   }
//   Future<void> enableBluetooth() async {
//     // Retrieving the current Bluetooth state
//     _bluetoothState = await FlutterBluetoothSerial.instance.state;
//
//     // If the Bluetooth is off, then turn it on first
//     // and then retrieve the devices that are paired.
//     if (_bluetoothState == BluetoothState.STATE_OFF) {
//       await FlutterBluetoothSerial.instance.requestEnable();
//       await getPairedDevices();
//       return true;
//     } else {
//       await getPairedDevices();
//     }
//     return false;
//   }
//
//   // Define a new class member variable
// // for storing the devices list
//   List<BluetoothDevice> _devicesList = [];
//
//   Future<void> getPairedDevices() async {
//     List<BluetoothDevice> devices = [];
//
//     // To get the list of paired devices
//     try {
//       devices = await _bluetooth.getBondedDevices();
//     } on PlatformException {
//       print("Error");
//     }
//
//     // It is an error to call [setState] unless [mounted] is true.
//     if (!mounted) {
//       return;
//     }
//
//     // Store the [devices] list in the [_devicesList] for accessing
//     // the list outside this class
//     setState(() {
//       _devicesList = devices;
//     });
//   }
//
//   // Define a member variable to track
// // when the disconnection is in progress
//   bool isDisconnecting = false;
//
//   @override
//   void dispose() {
//     if (isConnected) {
//       isDisconnecting = true;
//       connection.dispose();
//       connection = null;
//     }
//
//     super.dispose();
//   }
//     @override
//   Widget build(BuildContext context) {
//       bool _connected = false;
//
//       return Center(
//         child: Column(
//           children: [
//             Switch(
//               value: _bluetoothState.isEnabled,
//               onChanged: (bool value) {
//                 future() async {
//                   if (value) {
//                     // Enable Bluetooth
//                     await FlutterBluetoothSerial.instance
//                         .requestEnable();
//                   } else {
//                     // Disable Bluetooth
//                     await FlutterBluetoothSerial.instance
//                         .requestDisable();
//                   }
//
//                   // In order to update the devices list
//                   await getPairedDevices();
//                   _isButtonUnavailable = false;
//
//                   // Disconnect from any device before
//                   // turning off Bluetooth
//                   if (_connected) {
//                     _disconnect();
//                   }
//                 }
//
//                 future().then((_) {
//                   setState(() {});
//                 });
//               },
//             ),
//
//             DropdownButton(
//               items: _getDeviceItems(),
//               onChanged: (value) =>
//                   setState(() => _device = value),
//               value: _devicesList.isNotEmpty ? _device : null,
//             ),
//
//           ],
//         ),
//       );
//
//
//   }
//   List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
//     List<DropdownMenuItem<BluetoothDevice>> items = [];
//     if (_devicesList.isEmpty) {
//       items.add(DropdownMenuItem(
//         child: Text('NONE'),
//       ));
//     } else {
//       _devicesList.forEach((device) {
//         items.add(DropdownMenuItem(
//           child: Text(device.name),
//           value: device,
//         ));
//       });
//     }
//     return items;
//   }
//
//   void _connect() async {
//     if (_device == null) {
//       show('No device selected');
//     } else {
//       // If a device is selected from the
//       // dropdown, then use it here
//     }
//   }
// }
