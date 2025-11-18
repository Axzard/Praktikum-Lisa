import 'package:flutter/material.dart';
import 'package:tugas_bab3/screens/cart_screen.dart';
import 'package:tugas_bab3/widgets/bestbooking.dart';
import 'package:tugas_bab3/widgets/bestbooking2.dart';
import 'package:tugas_bab3/widgets/dealsection.dart';
import 'package:tugas_bab3/widgets/freelancelist.dart';
import 'package:tugas_bab3/widgets/recommendedworkshopspage.dart';
import 'package:tugas_bab3/widgets/sectiontitle.dart';
import 'package:tugas_bab3/widgets/servicelist.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text("E-Commerce"),
        centerTitle: true,
        actions: [
          Icon(Icons.notifications, size: 24),
          SizedBox(width: 16),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Bab4()),
              );
            },
            icon: Icon(Icons.shopping_cart, size: 24)
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBar(),
            const DealSection(),
            SectionTitle(title: "Top Rated Freelancers", onViewAll: () {}),
            FreelancerList(),
            SectionTitle(title: "Top Services", onViewAll: () {}),
            const ServiceList(),
            BestBooking(),
            BestBooking2(),
            RecommendedWorkshopsPage(),
          ],
        ),
      ),
    );
  }
}
