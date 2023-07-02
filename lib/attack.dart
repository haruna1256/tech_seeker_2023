import 'package:flutter/material.dart';
import 'package:tech_seeker_2023/go.dart';
import 'package:tech_seeker_2023/room.dart';


class AttackPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return AttackPageState();
  }
}

class AttackPageState extends State {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF1),

      body: Center(

        child: Column(
          //　均等に分ける　＝ spaceBetween
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Padding(padding: const EdgeInsets.only(top: 60,right:450)
              ,child:ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  //child: const Text("戻る")),),*/

            Padding(padding: const EdgeInsets.only(top: 0),child:Image.asset('images/太陽.png'),),

            Container(
                alignment: Alignment.topCenter,
                child:
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  const Text('必要',
                      style: TextStyle(
                        fontSize: 36,
                      )),
                  ElevatedButton( child: const Text('OFF'),onPressed: () {},),
                ])),
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
              ElevatedButton(onPressed: () {}, child: const Text('音量')),
            ]),
            const Text('LED',
                style: TextStyle(
                  fontSize: 36,
                )),
            Padding(padding: const EdgeInsets.only(bottom: 0)
              ,child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                ElevatedButton(onPressed: () {}, child: const Text('ON')),
                ElevatedButton(onPressed: () {}, child: const Text('OFF')),
                ElevatedButton(onPressed: () {}, child: const Text('色')),
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
                  context, MaterialPageRoute(builder: (context) => GotoPage()));
              // 他の処理を追加
            }
          },
        ),
      ),
    );
  }
}
