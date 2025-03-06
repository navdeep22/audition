import 'package:audition/resources/app_constants/app_string.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SearchCarousal extends StatelessWidget {
  const SearchCarousal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 90,
      child: CarouselSlider(
        options: CarouselOptions(enlargeCenterPage: true, aspectRatio: 1),
        items: AppString.sliderList
            .map(
              (item) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Image(
                    image: AssetImage(item),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
