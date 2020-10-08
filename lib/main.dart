import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

import './mainDrawer.dart';
import './lifeCounter.dart';
import './playerStats.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Charter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int startingLife = 20;
  int playerCount = 4;
  bool useCardLayout = true;

  List<PlayerStats> players = [
    PlayerStats(life: 20, playerNumber: 1),
    PlayerStats(life: 20, playerNumber: 2),
    PlayerStats(life: 20, playerNumber: 3),
    PlayerStats(life: 20, playerNumber: 4)
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    SystemChrome.setEnabledSystemUIOverlays([]);
    Wakelock.enable();
  }

  void increasePlayerHealth(int amount, PlayerStats player) {
    setState(() {
      player.life += amount;
    });
  }

  void resetGame() {
    setState(() {
      players.forEach((player) => player.life = startingLife);
    });
  }

  void setStartingLife(amount) {
    setState(() {
      startingLife = amount;
    });
  }

  void setPlayerCount(amount) {
    setState(() {
      playerCount = amount;
    });
  }

  void toggleCardLayout() {
    setState(() {
      useCardLayout = !useCardLayout;
    });
  }

  /// Sets up a lifecounter for a player.
  /// Determines how to draw the lifecounter,
  /// wheter it's on landscape, portrait, upside down or rightside up.
  Widget setupPlayerLifecounter(PlayerStats player) {
    var queryData = MediaQuery.of(context);

    bool isTwoPlayerGame = playerCount == 2;
    bool isThirdPlayerInThreePlayerGame =
        playerCount == 3 && player.playerNumber == 3;
    bool usePortraitMode = playerCount == 2 || isThirdPlayerInThreePlayerGame;
    bool isUpsideDown = player.playerNumber.remainder(2) == 1;

    return Container(
      width: usePortraitMode ? queryData.size.width : queryData.size.width / 2,
      height: queryData.size.height / 2,
      child: LifeCounter(
        player: player,
        upSideDown: isTwoPlayerGame ? !isUpsideDown : isUpsideDown,
        portraitMode: usePortraitMode,
        setHealthHandler: increasePlayerHealth,
        useCardLayout: useCardLayout,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 117, 117, 117),
      resizeToAvoidBottomInset: false,
      drawer: MainDrawer(
        resetHandler: resetGame,
        setStartingLifeHandler: setStartingLife,
        startingLife: startingLife,
        playerCount: playerCount,
        setPlayerCountHandler: setPlayerCount,
        toggleCardLayout: toggleCardLayout,
        useCardLayout: useCardLayout,
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Wrap(
              children: players
                  .where((player) => player.playerNumber <= playerCount)
                  .map(setupPlayerLifecounter)
                  .toList(),
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              padding: EdgeInsets.all(15),
              iconSize: 30,
              icon: new Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}
