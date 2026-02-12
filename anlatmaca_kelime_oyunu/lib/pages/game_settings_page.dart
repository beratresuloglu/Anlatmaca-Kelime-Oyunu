import 'package:flutter/material.dart';
import 'package:anlatmaca_kelime_oyunu/providers/game_model.dart';
import 'package:anlatmaca_kelime_oyunu/components/my_appbar.dart';
import 'package:anlatmaca_kelime_oyunu/components/my_button.dart';
import 'package:anlatmaca_kelime_oyunu/pages/team_info_page.dart';
import 'package:provider/provider.dart';

class GameSettingsPage extends StatefulWidget {
  const GameSettingsPage({super.key});

  @override
  State<GameSettingsPage> createState() => GameSettingsPageState();
}

class GameSettingsPageState extends State<GameSettingsPage> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gameModel = Provider.of<GameModel>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: MyAppBar(
        title_: 'Oyun Seçenekleri',
        preferredSize: const Size(200, 50),
      ),
      // Taşmaları önlemek için ScrollView ekle
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Container(
              width: size.width * 0.9,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              decoration: BoxDecoration(
                color: theme.appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // İçerik kadar yer kapla
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // OYUN SÜRESİ
                  _buildSettingItem(
                    context: context,
                    title: 'Oyun süresi',
                    value: gameModel.time,
                    min: 60,
                    max: 180,
                    divisions: 4,
                    onChanged: (val) => setState(() => gameModel.time = val),
                  ),

                  const SizedBox(height: 20),

                  // TAKIM SAYISI
                  _buildSettingItem(
                    context: context,
                    title: 'Takım sayısı',
                    value: gameModel.teamCount.toDouble(),
                    min: 2,
                    max: 6,
                    divisions: 4,
                    onChanged: (val) => setState(() => gameModel.teamCount = val.toInt()),
                  ),

                  const SizedBox(height: 20),

                  // TUR SAYISI
                  _buildSettingItem(
                    context: context,
                    title: 'Tur sayısı',
                    value: gameModel.roundCount.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    onChanged: (val) => setState(() => gameModel.roundCount = val.toInt()),
                  ),

                  const SizedBox(height: 20),

                  // PAS HAKKI
                  _buildSettingItem(
                    context: context,
                    title: 'Pas hakkı',
                    value: gameModel.passRight.toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    onChanged: (val) => setState(() => gameModel.passRight = val.toInt()),
                  ),

                  const SizedBox(height: 40),

                  // DEVAM BUTONU
                  MyButton(
                    fontColor: theme.primaryColor,
                    color: theme.colorScheme.secondary,
                    context: context,
                    text: 'Devam',
                    width: size.width > 500 ? 200 : size.width * 0.4, 
                    height: 50, 
                    fontSize: 20,
                    function: () {
                      gameModel.setGameSettings(
                        time: gameModel.time,
                        teamCount: gameModel.teamCount,
                        roundCount: gameModel.roundCount,
                        passRight: gameModel.passRight,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TeamInfoPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required BuildContext context,
    required String title,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Function(double) onChanged,
  }) {
    final theme = Theme.of(context);
    double sliderWidth = MediaQuery.of(context).size.width * 0.5;
    if (sliderWidth > 300) sliderWidth = 300; 

    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          width: sliderWidth,
          height: 50, // Sabit yükseklik, orana bağlı değil
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 5.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Slider(
            value: value,
            onChanged: onChanged,
            min: min,
            max: max,
            divisions: divisions,
            label: '${value.toInt()}', // .0 kurtulmak için toInt
          ),
        ),
      ],
    );
  }
}