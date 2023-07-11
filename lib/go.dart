import 'package:flutter/material.dart';
import 'package:tech_seeker_2023/room.dart';
import 'package:tech_seeker_2023/bluetooth_device.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:tech_seeker_2023/bluetooth_constants.dart';
//import 'package:tech_seeker_2023/bluetooth_device_list.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';


class GotoPage extends StatefulWidget {
  const GotoPage({super.key,this.device});
  final BluetoothDevice? device;
  @override
  State<StatefulWidget> createState() {
    return GoPageState();
  }
}

class GoPageState extends State<GotoPage> {
  final TextEditingController controller = TextEditingController();
  BluetoothDevice? device;
  String? ledColor = 'none';
  String?  buzzerVolume = '0';
  String? needing = '1';
  String? timing = 'before';
  // 選択中フッターメニューのインデックスを一時保存する用変数
  int selectedIndex = 0;

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

  Future<BluetoothCharacteristic?> getCharByUuid(String uuid) async {
    final service = await findService();
    return service?.characteristics.firstWhereOrNull((element) {
      return element.uuid.toString() == uuid;
    });
  }

  /// 必要なのかESP32に送信する
  Future<void> sendSelectedNeed() async {
    final need = needing;
    final goNeedCharacteristic = await getCharByUuid(BluetoothConstants.goNeedCharacteristicUuid);
    if (goNeedCharacteristic == null || need == null) {
      return;
    }
    await writeToCharacteristic(goNeedCharacteristic, need);
  }

  /// 通知タイミングをESP32に送信する
  Future<void> sendSelectedTime() async {
    final time = timing;
    final goTimeCharacteristic = await getCharByUuid(BluetoothConstants.goTimeCharacteristicUuid);
    if (goTimeCharacteristic == null || time == null) {
      return;
    }
    await writeToCharacteristic(goTimeCharacteristic, time);
  }

  /// 選択した色をESP32に送信する
  Future<void> sendSelectedColor() async {
    final color = ledColor;
    final goColorCharacteristic = await getCharByUuid(BluetoothConstants.goColorCharacteristicUuid);
    if (goColorCharacteristic == null || color == null) {
      return;
    }
    await writeToCharacteristic(goColorCharacteristic, color);
  }

  /// 選択した音量をESP32に送信する
  Future<void> sendSelectedBuzzer() async {
    final buzzer = buzzerVolume;
    final goBuzzerCharacteristic = await getCharByUuid(BluetoothConstants.goBuzzerCharacteristicUuid);
    if (goBuzzerCharacteristic == null || buzzer == null) {
      return;
    }
    await writeToCharacteristic(goBuzzerCharacteristic, buzzer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF1),

      body: Center(
        child: Column(
          //　均等に分ける　＝ spaceBetween
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset(
                'images/太陽.png',
                width: 260,
                height: 260,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              const Text('使用する？',
                  style: TextStyle(
                    fontSize: 36,
                  )),
              DropdownButton(items: const[
                DropdownMenuItem(
                  value: '1',
                  child:  Text('ON'),
                ),
                DropdownMenuItem(
                  value: '0',
                  child:  Text('OFF'),
                ),
              ],
                onChanged: (String? need){
                  setState(() {
                    needing = need;
                  });
                },
                value: needing,
              )
            ]),
            const Text('使うタイミング',
                style: TextStyle(
                  fontSize: 36,
                )),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              DropdownButton(items: const[
                DropdownMenuItem(
                  value: 'before',
                  child:  Text('事前'),
                ),
                DropdownMenuItem(
                  value: 'after',
                  child:  Text('開閉直後'),
                ),
                DropdownMenuItem(
                  value: 'mix',
                  child:  Text('両方'),
                ),
              ],
                onChanged: (String? time){
                  setState(() {
                    timing = time;
                  });
                },
                value: timing,
              )
            ]),
            const Text('ブザー',
                style: TextStyle(
                  fontSize: 36,
                )),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              DropdownButton(items: const[
                DropdownMenuItem(
                  value: '0',
                  child:  Text('0%'),
                ),
                DropdownMenuItem(
                  value: '25',
                  child:  Text('25%'),
                ),
                DropdownMenuItem(
                  value: '50',
                  child:  Text('50%'),
                ),
                DropdownMenuItem(
                  value: '75',
                  child:  Text('75%'),
                ),
                DropdownMenuItem(
                  value: '100',
                  child:  Text('100%'),
                ),
              ],
                onChanged: (String? buzzer){
                  setState(() {
                    buzzerVolume = buzzer;
                  });
                },
                value: buzzerVolume,
              )
            ]),
      const Text('LED',
          style: TextStyle(
            fontSize: 36,
          )),
      Padding(padding: const EdgeInsets.only(bottom: 80)
        ,child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          DropdownButton(
            items: const[
              DropdownMenuItem(
                value: 'none',
                child:  Text('なし'),
              ),
              DropdownMenuItem(
                value: 'red',
                child:  Text('赤色'),
              ),
              DropdownMenuItem(
                value: 'blue',
                child:  Text('青色'),
              ),
              DropdownMenuItem(
                value: 'yellow',
                child:  Text('黄色'),
              ),
            ],
            onChanged: (String? color){
              setState(() {
                ledColor = color;
              });

            },
            value: ledColor,
          )
        ]),
      )],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // ボタンの位置をセンターに
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          //backgroundColor: Theme.of(context).accentColor,
          onPressed: () async{
            // 必要かどうか
            await sendSelectedNeed();
            // 選択した音量をESP32に送信する
            await sendSelectedBuzzer();
            // 選択した色をESP32に送信する
            await sendSelectedColor();
            // 選択して通知タイミングをESP32に送信する
            await sendSelectedTime();
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.done),

        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF7DE2DB),
          // フッターメニューのアイテム一覧
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('images/家.png'),
                color: Color(0xFFE8F4F7),
                size: 40,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('images/太陽.png'),
                color: Color(0xFFE8F4F7),
                size: 40,
              ),
              label: 'go',
            ),
          ],

          currentIndex: 0,
          onTap: (int index) {
            if (index == 0) {
              // Home アイコンが押されたときの処理
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RoomPage()));
              // 他の処理を追加
            } else if (index == 1) {
              // go アイコンが押されたときの処理
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const GotoPage()));
              // 他の処理を追加
            }
          },
        ),
      ),
    );
  }
}
