import 'package:flutter/material.dart';
import 'package:anlatmaca_kelime_oyunu/providers/theme_provider.dart';
import 'package:anlatmaca_kelime_oyunu/pages/home_page.dart';
import 'package:anlatmaca_kelime_oyunu/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'providers/game_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // GameModel başlatıldığında kartları yükleyecek
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final gameModel = GameModel();
            gameModel.loadCards().then((_) {
              gameModel
                  .pickRandomCard(); // Kartlar yüklenince ilk kartı seçiyoruz
            });
            return gameModel;
          },
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      home: const Homepage(),
    );
  }
}
