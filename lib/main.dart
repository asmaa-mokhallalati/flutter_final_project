import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/src/providers/main_provider.dart';

import 'package:provider/provider.dart';

import 'src/view/screens/splach_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider<mainProviders>(
      create: (context) => mainProviders(),
      child: MaterialApp(home: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, AsyncSnapshot<FirebaseApp> dataSnapShot) {
          if (dataSnapShot.hasError) {
            return Scaffold(
              backgroundColor: Colors.red,
              body: Center(
                child: Text(dataSnapShot.error.toString()),
              ),
            );
          }
          if (dataSnapShot.connectionState == ConnectionState.done) {
            return SplachScreen();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
