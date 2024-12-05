import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';
import '../services/api_service.dart';

class DetailPage extends StatefulWidget {
  final String type;
  final int id;

  const DetailPage({
    Key? key,
    required this.type,
    required this.id,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailPage> {
  final ApiService _apiService = ApiService();
  late Future<Article> _article;

  @override
  void initState() {
    super.initState();
    _article = _apiService.getArticleDetails(widget.type, widget.id);
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Article>(
          future: _article,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            final article = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article image with fallback error icon
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      article.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 200,
                          child: Center(child: Icon(Icons.error)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Article title
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Published date
                  Text(
                    'Published: ${article.publishedAt}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  // Article summary
                  Text(
                    article.summary,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final article = await _article;
          _launchUrl(article.url);
        }, heroTag: const Text("See More"),
        child: const Icon(Icons.newspaper),
      ),
    );
  }
}
