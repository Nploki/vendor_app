import 'package:flutter/material.dart';

class ForgotPasswordBtmWidget extends StatelessWidget {
  const ForgotPasswordBtmWidget({
    Key? key, required this.btnIcon, required this.title, required this.subtitle, required this.onTap,
  }) : super(key: key);

    final IconData btnIcon;
    final String title, subtitle;
    final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
             Icon(
              btnIcon,
              size: 60,
            ),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 20),
                  textAlign:
                      TextAlign.center,
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                      fontSize: 15),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}