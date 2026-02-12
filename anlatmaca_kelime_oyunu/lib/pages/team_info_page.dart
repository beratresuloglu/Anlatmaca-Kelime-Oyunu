import 'package:flutter/material.dart';
import 'package:anlatmaca_kelime_oyunu/components/my_appbar.dart';
import 'package:anlatmaca_kelime_oyunu/components/my_button.dart';
import 'package:anlatmaca_kelime_oyunu/providers/game_model.dart';
import 'package:anlatmaca_kelime_oyunu/components/text_field_container.dart';
import 'package:anlatmaca_kelime_oyunu/pages/scoreboard_page.dart';
import 'package:provider/provider.dart';

class TeamInfoPage extends StatefulWidget {
  const TeamInfoPage({super.key});

  @override
  State<TeamInfoPage> createState() => _TeamInfoPageState();
}

class _TeamInfoPageState extends State<TeamInfoPage> {
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    final gameModel = Provider.of<GameModel>(context, listen: false);
    for (int i = 0; i < gameModel.teamCount; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Widget> createTextFields() {
    final gameModel = Provider.of<GameModel>(context, listen: false);
    return List.generate(gameModel.teamCount, (index) => buildTextField(index));
  }

  Widget buildTextField(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(
            '${index + 1}. Takım adı:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 280, 
            height: 55,
            child: TextFieldContainer(
              child: TextField(
                controller: controllers[index],
                textAlignVertical: TextAlignVertical.center, // Yazıyı dikeyde ortalar
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Takım ismini giriniz",
                  contentPadding: EdgeInsets.only(bottom: 8), // Yazıyı hizalamak için
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onContinue(BuildContext context) {
    if (controllers.any((controller) => controller.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lütfen tüm takım adlarını doldurun"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final gameModel = Provider.of<GameModel>(context, listen: false);
    gameModel.resetTeams();

    for (var controller in controllers) {
      gameModel.addTeam(controller.text.trim());
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScoreboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: MyAppBar(title_: 'Takımlar', preferredSize: const Size(200, 50)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500), 
            child: Container(
              width: size.width * 0.9,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: theme.appBarTheme.backgroundColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...createTextFields(),

                  const SizedBox(height: 30),

                  MyButton(
                    fontColor: theme.primaryColor,
                    color: theme.colorScheme.secondary,
                    context: context,
                    text: 'Devam',
                    width: 200, 
                    height: 50,
                    fontSize: 20,
                    function: () => _onContinue(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}