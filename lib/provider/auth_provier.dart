// auth_provider.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vendor_side_app/helper/helper.dart';

class AuthProvider with ChangeNotifier {
  String error = '';
  bool isPicAvail = false;

  Future<UserCredential> registerSeller(
      String email, String password, File? selectedImage) async {
    notifyListeners();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user?.uid != null && selectedImage != null) {
        String imageUrl = (await uploadFile(selectedImage,
            'Uploads/showProfilePic/${userCredential.user!.uid}')) as String;
        // Save imageUrl or perform further actions as needed
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'Password is too weak';
        notifyListeners();
        print('Password is too weak');
      } else if (e.code == 'email-already-in-use') {
        error = 'This email account already exists.';
        notifyListeners();
        print('This email account already exists.');
      }
      rethrow;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      print(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> uploadFile(File file, String storagePath) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      await storage.ref(storagePath).putFile(file);
      String downloadURL = await storage.ref(storagePath).getDownloadURL();
      bool isPicAvail = true;
      return {"isPicAvail": isPicAvail, "downloadURL": downloadURL};
    } on FirebaseException catch (e) {
      print(e.code);
      rethrow; // Rethrow to handle the error in the calling function
    }
  }

  Future<void> checkLocationPermission() async {
    final PermissionStatus locationPermissionStatus =
        await Permission.location.request();

    switch (locationPermissionStatus) {
      case PermissionStatus.granted:
        break;
      case PermissionStatus.limited:
        break;
      default:
        await Helper.commonPopUpDialog(
          title: "Turn on location permission",
          message: "To use this app, please provide location permission.",
          primaryButtonName: "Open settings",
          primaryButtonAction: () {
            Get.back(); // Close the dialog
            openAppSettings();
          },
        );
        throw Exception("Location Permission denied");
    }
  }

  Future<bool> checkLocationServiceEnable() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      throw Exception('Please enable location services.');
    }
  }

  Future<Position> determinePosition() async {
    try {
      bool isLocationServiceEnabled;

      isLocationServiceEnabled = await checkLocationServiceEnable();
      if (!isLocationServiceEnabled) {
        await Helper.commonPopUpDialog(
          title: "Enable Location",
          message: "To use this app, please enable location services.",
          primaryButtonName: "Open settings",
          primaryButtonAction: () {
            Get.back(); // Close the dialog
            openAppSettings();
          },
        );
        throw Exception('Please enable location services.');
      }

      await checkLocationPermission();

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> savaVendorDataOnDb(
      {required String url,
      required String shopName,
      required String shopno,
      required String shopaddess,
      required double latitude,
      required double longitude}) async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference vendor =
        FirebaseFirestore.instance.collection('vendor').doc(user?.uid);

    vendor.set({
      'uid': user?.uid,
      'ShopName': shopName,
      'ShopNo': shopno,
      'Address': shopaddess,
      'latitude': latitude,
      'longitude': longitude,
      'location': GeoPoint(latitude, longitude),
      'shopOpen': true,
      'rating': 0.00,
      'totalrating': 0,
      'isTopPicked': true,
      'ImageUrl': url,
    });
    return;
  }
}
