import 'package:flutter/material.dart';
import 'package:vendor_side_app/screens/forgotpassword/ForgetPasswordMail.dart';
import 'package:vendor_side_app/screens/forgotpassword/ForgetPasswordPhone.dart';
import 'ForgotPasswordBtnWidget.dart';

class ForgotPasswordScreen {
  static Future<dynamic> buildShowModelButtonSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) => Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Make Selection!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              "Select one of the option given below to reset your Password",
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(
              height: 15,
            ),
            ForgotPasswordBtmWidget(
              btnIcon: Icons.email_outlined,
              title: "E-Mail",
              subtitle: "Reset OTP E-Mail Verification",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPasswordMailScreen()),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            ForgotPasswordBtmWidget(
              btnIcon: Icons.mobile_friendly_outlined,
              title: "Phone No",
              subtitle: "Reset via Phone Verification",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPhoneScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
