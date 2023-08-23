import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AppSlider extends StatelessWidget {
  final double height;
  final double width;
  final double aspectRatio;
  final double radius;
  final List imageList;
  final int autoPlayInterval;
  final int autoPlayAnimationDuration;
  final bool autoPlay;
  final bool isCover;
  final bool pauseAutoPlayInFiniteScroll;

  const AppSlider({
    this.isCover = true,
    Key? key,
    this.height = 130,
    this.aspectRatio = 16 / 9,
    this.width = 150,
    this.autoPlayInterval = 2,
    required this.imageList,
    this.autoPlayAnimationDuration = 800,
    this.autoPlay = true,
    this.pauseAutoPlayInFiniteScroll = false,
    this.radius = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        aspectRatio: aspectRatio,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: false,
        pauseAutoPlayInFiniteScroll: pauseAutoPlayInFiniteScroll,
        reverse: false,
        autoPlay: false,
        autoPlayInterval: Duration(seconds: autoPlayInterval),
        autoPlayAnimationDuration:
        Duration(milliseconds: autoPlayAnimationDuration),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: imageList
          .map(
            (item) => ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.network(
            item.image,
            fit: isCover ? BoxFit.fill : null,
            width: double.infinity,
          ),
        ),
      )
          .toList(),
    );
  }
}
getShimmerAllLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(100)),
        width: 80.0,

      ),
    ),
  );
}


Shimmer getShimmerLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.055),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 18.0,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 14.0,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 14.0,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),  color: Colors.white,),
                      height: 40,
                      width: 40,

                    ),
                    SizedBox(width: Get.width*0.03,),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}