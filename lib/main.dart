import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_counter_app/mainDrawer.dart';
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
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );
    SystemChrome.setEnabledSystemUIOverlays([]);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(
        resetHandler: resetGame,
        setStartingLifeHandler: setStartingLife,
        startingLife: startingLife,
        playerCount: playerCount,
        setPlayerCountHandler: setPlayerCount,
      ),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: playerCount > 3
                    ? [
                        Expanded(
                          flex: 1,
                          child: LifeCounter(
                            player: players[0],
                            upSideDown: true,
                            setHealthHandler: increasePlayerHealth,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: LifeCounter(
                            player: players[2],
                            upSideDown: true,
                            setHealthHandler: increasePlayerHealth,
                          ),
                        ),
                      ]
                    : [
                        LifeCounter(
                          player: players[0],
                          upSideDown: true,
                          setHealthHandler: increasePlayerHealth,
                        ),
                      ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: playerCount > 2
                    ? [
                        Expanded(
                          flex: 1,
                          child: LifeCounter(
                            player: players[1],
                            setHealthHandler: increasePlayerHealth,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: LifeCounter(
                            player: players[3],
                            setHealthHandler: increasePlayerHealth,
                          ),
                        )
                      ]
                    : [
                        LifeCounter(
                          player: players[1],
                          setHealthHandler: increasePlayerHealth,
                        ),
                      ],
              ),
            ),
          ],
        ),
        Builder(
          builder: (context) => IconButton(
            padding: EdgeInsets.all(15),
            iconSize: 30,
            icon: new Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ]),
    );
  }
}
