import 'package:firebase_core/firebase_core.dart';  
import 'package:flutter/material.dart';  
import 'package:flutter/foundation.dart';  //ให้ฟังก์ชันและเครื่องมือที่ช่วยในการพัฒนาแอป Flutter โดยเฉพาะในด้าน debugging และการจัดการข้อมูลที่เกี่ยวข้องกับการพัฒนาแอป: การ run the initialization for web/android/ios

import 'package:mumuchatapp/shared/constants.dart';
import 'package:mumuchatapp/helper/helper_function.dart';
import 'package:mumuchatapp/pages/auth/home_page.dart';
import 'package:mumuchatapp/pages/auth/auth/login_page.dart';


void main() async { //ถูกเรียกใช้เมื่อแอปเริ่มทำงาน โดยมีการใช้ async เพื่อรองรับการทำงานแบบ Asynchronous: เขียนโค้ดที่ non-blocking ซึ่งหมายความว่าสามารถทำงานหลายอย่างได้ในเวลาเดียวกัน โดยไม่ต้องรอให้แต่ละงานเสร็จสิ้นก่อนที่จะดำเนินการกับงานถัดไป ทำให้ฟังก์ชันสามารถใช้ await ในการรอผลลัพธ์ของฟังก์ชันที่มีการทำงานแบบอะซิงโครนัส
  WidgetsFlutterBinding.ensureInitialized();  //ช่วยให้แน่ใจว่าผู้เชื่อมต่อระบบ Flutter ได้รับการตั้งค่าอย่างถูกต้องก่อนที่จะเริ่มการทำงานอื่น ๆ ซึ่งรวมถึงการตั้งค่าระบบ UI และการจัดการกับแพลตฟอร์มเฉพาะ (เช่น การเรียกใช้งาน Firebase)
  
  if (kIsWeb) {
    //run the initialization for web
    await Firebase.initializeApp(
      options: FirebaseOptions(   // -> web เริ่มต้น Firebase โดยใช้การตั้งค่าที่กำหนด 
        apiKey: Constants.apiKey,
        appId: Constants.appId,
        messagingSenderId: Constants.messageingSenderId,
        projectId: Constants.projectId));
  } else {
    //run the initialization for android ans ios
    await Firebase.initializeApp(); //-> android ans ios
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {  
  const MyApp({Key? key}) : super(key: key); // Constructor 
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  
  @override // This widget is the root of your application
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if (value != null) {
        _isSignedIn = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {  //ฟังก์ชันนี้ใช้เพื่อสร้างและคืนค่า widget ที่จะแสดงบนหน้าจอ
    return MaterialApp(
      theme: ThemeData( //ธีมหลักของแอป ซึ่งนำไปใช้กับ widget ต่าง ๆ 
        primaryColor: Constants().primaryColor,    //สีหลักใช้กับองค์ประกอบต่าง ๆ 
        scaffoldBackgroundColor: Colors.white),  //สีพื้นหลัง
      debugShowCheckedModeBanner: false,    // ซ่อนแบนเนอร์ debug
      home: _isSignedIn ? const HomePage() : const LoginPage(),
    );
  }
}