import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skip_the_streak/cubits/carousel_cubit.dart';

class CarouselWidget extends StatefulWidget {
  final List<String> imgList;

  // Constructor to pass image list
  CarouselWidget({required this.imgList});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  @override
  Widget build(BuildContext context) {
    final selectedImage = context.watch<CarouselCubit>().state;
    
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
        items: widget.imgList.map((imagePath) {
          return InkWell(
            onTap: () {
              context.read<CarouselCubit>().selectImage(imagePath);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Image.asset(
                    imagePath
                  ),
                ),
                if (selectedImage != null && selectedImage == imagePath)
                  Icon(
                    Icons.check,
                    size: 100,
                    color: Colors.white.withOpacity(0.9),
                  )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
