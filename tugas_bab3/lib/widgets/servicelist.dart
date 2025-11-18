import 'package:flutter/material.dart';
import 'package:tugas_bab3/widgets/servicecard.dart';

class ServiceList extends StatelessWidget {
  const ServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        ServiceCard(
          imageUrl: 'assets/images/Mi goreng ayam geprek.png',
          name: 'Mi ayam geprek',
          role: 'Mi Instan',
          description: 'Produk Indomi.',
          rating: 4.0,
        ),
        ServiceCard(
          imageUrl: 'assets/images/Mi hype abis.png',
          name: 'Mi Mieghetti',
          role: 'Mi Instan',
          description: 'Produk Indomi.',
          rating: 4.9,
        ),
        ServiceCard(
          imageUrl: 'assets/images/Mi goreng.png',
          name: 'Mi goreng',
          role: 'Mi Instan',
          description: 'Produk Indomi.',
          rating: 5.0,
        ),
      ],
    );
  }
}