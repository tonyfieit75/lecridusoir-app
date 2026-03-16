import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrayerWall extends StatefulWidget {
  const PrayerWall({super.key});

  @override
  State<PrayerWall> createState() => _PrayerWallState();
}

class _PrayerWallState extends State<PrayerWall> {

  List prayers = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController prayerController = TextEditingController();

  final String apiUrl = "http://127.0.0.1:8000";

  Future fetchPrayers() async {
    final response = await http.get(Uri.parse("$apiUrl/prayers"));

    if (response.statusCode == 200) {
      setState(() {
        prayers = json.decode(response.body);
      });
    }
  }

  Future submitPrayer() async {

    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        prayerController.text.isEmpty) {
      return;
    }

    await http.post(
      Uri.parse("$apiUrl/prayers"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": nameController.text,
        "phone": phoneController.text,
        "message": prayerController.text
      }),
    );

    nameController.clear();
    phoneController.clear();
    prayerController.clear();

    fetchPrayers();
  }

  Future prayFor(String name) async {

    await http.post(
      Uri.parse("$apiUrl/pray/$name"),
    );

    fetchPrayers();
  }

  @override
  void initState() {
    super.initState();
    fetchPrayers();
  }

  Widget buildPrayerCard(prayer) {

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Icon(Icons.favorite, color: Colors.red),

                const SizedBox(width: 8),

                Text(
                  prayer['name'] ?? "Anonymous",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 6),

            Text(
              prayer['message'] ?? "",
              style: const TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 6),

            Text(
              "Phone: ${prayer['phone'] ?? ''}",
              style: const TextStyle(fontSize: 12),
            ),

            Text(
              "Date: ${prayer['date'] ?? ''}",
              style: const TextStyle(fontSize: 12),
            ),

            const SizedBox(height: 10),

            Row(
              children: [

                Text(
                  "🙏 ${prayer['count'] ?? 0} people prayed",
                  style: const TextStyle(fontSize: 13),
                ),

                const Spacer(),

                ElevatedButton(
                  onPressed: () => prayFor(prayer['name']),
                  child: const Text("I Prayed"),
                )

              ],
            )

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Prayer Wall"),
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(10),

            child: Column(
              children: [

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Your Name",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: prayerController,
                  decoration: const InputDecoration(
                    labelText: "Submit Prayer Request",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: submitPrayer,
                    child: const Text("Send Prayer"),
                  ),
                ),

              ],
            ),
          ),

          const Divider(),

          Expanded(
            child: ListView.builder(
              itemCount: prayers.length,
              itemBuilder: (context, index) {
                return buildPrayerCard(prayers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}