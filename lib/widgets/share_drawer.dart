import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareDrawer extends StatelessWidget {
  const ShareDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Share via:",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
            title: const Text("WhatsApp", style: TextStyle(color: Colors.white)),
            onTap: () {
              // Implement share functionality here
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
            title: const Text("Instagram", style: TextStyle(color: Colors.white)),
            onTap: () {
              // Implement share functionality here
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
            title: const Text("Facebook", style: TextStyle(color: Colors.white)),
            onTap: () {
              // Implement share functionality here
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
            title: const Text("Twitter", style: TextStyle(color: Colors.white)),
            onTap: () {
              // Implement share functionality here
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context),
            child: const Text("Close", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
