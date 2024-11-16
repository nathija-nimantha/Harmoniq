import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
      ),
      home: const MusicHomePage(),
    );
  }
}

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  final List<Map<String, String>> allMusicData = [
    {
      'title': 'Kohinoor',
      'subtitle': 'DIVINE',
      'image': 'assets/images/Kohinoor.jpg',
      'plays': '2.5M plays',
      'category': 'Hip-Hop'
    },
    {
      'title': 'Titanium',
      'subtitle': 'David Guetta ft. SIA',
      'image': 'assets/images/Titanium.jpg',
      'plays': '2.3M plays',
      'category': 'Podcasts'
    },
    {
      'title': 'Maradona Riddim',
      'subtitle': 'DJ Snake, Niniola',
      'image': 'assets/images/Maradona_Riddim.jpg',
      'plays': '1.3M plays',
      'category': 'Hip-Hop'
    },
    {
      'title': 'Blinding Lights',
      'subtitle': 'The Weeknd',
      'image': 'assets/images/Blinding_Lights.jpg',
      'plays': '3.0M plays',
      'category': 'Pop'
    },
    {
      'title': 'Levitating',
      'subtitle': 'Dua Lipa',
      'image': 'assets/images/Levitating.jpg',
      'plays': '1.8M plays',
      'category': 'Hip-Hop'
    },
    {
      'title': 'Stay',
      'subtitle': 'The Kid LAROI & Justin Bieber',
      'image': 'assets/images/Stay.jpg',
      'plays': '2.7M plays',
      'category': 'Pop'
    },
    {
      'title': 'Rockstar',
      'subtitle': 'DaBaby ft. Roddy Ricch',
      'image': 'assets/images/Rockstar.jpg',
      'plays': '4.2M plays',
      'category': 'Rap'
    },
    {
      'title': 'Shape of You',
      'subtitle': 'Ed Sheeran',
      'image': 'assets/images/Shape_Of_You.jpg',
      'plays': '5.0M plays',
      'category': 'Pop'
    },
    {
      'title': 'Bohemian Rhapsody',
      'subtitle': 'Queen',
      'image': 'assets/images/Bohemian_Rhapsody.jpg',
      'plays': '3.5M plays',
      'category': 'Rock'
    },
    {
      'title': 'Lose Yourself',
      'subtitle': 'Eminem',
      'image': 'assets/images/Lose_Yourself.jpg',
      'plays': '4.8M plays',
      'category': 'Rap'
    },
  ];

  final List<String> categories = [
    'All',
    'Hip-Hop',
    'Podcasts',
    'Pop',
    'Rap',
    'Rock',
    'Electronic'
  ];

  String selectedCategory = 'All';
  Map<String, String>? currentlyPlaying;

  @override
  Widget build(BuildContext context) {
    final filteredMusic = selectedCategory == 'All'
        ? allMusicData
        : allMusicData
        .where((music) => music['category'] == selectedCategory)
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        title: const Text(
          'Trending',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories
                    .map((category) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _categoryButton(category, selectedCategory == category),
                ))
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMusic.length,
              itemBuilder: (context, index) {
                final item = filteredMusic[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentlyPlaying = item;
                    });
                  },
                  child: _musicListTile(index + 1, item),
                );
              },
            ),
          ),
          if (currentlyPlaying != null) _currentlyPlayingBar(currentlyPlaying!),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Trending'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
        },
      ),
    );
  }

  Widget _categoryButton(String title, bool isSelected) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.redAccent : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: isSelected ? 5 : 1,
      ),
      onPressed: () {
        setState(() {
          selectedCategory = title;
        });
      },
      child: Text(title),
    );
  }

  Widget _musicListTile(int rank, Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            item['image']!,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
            },
          ),
        ),
        title: Text(
          item['title']!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                item['subtitle']!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              item['plays']!,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        trailing: Text(
          '#$rank',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }

  Widget _currentlyPlayingBar(Map<String, String> item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      color: Colors.grey[200],
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              item['image']!,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 40, color: Colors.grey);
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item['subtitle']!,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(Icons.play_arrow, size: 30, color: Colors.redAccent),
        ],
      ),
    );
  }
}
