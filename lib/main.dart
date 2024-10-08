import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: JankenPage(),
    );
  }
}

class JankenPage extends StatefulWidget {
  const JankenPage({super.key});

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
  String myhand = '👊';
  String computerHand = '👊';
  String result = '引き分け';
  String final_result = 'どちらが勝つでしょうか';
  int battletimes = 0;
  int winning_result = 0;
  int losing_result = 0;
  int draw_result = 0;

  void selectHand(String selectedHand) {
    myhand = selectedHand;
    print(myhand);
    generateComputerHand();
    judge();
    recordBattleTimes();
    recordResult();
    final_result = battleRecordAnnouncement(battletimes);
    setState(() {});
  }

  void generateComputerHand() {
    final randomNumber = Random().nextInt(3);

    computerHand = randomNumberToHand(randomNumber);
  }

  void recordBattleTimes() {
    battletimes += 1;
    if (battletimes == 6) {
      battletimes = 0;
    }
  }

  void recordResult() {
    if (result == '勝ち') {
      winning_result += 1;
    }
    if (winning_result == 6) {
      winning_result == 0;
    }
    if (result == '負け') {
      losing_result += 1;
    }
    if (losing_result == 6) {
      losing_result == 0;
    }
    if (result == '引き分け') {
      draw_result += 1;
    }
    if (draw_result == 6) {
      draw_result == 0;
    }
  }

  String battleRecordAnnouncement(int battletimes) {
    if (battletimes == 5) {
      return '対戦結果は$winning_result-$losing_resultで引き分けは$draw_result回です';
    } else
      return 'どっちが勝つかな';
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return '👊';
        case1:
        return '✌️';
      case 2:
        return '✋';

      default:
        return '👊';
    }
  }

  void judge() {
    if (myhand == computerHand) {
      result = '引き分け';
    } else if ((myhand == '👊' && computerHand == '✌️') ||
        (myhand == '✌️' && computerHand == '✋') ||
        (myhand == '✋' && computerHand == '👊')) {
      result = '勝ち';
    } else
      result = '負け';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('じゃんけん'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(final_result,
                style: TextStyle(
                  fontSize: 26,
                )),
            SizedBox(height: 20),
            Text('現在の対戦回数は$battletimes回です',
                style: TextStyle(
                  fontSize: 28,
                )),
            SizedBox(height: 30),
            Text(result,
                style: TextStyle(
                  fontSize: 32,
                )),
            SizedBox(height: 16),
            Text(
              computerHand,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(height: 16),
            Text(
              myhand,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectHand('👊');
                  },
                  child: Text('👊'),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand('✌️');
                  },
                  child: Text('✌️'),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand('✋');
                  },
                  child: Text('✋'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
