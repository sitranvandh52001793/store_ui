import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 260.0,
          aspectRatio: 16 / 9,
          autoPlay: true,
          viewportFraction: 1,
          // remove space between item
        ),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  // radius
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10), // Border radius cho hình ảnh
                  child: Image.network(
                    'https://eu-central.storage.cloudconvert.com/tasks/aa729c95-6147-4150-95db-18da0011035b/sport-shoe-illustration-blue-backdrop-generated-by-ai_188544-19603.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=cloudconvert-production%2F20240314%2Ffra%2Fs3%2Faws4_request&X-Amz-Date=20240314T112931Z&X-Amz-Expires=86400&X-Amz-Signature=426de8676d271045a3419eaec6ac60254cd33aa700bb5e6d3f827042111a0cf3&X-Amz-SignedHeaders=host&response-content-disposition=inline%3B%20filename%3D%22sport-shoe-illustration-blue-backdrop-generated-by-ai_188544-19603.png%22&response-content-type=image%2Fpng&x-id=GetObject',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
