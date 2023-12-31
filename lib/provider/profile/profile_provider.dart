import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinity/controller/custom_image_picker.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/models/user/user_model.dart';

import '../../data/local/cache_helper.dart';

class ProfileProvider extends ChangeNotifier {
  bool isLoading = false;
  bool imageNotNull = false;
  File? profImg;
   UserModel? currentUser;

  Future<UserModel?> getUserData(int loginType) async {
    if (FirebaseAuth.instance.currentUser != null) {

     await FirebaseHelper().getUserData(
          UId: FirebaseAuth.instance.currentUser!.uid,
          collectionName:
          loginType==2 ? "users" : "admin");

     currentUser = FirebaseHelper().userModel;
    }


    return currentUser;
  }

  Future<void> logout() async {
    notifyListeners();
    CacheHelper.clear();
    await FirebaseHelper().userLogOut();
    currentUser=null;
    isLoading = false;
    notifyListeners();
  }

  Future<void> uploadImage(String imageProvider) async {
    isLoading = true;
    notifyListeners();
    profImg = await CustomImagePicker().pickImage(imageProvider);
    if (profImg != null) {
      imageNotNull = true;
      FirebaseHelper().uploadProfileImage(profImg!);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchImage(String userId) async {
    if (imageNotNull) {
      isLoading = true;
      notifyListeners();
      await FirebaseHelper().fetchProfileImage(userId);
      isLoading = false;
      notifyListeners();
    }
  }
}
