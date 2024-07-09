import 'package:flutter/material.dart';
import 'package:simple_books_app/detail_page.dart';

class BookListPage extends StatelessWidget {
  final String pageTitle;
  final List<String> bookTitles;
  final String imagePath;
  final double imageHeight;

  const BookListPage({
    Key? key,
    required this.pageTitle,
    required this.bookTitles,
    required this.imagePath,
    required this.imageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: bookTitles.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildBookItem(context, index);
        },
      ),
    );
  }

  Widget _buildBookItem(BuildContext context, int index) {
    return Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/Book_${index + 1}.jpeg',
            height: 100,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              bookTitles[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _navigateToBookDetailPage(context, bookTitles[index]);
            },
            child: const Text('View Details'),
          ),
        ],
      ),
    );
  }

  void _navigateToBookDetailPage(BuildContext context, String bookTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(bookTitle: bookTitle),
      ),
    );
  }
}
