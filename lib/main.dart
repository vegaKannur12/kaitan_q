import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaitan/screen/hospitalDisplay.dart';
import 'package:provider/provider.dart';

import 'components/globaldata.dart';
import 'controller/controller.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

Future<void> main() async {
  // final customNotifier = CustomNotifier();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Controller()),
      ],
      child: MyApp(),
    ));
  });
  // runApp(MyApp());
}
// getbr() async {
//   print("getbr---");

//   final File file = File('C:/flu/Tkn.txt');
//   var text = await file.readAsString();
//   // timerTest(text);
//   var map = jsonDecode(text);
//   ip = map["ip"];
//   br = map["br_id"];
//   img = map["img"];
//   // ip = "192.168.18.168/clinic2";
//   // br = "1";
//   // img = "add.mp4";
//   print('Ip--$ip--$br-');
//   // return ip;
// }
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HospitalScreen(),
    );
  }
}
