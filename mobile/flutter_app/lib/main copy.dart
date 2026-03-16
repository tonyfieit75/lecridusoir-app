import 'package:flutter/material.dart';
import 'screens/prayer_wall.dart';

void main() {
  runApp(const LeCriDuSoirApp());
}

class LeCriDuSoirApp extends StatelessWidget {
  const LeCriDuSoirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Le Cri du Soir',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void openPrayerWall(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PrayerWall(),
      ),
    );
  }

  Widget menuItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Le Cri du Soir'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: [

          menuItem(
            icon: Icons.favorite,
            title: "Prayer Requests",
            onTap: () => openPrayerWall(context),
          ),

          menuItem(
            icon: Icons.menu_book,
            title: "Daily Word",
          ),

          menuItem(
            icon: Icons.campaign,
            title: "Conferences / Réveil",
          ),

          menuItem(
            icon: Icons.schedule,
            title: "Service Schedule",
          ),

          menuItem(
            icon: Icons.volunteer_activism,
            title: "Offerings",
          ),

        ],
      ),
    );
  }
}