import 'package:flutter/material.dart';
import 'package:tech_seeker_2023/go.dart';


class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return RoomPageState();
  }
}


class RoomPageState extends State {
  final TextEditingController controller = TextEditingController();
  String? ledColor = '赤色';
  String?  buzzerVolume = '25';

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

            Padding(padding: const EdgeInsets.only(top: 30 ),child:Image.asset('images/家.png',width:260,height: 260,),),

            //Container(
            //alignment: Alignment.topCenter,

            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              const Text('必要',
                  style: TextStyle(
                    fontSize: 36,
                  )),
              ElevatedButton(onPressed: () {}, child: const Text('OFF')),
            ]),
            const Text('使うタイミング',
                style: TextStyle(
                  fontSize: 36,
                )),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(onPressed: () {}, child: const Text('事前')),
              ElevatedButton(onPressed: () {}, child: const Text('開けた時')),
            ]),
            const Text('ブザー',
                style: TextStyle(
                  fontSize: 36,
                )),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(onPressed: () {}, child: const Text('ON')),
              ElevatedButton(onPressed: () {}, child: const Text('OFF')),
              DropdownButton(items: const[
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
                onChanged: (String? value){
                setState(() {
                  buzzerVolume = value;
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
                ElevatedButton(onPressed: () {}, child: const Text('ON')),
                ElevatedButton(onPressed: () {}, child: const Text('OFF')),
                DropdownButton(
                    items: const[
                      DropdownMenuItem(
                        value: '赤色',
                        child:  Text('赤色'),
                      ),
                      DropdownMenuItem(
                        value: '青色',
                        child:  Text('青色'),
                      ),
                      DropdownMenuItem(
                        value: '黄色',
                        child:  Text('黄色'),
                      ),
                    ],
                   onChanged: (String? value){
                      setState(() {
                        ledColor = value;
                      });
                   },
                    value: ledColor,
                )
              ]),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // ボタンの位置をセンターに
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          //backgroundColor: Theme.of(context).accentColor,
          onPressed: () {},
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
