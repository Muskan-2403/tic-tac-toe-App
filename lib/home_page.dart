import 'package:flutter/material.dart';
import 'package:tictactoe2/custom_dialogue.dart';
import 'package:tictactoe2/game_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<GameButton> buttonlist;
  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonlist = doInit();
  }

  List<GameButton> doInit() {
    player1 = [];
    player2 = [];
    var gameButttons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButttons;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = "X";
        gb.bg = Colors.blue;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = "O";
        gb.bg = Colors.black;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;

      void resetGame() {
        // if(Navigator.canPop(context)=>Navigator.pop(context));
        setState(() {
          buttonlist = doInit();
        });
      }

      int checkWinner() {
        var winner = -1;
        //row 1
        if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
          winner = 1;
        }
        if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
          winner = 2;
        }
        //row 2
        if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
          winner = 1;
        }
        if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
          winner = 2;
        }
        //row 3
        if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
          winner = 1;
        }
        if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
          winner = 2;
        }

        //col 1
        if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
          winner = 1;
        }
        if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
          winner = 2;
        }
        //col 1
        if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
          winner = 1;
        }
        if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
          winner = 2;
        }
        //col 1
        if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
          winner = 1;
        }
        if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
          winner = 2;
        }

        //diag 1
        if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
          winner = 1;
        }
        if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
          winner = 2;
        }
        //diag 2
        if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
          winner = 1;
        }
        if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
          winner = 2;
        }
        if (winner != -1) {
          if (winner == 1) {
            showDialog(
                context: context,
                builder: (_) => CustomDialogue("Player 1 won!!",
                    "Please press reset to restart", resetGame));
          } else {
            showDialog(
                context: context,
                builder: (_) => CustomDialogue("Player 2 won!!",
                    "Please press reset to restart", resetGame));
          }
        }
        return winner;
      }

      var winner = checkWinner();
      if (winner == -1) {
        if (buttonlist.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (_) => CustomDialogue(
                  "game tie", "Please press reset to restart", resetGame));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("tic tac toe"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xfff6921e), Color(0xffee4036)])),
        child: Padding(
          padding: const EdgeInsets.only(top: 120.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 6.0,
                mainAxisSpacing: 9.0),
            itemCount: buttonlist.length,
            itemBuilder: (context, index) => SizedBox(
              width: 100,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: buttonlist[index].enabled
                      ? () => playGame(buttonlist[index])
                      : null,
                  child: Text(
                    buttonlist[index].text,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonlist[index].bg,
                      disabledBackgroundColor: buttonlist[index].bg),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
