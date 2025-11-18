import 'package:flutter/material.dart';
import 'detail_screen.dart';
import 'edit_profile_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // final List<Map<String, String>> news = [
  //   {
  //     'imageUrl': 'https://static.bmdstatic.com/pk/product/AXIOO-MyPC-Pro-L5-8S1H922-Core-i512400-8GB-128GB--1TB-HDD-Win-11-Pro-c5b57837c0204fccbd4d1570f5a73a44_large.jpg',
  //     'title': 'Sample News Title 1',
  //     'author': 'Author 1',
  //     'description': 'This is a sample description for news article 1.',
  //     'time': '2024-06-01',
  //   },
  //   {
  //     'imageUrl': 'https://static.bmdstatic.com/pk/product/AXIOO-MyPC-Pro-L5-8S1H922-Core-i512400-8GB-128GB--1TB-HDD-Win-11-Pro-c5b57837c0204fccbd4d1570f5a73a44_large.jpg',
  //     'title': 'Sample News Title 2',
  //     'author': 'Author 2',
  //     'description': 'This is a sample description for news article 2.',
  //     'time': '2024-06-02',
  //   },
  // ];

  Future<List<Map<String, String>>> fetchNews() async {
    final response = await http.get(
      Uri.parse('https://hmti-news.hppms-sabala.my.id/api/documentation'),
    );

    if (response.statusCode == 200) {
      try {
        List<dynamic> data = json.decode(response.body);

        return data.map<Map<String, String>>((item) {
          return {
            'imageUrl':
                'https://events.hmti.unkhair.ac.id/storage/' +
                (item['image'] ?? ''),
            'title': item['title']?.toString() ?? 'No Title',
            'author': item['author']?.toString() ?? 'Unknown',
            'description': item['content']?.toString() ?? 'No Description',
            'time': item['updated_at']?.toString() ?? 'Unknown',
          };
        }).toList();
      } catch (e) {
        print("Error parsing data: $e");
        throw Exception('Failed to parse news data');
      }
    } else {
      print("Failed to load news with status: ${response.statusCode}");
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      FutureBuilder<List<Map<String, String>>>(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news available'));
          } else {
            List<Map<String, String>> news = snapshot.data!;
            return ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            title: news[index]['title'].toString(),
                            description: news[index]['description'].toString(),
                            imageUrl: news[index]['imageUrl'].toString(),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              news[index]['imageUrl']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              news[index]['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              '${news[index]['author']} • ${news[index]['time']}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      Center(child: Text('Explore Page')),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'HMTI',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' News',
              style: TextStyle(
                color: Color(0xFF1877F2),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Pengaturan', style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(color: Color(0xFF1877F2)),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [...pages, EditProfileScreen(), EditProfileScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color(0xFF1877F2),
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
