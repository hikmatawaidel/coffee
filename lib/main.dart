import 'package:clothes_app/users/authentication/login_screen.dart';
import 'package:clothes_app/users/model/home_screen.dart';
import 'package:clothes_app/users/model/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  //to ensure that the Flutter framework's binding is initialized before executing certain operations, especially asynchronous ones, during app startup.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      // home: FutureBuilder(
      //   // Add your asynchronous operation here
      //   future: fetchData(), // Replace fetchData with your actual asynchronous operation
      //   builder: (context, dataSnapShot) {
      //     // Check the connection state
      //     if (dataSnapShot.connectionState == ConnectionState.waiting) {
      //       // If the Future is still running, show a loading indicator
      //       return CircularProgressIndicator();
      //     } else if (dataSnapShot.hasError) {
      //       // If an error occurs, display an error message
      //       return Text('Error: ${dataSnapShot.error}');
      //     } else {
      //       // If the Future is complete, display the result
      //       return WelcomeScreen();
      //     }
      //   },
      // ),
      home: WelcomeScreen(),
    );
  }

  // Replace this function with your actual asynchronous operation
  Future<String> fetchData() async {
    // Simulating a network call or any other asynchronous operation
    await Future.delayed(Duration(seconds: 2));
    return 'Data loaded successfully';
  }
}




