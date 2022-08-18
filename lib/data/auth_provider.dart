import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import '../adminhomescreen.dart';
import '../router/router.dart';
import '../widgets/custom_dialog.dart';
import 'auth_helper.dart';

class AuthProvider extends ChangeNotifier{
  GlobalKey<FormState> loginKey = GlobalKey();
  TextEditingController emailLogController = TextEditingController();
  TextEditingController passwordLogController = TextEditingController();

  nullValidation (String? v){
    if(v == null || v.isEmpty){
      return 'Required *';
    }
  }
  String? nameValidator(String? value){
    if(value!.isEmpty){
      return 'Required *';
    }else if(value.length < 3){
      CustomDialog.showDialogFunction('Your Name must be more than 3 letters!');
    }
  }
  String? emailValidator(String? value){
    if(value!.isEmpty){
      return 'Required *';
    }else if(!isEmail(value)){
      CustomDialog.showDialogFunction('Wrong Email Format');
    }
  }
  String? passwordValidator(String? value){
    if(value!.isEmpty){
      return 'Required *';
    }
    else if(value.length<6){
      CustomDialog.showDialogFunction('Weak Password');
    }
  }

  CollectionReference<Map<String, dynamic>> userCollection = FirebaseFirestore.instance.collection('users');

  addUserToFireStore(String email,String userName,String id)async{
    userCollection.doc(id).set({
      'userName': userName,
      'email':email,
      'id':id
    });
  }

  getUserFromFireStore(String id) async{
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await userCollection.doc(id).get();
    Map<String,dynamic>? dataMap = documentSnapshot.data();

  }

  adminLogIn() async{
    if(loginKey.currentState!.validate()){
      UserCredential? credentials = await AuthHelper.authHelper.logIn( emailLogController.text, passwordLogController.text);
      if(credentials != null ){
        AppRouter.NavigateWithReplacemtnToWidget(AdminHomeScreen());
        emailLogController.text = '';
        passwordLogController.text = '';
      }else{
        log('can not log in');
      }

    }
  }

  checkUser(){
    AuthHelper.authHelper.checkUser();
  }

  signOut(){
    AuthHelper.authHelper.signOut();
  }

  forgetPassword(){
    AuthHelper.authHelper.forgetPassword('mohammedmotlaq32@gmail.com');
  }

}