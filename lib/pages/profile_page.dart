import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.purple.shade100,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  user?.displayName ?? "Sam",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  user?.email ?? "youremail@example.com",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          _buildProfileOption(Icons.favorite, "Favourites"),
          _buildProfileOption(Icons.download, "Downloads"),
          _buildProfileOption(Icons.language, "Languages"),
          _buildProfileOption(Icons.location_on, "Location"),
          _buildProfileOption(Icons.subscriptions, "Subscription"),
          _buildProfileOption(Icons.desktop_windows, "Display"),
          _buildProfileOption(Icons.delete, "Clear Cache"),
          _buildProfileOption(Icons.history, "Clear History"),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log Out"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Handle tap
      },
    );
  }
}
