import 'package:developers_app/provider/AuthProvider.dart';
import 'package:developers_app/provider/CustomProvider.dart';
import 'package:developers_app/provider/ProductProvider.dart';
import 'package:developers_app/screens/Login.dart';
import 'package:developers_app/widgets/Custom/BottomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Services/firestore_service.dart';

Color navy = Color(0xff1F1D36);
Color grey = Color(0xFF3F3351);
Color purble = Color(0xff864879);
Color pink = Color(0xffE9A6A6);
Color white = Colors.white;
Color black = Colors.black;

LinearGradient linearColor = LinearGradient(
  begin: Alignment.centerLeft,
  colors: <Color>[
    navy,
    purble,
  ],
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirestoreService _db = FirestoreService();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CustomProvider()),
      ChangeNotifierProvider(create: (context) => ProductProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      StreamProvider(create: (context) => _db.getSpecialty()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.montserratTextTheme()),
      home: (auth?.currentUser != null) ? HomePage() : Login(),
    );
  }
}
