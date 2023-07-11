import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:tech_seeker_2023/bluetooth_constants.dart';
import 'package:tech_seeker_2023/main.dart';
import 'package:tech_seeker_2023/room.dart';
//ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';


class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key,this.device,this.ledColor});
  final String? ledColor;
  final BluetoothDevice? device;

  @override
  State<StatefulWidget> createState() {
    return DeviceScreenState();
  }
}


class DeviceScreenState extends State<DeviceScreen> {
  DeviceScreenState();

  //final _inputSsidController = TextEditingController();
  //final _inputPasswordController = TextEditingController();
  String? ledColor;

  Future<void> writeToCharacteristic(
      BluetoothCharacteristic characteristic, String value) async {
    List<int> codeUnits = [];
    for (int i = 0; i < value.length; i++) {
      codeUnits.add(value.codeUnitAt(i));
    }
    await characteristic.write(codeUnits);
  }

  Future<BluetoothService?> findService() async {
    // 現在のBluetoothの接続状態を取得する
    final state = await widget.device?.state.first;

    // 接続状態が切断状態の場合は、接続処理を行う
    if (state == BluetoothDeviceState.disconnected) {
      await widget.device?.connect();
    }

    // Bluetoothのサービスを取得する
    final targetServices = await widget.device?.discoverServices();

    // 対応しているサービスを探す
    return targetServices?.firstWhereOrNull((element) {
      return element.uuid.toString() == BluetoothConstants.serviceUuid;
    });
  }
  
  /// 選択した色をESP32に送信する
  void sendSelectedColor() async {
    final service = await findService();
    final color = ledColor;
    final colorCharacteristic =
    service?.characteristics.firstWhereOrNull((element) {
      return element.uuid.toString() ==
          BluetoothConstants.roomColorCharacteristicUuid;
    });
    if (colorCharacteristic == null || color == null) {
      return;
    }
    await writeToCharacteristic(colorCharacteristic, color);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('device'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //ConnectionStatus(device: widget.device),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "色設定",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<String>(
                      value: ledColor,
                      items: const [
                        DropdownMenuItem(
                          value: "red",
                          child: Text("赤"),
                        ),
                        DropdownMenuItem(
                          value: "green",
                          child: Text("緑"),
                        ),
                        DropdownMenuItem(
                          value: "blue",
                          child: Text("青"),
                        )
                      ],
                      onChanged: (String? color) {
                        setState(() {
                          ledColor = color;
                        });

                        // 選択した色をESP32に送信する
                        sendSelectedColor();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ]
      ),
    )
      )
    );
  }
}

class ConnectionStatus extends StatelessWidget {
  final BluetoothDevice device;

  const ConnectionStatus({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("接続状態"),
      subtitle: StreamBuilder(
        stream: device.state,
        initialData: BluetoothDeviceState.disconnected,
        builder: (c, snapshot) {
          switch (snapshot.data) {
            case BluetoothDeviceState.connected:
              return const Text('Connected');
            case BluetoothDeviceState.connecting:
              return const Text('Connecting');
            case BluetoothDeviceState.disconnected:
              return const Text('Disconnected');
            default:
              return const Text('Unknown');
          }
        },
      ),
    );
  }
}