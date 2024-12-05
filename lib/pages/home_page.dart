import 'package:flutter/material.dart';
import 'package:latres_mobile/pages/list_page.dart';

class HomePage extends StatelessWidget {
  final String username;
  final String password;

  const HomePage({super.key, required this.username, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hai, $username!'), 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButton(
              title: 'News',
              icon: Icons.article,
              description: 'Get an overview of the latest SpaceFlight news from various sources. Easily link your users to the right websites.',
              onPressed: () => _navigateToList(context, 'articles'),
            ),
            const SizedBox(height: 16),
            MenuButton(
              title: 'Blog',
              icon: Icons.book,
              description: 'Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast.',
              onPressed: () => _navigateToList(context, 'blogs'),
            ),
            const SizedBox(height: 16),
            MenuButton(
              title: 'Report',
              icon: Icons.note_alt_rounded,
              description: 'Space stations and other missions often publish their data. With SNAPI, you can include it in your app.',
              onPressed: () => _navigateToList(context, 'reports'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToList(BuildContext context, String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListPage(type: type),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final VoidCallback onPressed;

  const MenuButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.description,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 145,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 30), // Icon
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
