import 'package:flutter/material.dart';
import 'package:tugas_bab3/widgets/freelancecard.dart';

class FreelancerList extends StatelessWidget {
  final List<Map<String, dynamic>> freelancers = [
    {
      "name": "ayam panggang ",
      "produk": "Mi Instan",
      "rating": 4.0,
      "image": "assets/images/Mi ayam panggang.png"
    },
    {
      "name": "Mi ayam geprek",
      "produk": "Mi Instan",
      "rating": 4.9,
      "image": "assets/images/Mi goreng ayam geprek.png"
    },
    {
      "name": "Mi goreng",
      "produk": "Mi Instan",
      "rating": 5.0,
      "image": "assets/images/Mi goreng.png"
    },
    {
      "name": "Mi Mieghetti",
      "produk": "Mi Instan",
      "rating": 4.9,
      "image": "assets/images/Mi hype abis.png"
    },
  ];

  FreelancerList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: freelancers.length,
        itemBuilder: (context, index) {
          final freelancer = freelancers[index];
          return FreelancerCard(
            name: freelancer["name"],
            produk: freelancer["produk"],
            rating: freelancer["rating"],
            assetImage: freelancer["image"],
          );
        },
      ),
    );
  }
}

