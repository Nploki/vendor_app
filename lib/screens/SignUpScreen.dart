import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_side_app/provider/auth_provier.dart';
import 'package:vendor_side_app/screens/LoginScreen.dart';
import 'package:vendor_side_app/screens/profile/profile_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  final AuthProvider _authProvider = AuthProvider();

  bool _isPasswordVisible = true;
  final bool _ispicAvail = false;
  String downloadurl = "";
  String loc = "";
  String address = "";
  double lat = 0, longt = 0;
  late String email;
  late String shopname;
  late String shopno;
  late String password;
  String? _selectedImagePath;
  File? _selectedImage;

  bool _isconfirmPasswordVisible = true;
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  final TextEditingController _imageFileNameController =
      TextEditingController();

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() async {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
        _selectedImagePath = pickedFile.path;
        _imageFileNameController.text =
            "${pickedFile.name}.${pickedFile.path.split('.').last}";
        try {
          Map<String, dynamic> uploadResult = await _authProvider.uploadFile(
            _selectedImage!,
            _selectedImagePath!,
          );

          bool isPicAvailable = uploadResult["isPicAvail"];
          String downloadUrl = uploadResult["downloadURL"];
        } catch (error) {
          print("Error during upload: $error");
        }
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    print(place);
    address =
        '${place.locality} ,\n${place.administrativeArea} - ${place.postalCode} , ${place.country}.';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Image(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjt6kYNwFy4_gStca5N_ZMrGu0SjfwN9IvGQ&usqp=CAU"),
                      height: 150,
                      width: 150,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Create you Profile \nTo Get Started",
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                  ],
                ),
                Container(
                  height: 425,
                  margin: const EdgeInsets.only(top: 30),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Form(
                        key: _formkey,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 70,
                                child: TextFormField(
                                  controller: _nameTextController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Shop Name";
                                    }
                                    setState(() {
                                      shopname = value;
                                    });
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.person_outlined),
                                      labelText: "Business Name",
                                      hintText: "Business Name",
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              const SizedBox(
                                height: 7.5,
                              ),
                              SizedBox(
                                height: 70,
                                child: TextFormField(
                                  controller: _emailTextController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Email-Id";
                                    }
                                    final bool isValid =
                                        EmailValidator.validate(
                                            _emailTextController.text);
                                    if (!isValid) {
                                      return "Enter a Valid Email-Id";
                                    }
                                    setState(() {
                                      email = _emailTextController.text;
                                    });
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email_outlined),
                                      labelText: "E-Mail",
                                      hintText: "E-Mail",
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              const SizedBox(
                                height: 7.5,
                              ),
                              SizedBox(
                                height: 70,
                                child: TextFormField(
                                  controller: _phoneTextController,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Phone Number";
                                    }
                                    if (value.length != 10) {
                                      return "Enter a Valid Phone Number";
                                    }
                                    setState(() {
                                      shopno = value;
                                    });
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      prefixText: "+91  ",
                                      prefixIcon: Icon(Icons.phone),
                                      labelText: "Phone No",
                                      hintText: "Phone No",
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              const SizedBox(
                                height: 7.5,
                              ),
                              SizedBox(
                                height: 70,
                                child: TextFormField(
                                  controller: _passwordTextController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Your Password";
                                    }
                                    if (value.length < 6) {
                                      return "Password Must be Greater then 6 Character";
                                    }
                                    return null;
                                  },
                                  obscureText: _isconfirmPasswordVisible,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.fingerprint),
                                    labelText: "Password",
                                    hintText: "Password",
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isconfirmPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isconfirmPasswordVisible =
                                              !_isconfirmPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 7.5,
                              ),
                              SizedBox(
                                height: 70,
                                child: TextFormField(
                                  controller: _confirmPasswordTextController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Your Password";
                                    }
                                    if (value.length < 6) {
                                      return "Password need's 6 character";
                                    }
                                    if (_passwordTextController.text != value) {
                                      return "Password Doesn't Match";
                                    }
                                    setState(() {
                                      password = value;
                                    });
                                    return null;
                                  },
                                  obscureText:
                                      !_isPasswordVisible, // Note the change here
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.fingerprint),
                                    labelText: "Re-Enter Password",
                                    hintText: "Re-Enter Password",
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 7.5,
                              ),
                              SizedBox(
                                height: 100,
                                child: TextFormField(
                                  maxLines: 4,
                                  controller: _addressTextController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Bunk Address";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                          Icons.add_business_outlined),
                                      suffixIcon: IconButton(
                                          onPressed: () async {
                                            Position position =
                                                await _authProvider
                                                    .determinePosition();

                                            loc =
                                                'lat:${position.latitude} : long:${position.longitude}';
                                            GetAddressFromLatLong(position);
                                            setState(() {
                                              _addressTextController.text =
                                                  address;
                                              lat = position.latitude;
                                              longt = position.longitude;
                                            });
                                          },
                                          icon: const Icon(
                                              Icons.location_searching)),
                                      labelText: "Bunk Address",
                                      hintText: "Bunk Address",
                                      border: const OutlineInputBorder()),
                                ),
                              ),
                              const SizedBox(
                                height: 7.5,
                              ),
                              SizedBox(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Add Bunk Image";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          const Icon(Icons.camera_alt_outlined),
                                      suffixIcon: IconButton(
                                          onPressed: _pickImage,
                                          icon: const Icon(
                                              Icons.add_circle_outline_sharp)),
                                      labelText: "Bunk Image",
                                      hintText: "Bunk Image",
                                      border: const OutlineInputBorder()),
                                  readOnly: true,
                                  controller: _imageFileNameController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _authProvider
                                .registerSeller(email, password, _selectedImage)
                                .then(
                              (crede) async {
                                if (crede.user?.uid != null) {
                                  // _authProvider
                                  await _authProvider
                                      .savaVendorDataOnDb(
                                          url: downloadurl,
                                          shopName: shopname,
                                          shopno: shopno,
                                          shopaddess: address,
                                          latitude: lat,
                                          longitude: longt)
                                      .then(
                                    (value) {
                                      Navigator.pushReplacementNamed(
                                          context, profile_screen.id);
                                    },
                                  );
                                }
                              },
                            );
                          }
                        },
                        child: const Text(
                          'REGISTER',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7.5,
                    ),
                    const Text("- OR -"),
                    const SizedBox(
                      height: 7.5,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text.rich(
                            TextSpan(
                              text: "Already have an Account?",
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: " LOGIN",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
