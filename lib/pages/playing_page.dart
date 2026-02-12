import 'dart:async';
import 'package:flutter/material.dart';
import 'package:anlatmaca_kelime_oyunu/providers/game_model.dart';
import 'package:anlatmaca_kelime_oyunu/components/my_button.dart';
import 'package:anlatmaca_kelime_oyunu/components/tabu_card.dart';
import 'package:anlatmaca_kelime_oyunu/pages/home_page.dart';
import 'package:anlatmaca_kelime_oyunu/pages/scoreboard_page.dart'; 
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:anlatmaca_kelime_oyunu/services/sound_manager.dart';

class PlayingPage extends StatefulWidget {
  const PlayingPage({super.key});

  @override
  State<PlayingPage> createState() => _PlayingPageState();
}

class _PlayingPageState extends State<PlayingPage> with SingleTickerProviderStateMixin {
  late Timer _timer;
  int _passright = 0;
  String _teamName = '';
  double _start = 0;
  bool _isRunning = true;
  int _score = 0;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  


  @override
  void initState() {
    super.initState();
    final gameModel = Provider.of<GameModel>(context, listen: false);

    _passright = gameModel.passRight;
    _teamName = gameModel.currentTeam.name;
    _start = gameModel.time;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      gameModel.pickUniqueRandomCard();
    });

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400), // Sallanma süresi
      vsync: this,
    );

    // Kartın sağa sola gitme rotası (0 -> -10 -> 10 -> -10 -> 0)
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 1), // Sola
      TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 2), // Sağa
      TweenSequenceItem(tween: Tween(begin: 10, end: -10), weight: 2), // Sola
      TweenSequenceItem(tween: Tween(begin: -10, end: 0), weight: 1),  // Ortaya
    ]).animate(_shakeController);

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer.cancel();
        _finishRound();
      }
    });
  }

  void _finishRound() {
    _isRunning = false;
    final gameModel = Provider.of<GameModel>(context, listen: false);
    gameModel.addScoreToCurrentTeam(_score);
    gameModel.nextTeam();
    navigate();
  }

  void navigate() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ScoreboardPage()),
    );
  }

  void _pass() {
    if (_passright <= 0) {
      _passright = 0;
      // Pas hakkı bittiyse sistemin "tık" sesi kalsın
      SystemSound.play(SystemSoundType.click);
    } else {
      // 4. ADIM: Pas sesini ekledik
      SoundManager.play('pass.wav');
      setState(() {
        _passright--;
      });
      nextCard();
    }
  }

  void _toggleCountdown() {
    if (_isRunning) {
      _timer.cancel();
      showPauseDialog(context);
    } else {
      _startTimer();
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    _shakeController.dispose();
    // Player'ı dispose etmeyi unutmuyoruz
    super.dispose();
  }

  void _incrementScore() {
    // 5. ADIM: Doğru sesini ekledik
    SoundManager.play('correct.wav'); // Tek satırla hallettik
    setState(() {
      _score++;
    });
    nextCard();
  }

  void _decreaseScore() {
    // 6. ADIM: Yanlış sesini ekledik
    SoundManager.play('wrong.wav');
    _shakeController.forward(from: 0);
    setState(() {
      _score--;
    });
    nextCard();
  }

  void nextCard() {
    final gameModel = Provider.of<GameModel>(context, listen: false);
    gameModel.nextCard();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    double contentWidth = size.width > 600 ? 600 : size.width;
    double buttonGap = 8.0;
    double padding = 20.0;
    double btnWidth = (contentWidth - padding - (buttonGap * 2)) / 3;

    return Scaffold(
      backgroundColor: theme.primaryColorLight,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 4,
        titleSpacing: 0,
        title: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _teamName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Skor: $_score',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Text(
                        '${_start.toInt()}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _toggleCountdown,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        _isRunning ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    const Spacer(), 
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20, 
                          horizontal: padding
                      ), 
                      child: AnimatedBuilder(
                        animation: _shakeController,
                        builder: (context, child) {
                          return Transform.translate(
                            // X ekseninde (yatayda) animasyon değeri kadar kaydır
                            offset: Offset(_shakeAnimation.value, 0), 
                            child: child,
                          );
                        },
                        child: const TabuCard(), // Hareket edecek olan asıl widget
                     ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: padding / 2, 
                        vertical: 20
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            color: const Color(0xffe31715),
                            fontColor: theme.colorScheme.surface,
                            context: context,
                            text: 'Yanlış',
                            width: btnWidth,
                            height: 55,
                            fontSize: 18,
                            function: _decreaseScore,
                          ),
                          SizedBox(width: buttonGap),
                          MyButton(
                            fontColor: theme.colorScheme.surface,
                            color: const Color(0xffffb557),
                            context: context,
                            text: 'Pas ($_passright)',
                            width: btnWidth,
                            height: 55,
                            fontSize: 18,
                            function: _pass,
                          ),
                          SizedBox(width: buttonGap),
                          MyButton(
                            color: const Color(0xff007bff),
                            fontColor: theme.colorScheme.surface,
                            context: context,
                            text: 'Doğru',
                            width: btnWidth,
                            height: 55,
                            fontSize: 18,
                            function: _incrementScore,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showPauseDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Oyun Duraklatıldı'),
          content: Text(
            'Devam etmek ister misiniz?',
            style: TextStyle(color: theme.canvasColor),
          ),
          actions: [
            TextButton(
              child: Text(
                'Ana Menüye Dön',
                style: TextStyle(color: theme.colorScheme.error),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Homepage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            TextButton(
              child: Text(
                'Devam Et',
                style: TextStyle(color: theme.primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _toggleCountdown();
              },
            ),
          ],
        );
      },
    );
  }
}