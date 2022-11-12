import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:paatify/controller/provider/bottumnavigationprovider.dart';
import 'package:paatify/controller/provider/homeprovider.dart';
import 'package:paatify/controller/provider/playlistlistprovider.dart';
import 'package:paatify/controller/provider/searchprovider.dart';
import 'package:paatify/model/paatify_model.dart';
import 'package:paatify/view/splash/splashscreen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(PaatifyMusicAdapter().typeId)) {
    Hive.registerAdapter(PaatifyMusicAdapter());
  }
  await Hive.openBox<int>('FavouriteDB');
  await Hive.openBox<PaatifyMusic>('playlistDB');

  await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
      preloadArtwork: true);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(
            create: (context) => BottumNavigationBarProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => PlayListListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const SplashScreen(),
      ),
    );
  }
}
