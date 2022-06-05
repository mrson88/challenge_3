import 'package:chanllenge_3/common/widgets/statefull/MesHomePage.dart';
import 'package:chanllenge_3/common/widgets/statefull/test_download.dart';
import 'common/widgets/statefull/downloadFile.dart';
import 'package:flutter/material.dart';
// import 'package:chanllenge_3/common/widgets/statefull/MesHomePage.dart';
import 'package:chanllenge_3/common/widgets/statefull/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MesHomePage.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        MesHomePage.id: (context) => const MesHomePage(),
        DownloadFile.id: (context) => const DownloadFile(),
        DownloadFileDemo.id: (context) => const DownloadFileDemo()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
