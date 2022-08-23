import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: JankenPage(),
    );
  }
}

/// class名はアッパーキャメルケースにしましょう。
/// 先頭が大文字、単語の区切りも大文字です。
class JankenPage extends StatefulWidget {
  const JankenPage({Key? key}) : super(key: key);

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
  String myHand = '✊';
  String computerHand = '✊';
  String result = '引き分け';

  int gameCounter = 0;
  int winCounter = 0;
  int loseCounter = 0;

  void selectHand(String selectedHand) {
    if (gameCounter < 5) {
      myHand = selectedHand;
      generateComputerHand();
      judge();
      gameCounter++;
    }
    setState(() {});
  }

  void generateComputerHand() {
    final randomNumber = Random().nextInt(3);
    computerHand = randomNumberToHand(randomNumber);
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return '✊';
      case 1:
        return '✌️';
      case 2:
        return '✋';
      default:
        return '✊';
    }
  }

  /// 単純な綴り間違えなので修正しました。
  void judge() {
    if (computerHand == myHand) {
      result = '引き分け';
    } else if (myHand == '✊' && computerHand == '✌️' ||
        myHand == '✌️' && computerHand == '✋' ||
        myHand == '✋' && computerHand == '✊') {
      result = '勝ち';
      winCounter++;
    } else {
      result = '負け';
      loseCounter++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'じゃんけん',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (gameCounter < 5)
              Text(
                '勝負した回数: $gameCounter/5',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              Column(
                children: [
                  if (winCounter == loseCounter)
                    const Text(
                      '結果：引き分け！！',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    )
                  else if (winCounter < loseCounter)
                    const Text(
                      '結果：あなたの負け！',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    )
                  else
                    const Text(
                      '結果：あなたの勝ち！',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green[200]),
                    onPressed: () {
                      /// この処理は reset という関数を作ってそこにまとめるとよいです。
                      /// 名前がついているだけでコードが読みやすくなります。
                      myHand = '✊';
                      computerHand = '✊';
                      gameCounter = 0;
                      winCounter = 0;
                      loseCounter = 0;
                      setState(() {});
                    },
                    child: const Text(
                      'reset',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '勝負した回数: $gameCounter/5',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '勝ち：$winCounter',
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text(
                  '負け：$loseCounter',
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Column(
              children: [
                Text(
                  computerHand,
                  style: const TextStyle(fontSize: 40),
                ),
                const Text(
                  '相手',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              result,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              children: [
                Text(
                  myHand,
                  style: const TextStyle(fontSize: 40),
                ),
                const Text(
                  '自分',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green[200]),
                  onPressed: () {
                    selectHand('✊');
                  },
                  child: const Text(
                    '✊',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green[200]),
                  onPressed: () {
                    selectHand('✌️');
                  },
                  child: const Text(
                    '✌️',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green[200]), // foreground
                  onPressed: () {
                    selectHand('✋');
                  },
                  child: const Text(
                    '✋',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
