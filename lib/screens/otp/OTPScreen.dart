import 'package:flutter/material.dart';
import '../profile/profile_screen.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const msg = "Enter the verification code you got";
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPMenCLFDLm0B36vdE1PfeELP03WhDPKwMgQ&usqp=CAU"),
              height: size.height * 0.3,
            ),
            SizedBox(
              height: 25,
            ),
            Text("$msg",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 90, 88, 88))),
            const SizedBox(
              height: 20,
            ),
            // OtpTextField(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   numberOfFields: 6,
            //   fillColor: Color.fromARGB(255, 204, 203, 203),
            //   filled: true,
            //   onSubmit: (code) {
            //     print("OTP is $code");
            //   },
            // ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const profile_screen(),
                    ),
                  );
                },
                child: const Text("GET - IN"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
