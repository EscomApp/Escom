import 'package:escom/screens/authenticates/loginScreen.dart';
import 'package:escom/screens/authenticates/register.dart';
import 'package:escom/screens/pages/brouillon.dart';
import 'package:escom/screens/pages/rubriques.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  //FirebaseApp defaultApp = await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      /*options: FirebaseOptions(  
      apiKey: "AIzaSyD_w2zVMrhOHb_Z9p_W0-JGytGHf69BtYc", 
      projectId: "zrgx-88624",
      messagingSenderId: "749821610528",
      appId: "1:749821610528:android:88f983cfea903d51768a45",
    )*/
      );
  //runApp(MyApp());
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Page title'),
        actions: [
          Icon(Icons.person),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Rubriquess(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(253, 17, 76, 240),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
       currentIndex: 0, // this will be set when a new tab is tapped
       items: const <BottomNavigationBarItem>[
         BottomNavigationBarItem(
           icon: Icon(Icons.home),
           label: 'Home',
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.mail),
           label: 'Messages',
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           label: 'Profile'
         )
       ],
     ),
     
      
    );
  }
}
