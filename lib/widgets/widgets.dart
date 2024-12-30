import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFee7b64), width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
  ),
);

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page)); //สร้างและเพิ่มหน้าใหม่ใน stack ของการนำทาง ทำให้สามารถย้อนกลับไปยังหน้าก่อนหน้าได้ด้วยการกดปุ่ม Back
} 

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));  //นำทางไปยังหน้าจอใหม่ แต่แทนที่หน้าจอปัจจุบันใน stack ของการนำทาง
                                                                                      //เหมาะสำหรับการเปลี่ยนหน้าที่ไม่ต้องการให้ผู้ใช้ย้อนกลับ เช่น เมื่อผู้ใช้เข้าสู่ระบบสำเร็จและไม่ต้องการให้กลับไปยังหน้าล็อกอิน
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontSize: 14),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 2),
    action: SnackBarAction(label: "OK",
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}