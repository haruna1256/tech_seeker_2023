import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tech_seeker_2023/go.dart';
import 'package:tech_seeker_2023/room.dart';
import 'package:tech_seeker_2023/bluetooth_device_list.dart';
import 'package:permission_handler/permission_handler.dart';


void main() {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    [
      Permission.location,
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan
    ].request().then((status) {
      runApp(const MyApp());
    });
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // debug ラベル削除
      title: '親フラ感知',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FindDevicesScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
// Paintオブジェクトを作成します。これは描画操作で使用されるスタイルと色情報を保持します。
    final paint = Paint();

    // 描画する色を青に設定します。これは上側の領域の色になります。
    paint.color = const Color(0xFF53DAD2);

    // Pathオブジェクトを作成します。これは描画する形状の輪郭を定義します。
    var path = Path();

    // 頂点を(0, 0)に移動します。これは左上隅の点です。
    path.moveTo(0, 0);

    // 次に、頂点を右上の点に移動しますが、実際の右上隅よりも100ピクセル右に配置します。
    path.lineTo(size.width + 100, 0);

    // 最後に、頂点を下部に移動しますが、実際の左下隅よりも100ピクセル上に配置します。
    path.lineTo(0, size.height - 100);

    // Pathを閉じることで最初の点（左上隅）と最後の点を結び、形状を完成させます。
    path.close();

    // canvas.drawPathを使用してpathで定義された形状を描き、paintで定義された色を使用します。
    canvas.drawPath(path, paint);

    // 次に、描画する色を赤に設定します。これは下側の領域の色になります。
    paint.color = const Color(0xFFC3E4EB);

    // 新しいPathオブジェクトを作成します。
    path = Path();

    // 頂点を左下隅に移動しますが、実際の左下隅よりも100ピクセル左に配置します。
    path.moveTo(-100, size.height);

    // 次に、頂点を右上の点に移動しますが、実際の右上隅よりも100ピクセル下に配置します。
    path.lineTo(size.width, 100);

    // 最後に、頂点を右下隅に移動します。
    path.lineTo(size.width, size.height);

    // Pathを閉じることで最初の点（左下隅）と最後の点を結び、形状を完成させます。
    path.close();

    // canvas.drawPathを使用してpathで定義された
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomPaint(
        painter: BackgroundPainter(),
        child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          //　均等に分ける　＝ spaceBetween
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisAlignment: MainAxisAlignment.center,

          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // メソッドみたいなもの
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 150),
                child: Image.asset('images/ロゴ.png',),),
              /*Padding(padding: const EdgeInsets.only()
                , child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(200, 80)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => BluetoothPage()));
                    },
                    child: const Text("bluetooth",
                      style: TextStyle(
                          fontSize: 20
                      ),)),),*/

              Padding(padding: const EdgeInsets.only(top: 160, bottom: 100)
                , child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(160, 60),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      padding: EdgeInsets.zero,
                      elevation: 0, // ボタンの影を無効化
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const GotoPage()));
                    },
                    child: const Text("自分が外に居る時",
                      style: TextStyle(
                          fontSize: 18
                      ),)),),

              Padding(padding: const EdgeInsets.only(bottom: 10)
                , child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(160, 60),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                      padding: EdgeInsets.zero,
                      elevation: 0, // ボタンの影を無効化
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => const RoomPage()));
                    },
                    child: const Text(" 自分が部屋に居る時 ",
                      style: TextStyle(
                          fontSize: 18
                      ),)),),
              Padding(padding: const EdgeInsets.only(top: 190,right:30,left:30)
                ,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, children:[
                  Expanded(
                    child: TextButton(onPressed: () {}, child: const Text("LINE Notify 入れた？")),),
                  Expanded(
                    child: TextButton(onPressed: () {}, child: const Text("操作が分からない")),),

                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
