// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_ui/Styles/colors.dart';
// import 'package:badges/badges.dart' as badges;

class HomeNavbar extends StatelessWidget {
  const HomeNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text('TVS Store',
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 9,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 45),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                              color: Colors.grey.shade300, width: 0.5),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            // Height

                            border: InputBorder.none,
                            hintText: 'Tìm kiếm',
                            hintStyle: TextStyle(
                                color: Colors.grey.shade500, fontSize: 14),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 10,
                        top: 10,
                        child: Icon(Icons.search,
                            size: 25, color: Color(0xFF4C53A5)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
