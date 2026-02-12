import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Team {
  String name;
  int score;

  Team({required this.name, this.score = 0});
}

class GameModel extends ChangeNotifier {
  int currentTeamIndex = 0;
  double time = 60;
  int teamCount = 2;
  int roundCount = 1;
  int passRight = 1;
  List<Team> teams = [];
  
  // Oyun boyunca toplam kaç kere sıra değiştiğini tutar
  int totalPlayedTurns = 0; 

  // --- Tabu kartları için alanlar ---
  List<Map<String, dynamic>> _cards = [];
  Map<String, dynamic>? _currentCard;
  int _usedCardCount = 0;

  List<Map<String, dynamic>> get cards => _cards;
  Map<String, dynamic>? get currentCard => _currentCard;

  Future<void> loadCards() async {
    final String jsonString = await rootBundle.loadString(
      'assets/words.json',
    );
    final List<dynamic> data = json.decode(jsonString);
    _cards = data.map((e) => e as Map<String, dynamic>).toList();
    notifyListeners();
  }

  void pickRandomCard() {
    if (_cards.isEmpty) return;
    final random = Random();
    _currentCard = _cards[random.nextInt(_cards.length)];
    _usedCardCount++;
    notifyListeners();
  }

  void nextCard() {
    if (_cards.isEmpty) return;
    final random = Random();
    _currentCard = _cards[random.nextInt(_cards.length)];
    _usedCardCount++;
    notifyListeners();
  }

  void pickUniqueRandomCard() {
    if (_cards.isEmpty) return;

    if (_usedCardCount >= _cards.length) {
      _usedCardCount = 0;
    }

    final random = Random();
    Map<String, dynamic> candidate;
    do {
      candidate = _cards[random.nextInt(_cards.length)];
    } while (candidate == _currentCard);

    _currentCard = candidate;
    _usedCardCount++;
    notifyListeners();
  }

  void setGameSettings({
    required double time,
    required int teamCount,
    required int roundCount,
    required int passRight,
  }) {
    this.time = time;
    this.teamCount = teamCount;
    this.roundCount = roundCount;
    this.passRight = passRight;

    // Oyun ayarları yapıldığında sayacı sıfırla
    totalPlayedTurns = 0;

    // Takımlar listesini sıfırla
    teams = List.generate(teamCount, (index) => Team(name: '', score: 0));

    notifyListeners();
  }

  void resetTeams() {
    teams.clear();
    // Takımlar sıfırlandığında tur sayacını da sıfırla
    totalPlayedTurns = 0; 
    notifyListeners();
  }

  Team get currentTeam => teams[currentTeamIndex];

  void addTeam(String name) {
    teams.add(Team(name: name));
    notifyListeners();
  }

  void nextTeam() {
    currentTeamIndex = (currentTeamIndex + 1) % teams.length;
    
    totalPlayedTurns++; 
    
    notifyListeners();
  }

  void addScoreToCurrentTeam(int points) {
    teams[currentTeamIndex].score += points;
    notifyListeners();
  }
  
  void setupGame({
    required double time,
    required int roundCount,
    required int passRight,
  }) {}

  void setTeamCount(int count) {
    teamCount = count;
    notifyListeners();
  }

  void increaseScore(int index) {
    teams[index].score++;
    notifyListeners();
  }
}