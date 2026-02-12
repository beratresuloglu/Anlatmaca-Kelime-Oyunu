import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:anlatmaca_kelime_oyunu/components/my_appbar.dart';

class HowToPlayPage extends StatefulWidget {
  const HowToPlayPage({super.key});

  @override
  State<HowToPlayPage> createState() => _HowToPlayPageState();
}

class _HowToPlayPageState extends State<HowToPlayPage> {
  late String textFromFile = '';

  @override
  void initState() {
    super.initState();
    loadTextAsset();
  }

  Future<void> loadTextAsset() async {
    try {
      final content = await rootBundle.loadString(
        'assets/data/how_to_play.txt',
      );
      setState(() {
        textFromFile = content;
      });
    } catch (e) {
      // Hata varsa göster veya logla
      print('Dosya okunamadı: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: MyAppBar(title_: 'Nasıl Oynanır', preferredSize: Size(200, 50)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: textFromFile.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Text(textFromFile, style: theme.textTheme.bodyLarge),
              ),
      ),
    );
  }
}
