import 'package:flutter/material.dart';
import 'package:tugas_bab3/widgets/bestbookingcard.dart';

class BestBooking2 extends StatelessWidget {
  const BestBooking2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          BestBookingCard(
            imageUrl: 'assets/images/indomie.jpg',
            profileUrl: 'assets/images/indomie.jpg',
            name: 'Mi goreng',
            role: 'Mi Instan',
            description: 'ini adalah Mi goreng.',
            rating: 4.9,
          ),
          SizedBox(height: 16.0),
          BestBookingCard(
            imageUrl: 'assets/images/indomie kriting.jpg',
            profileUrl: 'assets/images/indomie kriting.jpg',
            name: 'Mi kriting',
            role: 'Mi Instan',
            description: 'ini adalah Mi Kiriting.',
            rating: 4.9,
          ),
        ],
      );
  }
}