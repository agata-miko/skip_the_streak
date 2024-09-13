import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselWidget extends StatelessWidget {
  final List<String> imgList;

  // Constructor to pass image list
  CarouselWidget({required this.imgList});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: 16 / 9,
        initialPage: 0,
      ),
      items: imgList.map((item) {
        return InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: Image.network(item, fit: BoxFit.cover, width: MediaQuery.of(context).size.width * 0.8),
            ),
          ),
        );
      }).toList(),
    );
  }
}
