
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerToy extends StatefulWidget {
  const BannerToy({Key? key}) : super(key: key);

  @override
  State<BannerToy> createState() => _BannerToyState();
}

class _BannerToyState extends State<BannerToy> {
  List imageToy = [
    {"id": 1, "image_paths": 'assets/images/banner4.jpg'},
    {"id": 2, "image_paths": 'assets/images/banner5.jpg'},
    {"id": 3, "image_paths": 'assets/images/banner6.jpg'}
  ];
  final CarouselController imagetoyController = CarouselController();
  int currentImagetoy = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(

        children: [
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              print(currentImagetoy);
            },
            child: CarouselSlider(
              items: imageToy
                  .map(
                    (item) => Image.asset(
                  item['image_paths'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
                  .toList(),

              carouselController: imagetoyController,
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: true,
                aspectRatio: 2,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentImagetoy = index;
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageToy.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => imagetoyController.animateToPage(entry.key),
                  child: Container(
                    width: currentImagetoy == entry.key ? 17 : 7,
                    height: 7.0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 3.0,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentImagetoy == entry.key
                            ? Colors.blue[200]
                            : Colors.white),
                  ),
                );
              }).toList(),
            ),
          ),

        ],
      ),
    );
  }
}
