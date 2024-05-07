import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 14, 14, 14),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/images/exception_image.jpg"),
            const Center(
              child: Column(
                children: [
                  SizedBox(height: 200),
                  Text(
                    "Err! Can't Load Characters ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 30,
                      fontFamily: 'Mouldy',
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
