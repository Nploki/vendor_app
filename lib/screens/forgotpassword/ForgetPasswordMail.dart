import 'package:flutter/material.dart';
import 'package:vendor_side_app/screens/otp/OTPScreen.dart';

class ForgotPasswordMailScreen extends StatelessWidget {
  const ForgotPasswordMailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Image(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTMo1Sp_iSOpZ-GYs9-4BClpmmdoWcHtNO4umftd2T_pxYYKR6mPhBuQOoTU_ZO3VeCXk&usqp=CAU"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Forgot Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(height: 5),
                Text(
                  "Enter Your Email-Id \n To Get Reset Password Code ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text("E-Mail"),
                            hintText: "E-Mail",
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OTPScreen()),
                            );
                          },
                          child: const Text("Get - OTP"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
