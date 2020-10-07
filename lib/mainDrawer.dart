import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Function resetHandler;
  int startingLife;
  int playerCount;
  bool useCardLayout;
  Function setStartingLifeHandler;
  Function setPlayerCountHandler;
  Function toggleCardLayout;

  MainDrawer({
    @required this.resetHandler,
    @required this.startingLife,
    @required this.playerCount,
    @required this.setStartingLifeHandler,
    @required this.setPlayerCountHandler,
    @required this.toggleCardLayout,
    @required this.useCardLayout,
  });

  var maxStartingLives = [10, 20, 30, 40, 50];
  var numberOfPlayerCounts = [2, 3, 4];

  void setStartingLife(selectedIndex) {
    setStartingLifeHandler(maxStartingLives[selectedIndex]);
  }

  void setNumberOfPlayers(selectedIndex) {
    setPlayerCountHandler(numberOfPlayerCounts[selectedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 70,
            child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                padding: EdgeInsets.only(left: 15),
                margin: EdgeInsets.zero,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    Container(
                      child: Text(
                        'Game settings',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      padding: EdgeInsets.only(left: 8),
                    )
                  ],
                )),
          ),
          ToggleButtonsWithTitle(
            title: 'Number of players',
            children: <Widget>[
              ...numberOfPlayerCounts.map((players) => Text(players.toString()))
            ],
            onPressed: setNumberOfPlayers,
            isSelected: numberOfPlayerCounts
                .map<bool>((players) => players == this.playerCount)
                .toList(),
          ),
          ToggleButtonsWithTitle(
            title: 'Default starting life',
            children: <Widget>[
              ...maxStartingLives.map((life) => Text(life.toString()))
            ],
            onPressed: setStartingLife,
            isSelected: maxStartingLives
                .map<bool>((life) => life == this.startingLife)
                .toList(),
          ),
          CheckboxListTile(
            title: const Text('Use card layout'),
            value: useCardLayout,
            onChanged: (toggled) => {toggleCardLayout()},
            secondary: const Icon(Icons.view_module),
          ),
          ListTile(
            title: Text('Reset game'),
            leading: Icon(Icons.refresh),
            onTap: () {
              resetHandler();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class CardWithPadding extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  CardWithPadding({this.child, this.padding});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: this.padding,
        child: this.child,
      ),
    );
  }
}

class ToggleButtonsWithTitle extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Function(int) onPressed;
  final List<bool> isSelected;

  ToggleButtonsWithTitle({
    this.title,
    this.children,
    this.onPressed,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                this.title,
                style: TextStyle(fontWeight: FontWeight.w600),
              )),
          ToggleButtons(
              children: this.children,
              onPressed: this.onPressed,
              isSelected: this.isSelected)
        ],
      ),
      padding: EdgeInsets.all(16),
    );
  }
}
