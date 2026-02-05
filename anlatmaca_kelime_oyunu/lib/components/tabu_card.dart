import 'package:flutter/material.dart';
import 'package:anlatmaca_kelime_oyunu/providers/game_model.dart';
import 'package:provider/provider.dart';

class TabuCard extends StatefulWidget {
  const TabuCard({super.key});

  @override
  State<TabuCard> createState() => _TabuCardState();
}

class _TabuCardState extends State<TabuCard> {
  @override
  Widget build(BuildContext context) {
    final gameModel = Provider.of<GameModel>(context);

    final theme = Theme.of(context);
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: theme.scaffoldBackgroundColor,
        ),
        width: 400,
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              elevation: 4,
              color: theme.cardColor,
              child: Container(
                width: 300,
                height: 80,
                padding: EdgeInsets.all(16),
                child: Text(
                  gameModel.currentCard!['word'],
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Card(
              elevation: 4,
              color: theme.cardColor,
              child: Container(
                width: 300,
                height: 350,
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      gameModel.currentCard!['forbidden_words'][0],
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      gameModel.currentCard!['forbidden_words'][1],
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      gameModel.currentCard!['forbidden_words'][2],
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      gameModel.currentCard!['forbidden_words'][3],
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      gameModel.currentCard!['forbidden_words'][4],
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
