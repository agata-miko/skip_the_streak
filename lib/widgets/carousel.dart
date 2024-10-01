import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselWidget extends StatelessWidget {
  final List<String> imgList;

  // Constructor to pass image list
  CarouselWidget({required this.imgList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.5,
          aspectRatio: 1.0,
          initialPage: 0,
        ),
        items: imgList.map((item) {
          return InkWell(
              onTap: () {},
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: Image.asset(
                  item,
                ),
              ));
        }).toList(),
      ),
    );
  }
}
