import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  //keys: เข้าถึงได้โดยตรงจากคลาส HelperFunction โดยไม่จำเป็นต้องสร้างอินสแตนซ์ของคลาสก่อน
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

  //saving the data to SF
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();   //เชื่อมต่อกับที่เก็บข้อมูล
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);       //บันทึกค่า
  }
    static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }
    static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  //getting the data from SF
  static Future<bool?> getUserLoggedInStatus() async {    
    SharedPreferences sf = await SharedPreferences.getInstance();   
    return sf.getBool(userLoggedInKey); 
  }
  static Future<String?> getUserEmailFromSF() async {   
    SharedPreferences sf = await SharedPreferences.getInstance();   
    return sf.getString(userEmailKey); 
  }
  static Future<String?> getUserNameFromSF() async {   
    SharedPreferences sf = await SharedPreferences.getInstance();   
    return sf.getString(userNameKey); 
  }
}