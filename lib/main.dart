import 'package:flutter/material.dart';
import 'package:thuongmaidientu/screen/Authentication/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),//
        useMaterial3: true,//
        // primarySwatch: Colors.blue,
        // brightness: Brightness.light, // Chế độ sáng mặc định
      ),
      darkTheme: ThemeData(
        // primarySwatch: Colors.blue,
        // brightness: Brightness.dark, // Chế độ tối
      ),
     // themeMode: ThemeMode.system, // Tự động thay đổi giữa sáng/tối

      home: LoginScreen(),
    );
  }

}

