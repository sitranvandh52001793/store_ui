import 'package:flutter/material.dart';
import 'package:store_ui/Styles/colors.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < 5; i++)
              Container(
                width: 100,
                height: 105,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  // Border bottom
                  border: Border(
                    bottom: BorderSide(
                      color: i == 0 ? Colors.blue : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.person_3_sharp,
                      color: Colors.blue,
                      size: 30,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Dành cho bạn',
                      style: TextStyle(
                          fontSize: 13, color: Color.fromRGBO(66, 66, 66, 1)),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
