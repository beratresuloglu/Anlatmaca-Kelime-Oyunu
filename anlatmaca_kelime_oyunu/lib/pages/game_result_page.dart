import 'dart:math'; // Random ve Pi sayısı için gerekli
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart'; // Konfeti paketi

class GameResultPage extends StatefulWidget {
  final String winningTeam;
  final int winningScore;

  const GameResultPage({
    super.key,
    required this.winningTeam,
    required this.winningScore,
  });

  @override
  State<GameResultPage> createState() => _GameResultPageState();
}

class _GameResultPageState extends State<GameResultPage> {
  // Konfeti kontrolcüsü
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    // Konfeti süresini ayarlıyoruz (örneğin 3 saniye patlasın)
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    
    // Sayfa açılır açılmaz patlat
    _confettiController.play();
  }

  @override
  void dispose() {
    // Sayfadan çıkınca kontrolcüyü kapat (Hafıza sızıntısını önler)
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      body: Stack(
        alignment: Alignment.topCenter, 
        children: [
          // --- Tebrik Katmanı ---
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.emoji_events,
                    color: Colors.amber,
                    size: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "TEBRİKLER!",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.winningTeam,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Toplam Skor: ${widget.winningScore}",
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "YENİ OYUN",
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Konfeti katmanı ---
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2, 
            maxBlastForce: 5, 
            minBlastForce: 2,
            emissionFrequency: 0.05, 
            numberOfParticles: 20, 
            gravity: 0.1, 
            shouldLoop: false, 
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // Konfeti renkleri
          ),
        ],
      ),
    );
  }
}