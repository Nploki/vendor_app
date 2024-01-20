import 'package:flutter/material.dart';
import 'package:vendor_side_app/screens/welcome_screen.dart';
import 'profile_screen.dart';

class profile_update extends StatelessWidget {
  const profile_update({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const profile_screen()),
            );
          },
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const profile_screen(),
                ),
              );
            },
            icon: Icon(Icons.nights_stay_outlined),
            color: Colors.black,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(
                        image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfWwvGQn3hznks_Xjm7qv27_cZ_rOcEOfsVQ&usqp=CAU")),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromARGB(255, 255, 251, 12),
                    ),
                    child: Icon(
                      Icons.edit_rounded,
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
            Form(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outlined),
                          labelText: "User Name",
                          hintText: "User Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: "E-Mail",
                          hintText: "E-Mail",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: "Phone No",
                          hintText: "Phone No",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.fingerprint),
                        labelText: "Password",
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const profile_screen()),
                          );
                        },
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Joined 30 Octomber 2023"),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomeScreen()),
                            );
                          },
                          child: const Text("Delete"),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.redAccent.withOpacity(0.2),
                            onPrimary: Colors.red,
                            side: BorderSide.none,
                            shape: const StadiumBorder(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
