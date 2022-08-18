import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../admin_account/admin_login.dart';
import '../adminhomescreen.dart';
import '../router/router.dart';
import '../widgets/custom_dialog.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> logIn(String email , String password) async{
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialog.showDialogFunction('no user found for that email!');
      } else if (e.code == 'wrong-password') {
        CustomDialog.showDialogFunction('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
  }
  checkUser() async{
    User? user = firebaseAuth.currentUser;
    if(user == null){
      await Navigator.push(AppRouter.navKey.currentContext!, MaterialPageRoute(builder: (BuildContext context){
        return AdminLoginScreen();
      }));
    }else{
      await Navigator.push(AppRouter.navKey.currentContext!, MaterialPageRoute(builder: (BuildContext context){
        return AdminHomeScreen();
      }));
    }
  }

  signOut() async{
    firebaseAuth.signOut();
    AppRouter.NavigateWithReplacemtnToWidget(AdminLoginScreen());
  }

  forgetPassword(String email) async{
    try{
      await firebaseAuth.sendPasswordResetEmail(email: email);
      CustomDialog.showDialogFunction('please check your email address to reset your password');
    }on Exception catch (e){
      CustomDialog.showDialogFunction('this email is not exist');
    }
  }
}