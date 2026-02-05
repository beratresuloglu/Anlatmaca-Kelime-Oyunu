import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class TabuCardsService {
  static List<Map<String, dynamic>> _cards = [];

  // JSON dosyasını yükler (sadece 1 kez)
  static Future<void> loadCards() async {
    if (_cards.isNotEmpty) return; // Zaten yüklüyse tekrar yükleme

    final String jsonString = await rootBundle.loadString(
      'assets/tabu_words.json',
    );
    final List<dynamic> data = json.decode(jsonString);
    _cards = data.map((e) => e as Map<String, dynamic>).toList();
  }

  //Tüm kartları döndürür
  static List<Map<String, dynamic>> getAllCards() {
    return _cards;
  }

  //Rastgele bir kart döndürür
  static Map<String, dynamic> getRandomCard() {
    final random = Random();
    return _cards[random.nextInt(_cards.length)];
  }

  // Belirli bir id'ye sahip kartı döndürür
  static Map<String, dynamic>? getCardById(String id) {
    return _cards.firstWhere((card) => card['id'] == id, orElse: () => {});
  }
}
