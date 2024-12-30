import 'package:firebase_auth/firebase_auth.dart';

import 'package:mumuchatapp/service/database_service.dart';
import 'package:mumuchatapp/helper/helper_function.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;   // User will never be null
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


  //register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        // call our database service to update the user data.
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //signout
  Future signOut() async {
    try {
      await HelperFunction.saveUserLoggedInStatus(false); //Update the status in Shared Preferences to show that the user is logged out
      await HelperFunction.saveUserEmailSF(""); //Clear user emails saved in Shared Preferences for preventing reuse of old data
      await HelperFunction.saveUserNameSF("");  
      await firebaseAuth.signOut();   // Call Firebase to log out
    } catch (e) {
      return null;
    }
  }
}
