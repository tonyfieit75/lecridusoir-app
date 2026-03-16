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
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    PrayerWall(),
    WordScreen(),
    EventsScreen(),
    GiveScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: Colors.red,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Prayer",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Word",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: "Events",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: "Give",
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Le Cri du Soir"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 20),

            Image.asset(
              "assets/logo.png",
              height: 120,
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Le Cri Du Soir is a spiritual community dedicated to strengthening faith through collective prayer, spiritual guidance, and shared meditation. Our mission is to bring people together in unity, helping individuals grow spiritually and find peace through a deeper connection with God.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Our Mission",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "We believe in the power of prayer, unity, and spiritual awakening. "
                "Through shared devotion, teachings, and community support, "
                "Le Cri Du Soir helps believers grow spiritually and remain "
                "connected in faith.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Community Features",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [

                  FeatureItem(
                    icon: Icons.comment,
                    text: "Prayer comments to support one another",
                  ),

                  FeatureItem(
                    icon: Icons.favorite,
                    text: "Prayer reactions and encouragement",
                  ),

                  FeatureItem(
                    icon: Icons.notifications,
                    text: "Push notifications for new prayer requests",
                  ),

                  FeatureItem(
                    icon: Icons.video_call,
                    text: "Live prayer meetings and conferences",
                  ),

                ],
              ),
            ),

            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {

  final IconData icon;
  final String text;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [

          Icon(icon, color: Colors.red),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          )

        ],
      ),
    );
  }
}

class WordScreen extends StatelessWidget {
  const WordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Daily Word")),
      body: const Center(
        child: Text(
          "Daily devotion will appear here",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Conferences / Réveil")),
      body: const Center(
        child: Text(
          "Upcoming conferences will appear here",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class GiveScreen extends StatelessWidget {
  const GiveScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Offerings")),
      body: const Center(
        child: Text(
          "CashApp / Zelle giving options here",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}