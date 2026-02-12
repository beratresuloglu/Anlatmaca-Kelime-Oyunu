import 'package:flutter/material.dart';
import 'package:anlatmaca_kelime_oyunu/components/my_button.dart';
import 'package:anlatmaca_kelime_oyunu/components/my_image.dart';
import 'package:anlatmaca_kelime_oyunu/pages/game_settings_page.dart';
import 'package:anlatmaca_kelime_oyunu/pages/how_to_play_page.dart';
import 'package:anlatmaca_kelime_oyunu/pages/settings_page.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    double contentWidth = size.width > 500 ? 500 : size.width * 0.9;
    
    double gap = 20.0;
    double smallButtonWidth = (contentWidth - gap) / 2;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(), 
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea( // Çentikli telefonlar için koruma
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  width: contentWidth, 
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [

                      const Spacer(),
                      const MyImage(),
                      const Spacer(),

                      MyButton(
                        color: theme.colorScheme.surface,
                        fontColor: theme.primaryColor,
                        context: context,
                        text: 'Oyna',
                        width: contentWidth, // Dinamik genişlik
                        height: 80,
                        fontSize: 40,
                        function: () {
                          navigateTo(context, const GameSettingsPage());
                        } 
                      ),
                      
                      const SizedBox(height: 20), 

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyButton(
                            color: theme.colorScheme.surface,
                            fontColor: theme.primaryColor,
                            context: context,
                            text: 'Ayarlar',
                            width: smallButtonWidth, // Hesaplanan genişlik
                            height: 60,
                            fontSize: 20, // Yazı boyutu butona sığacak kadar
                            function: (){
                              navigateTo(context, const SettingsPage());
                            } 
                          ),
                          
                          MyButton(
                            color: theme.colorScheme.surface,
                            fontColor: theme.primaryColor,
                            context: context,
                            text: 'Nasıl Oynanır?',
                            width: smallButtonWidth, // Hesaplanan genişlik
                            height: 60,
                            fontSize: 18, // "Nasıl Oynanır?" uzun olduğu için fontu biraz kıstık
                            function: () {
                              navigateTo(context, const HowToPlayPage());
                            }
                          ),
                        ],
                      ),

                      // Alt boşluk (Esnek)
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}