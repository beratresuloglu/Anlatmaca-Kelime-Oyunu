import 'package:flutter/material.dart';
import 'package:anlatmaca_kelime_oyunu/pages/game_result_page.dart'; // GameResultPage import edildi
import 'package:anlatmaca_kelime_oyunu/components/my_button.dart';
import 'package:anlatmaca_kelime_oyunu/pages/playing_page.dart';
import 'package:provider/provider.dart';
import '../providers/game_model.dart';

class ScoreboardPage extends StatefulWidget {
  const ScoreboardPage({super.key});

  @override
  State<ScoreboardPage> createState() => _ScoreboardPageState();
}

class _ScoreboardPageState extends State<ScoreboardPage> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final game = Provider.of<GameModel>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text("Skor Tablosu")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Container(
              width: size.width * 0.9,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Puan Durumu",
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                      color: Colors.white70
                    ),
                  ),
                  const Divider(color: Colors.white24, thickness: 1, height: 30),

                  // Takımları Listele
                  ...game.teams.map((team) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            team.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white, 
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            "${team.score}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, 
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),

                  const SizedBox(height: 30),

                  // Devam Butonu
                  MyButton(
                    function: () {
                      // --- OYUN BİTİŞ KONTROLÜ ---
                      if (game.totalPlayedTurns >= game.roundCount * game.teamCount) {
                        
                        // 1. Takımların bir kopyasını al 
                        var sortedTeams = List.from(game.teams);
                        
                        // 2. Puana göre büyükten küçüğe sırala
                        sortedTeams.sort((a, b) => b.score.compareTo(a.score));

                        String winnerName;
                        int winnerScore = sortedTeams[0].score;

                        // 3. Beraberlik Kontrolü
                        // Eğer en az 2 takım varsa ve ilk ikisinin puanı eşitse
                        if (sortedTeams.length > 1 && sortedTeams[0].score == sortedTeams[1].score) {
                          winnerName = "DOSTLUK KAZANDI!\n(Berabere)";
                        } else {
                          // Değilse birinci olan kazanmıştır
                          winnerName = sortedTeams[0].name;
                        }

                        // 4. Sonuç Sayfasına Yönlendir
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameResultPage(
                              winningTeam: winnerName,
                              winningScore: winnerScore,
                            ),
                          ),
                        );

                      } else {
                        // --- OYUN DEVAM EDİYOR ---
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlayingPage(),
                          ),
                        );
                      }
                    },
                    color: theme.colorScheme.secondary,
                    fontColor: theme.primaryColor,
                    context: context,
                    fontSize: 20,
                    height: 50,
                    width: 200,
                    text: 'Devam',
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