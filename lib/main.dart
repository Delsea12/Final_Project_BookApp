import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_books_app/book_list.dart';
import 'package:simple_books_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Book List';

    return const MaterialApp(
      title: title,
      home: BookListPage(
        pageTitle: title,
        bookTitles: [
          'Poetry',
          'Self Improvement',
          'Horror',
          'Historical Fiction',
          'Short Story',
          'Philosophy',
          'Humor',
          'Science Fiction',
          'Astrology',
          'Astronomy',
        ],
        imagePath: 'assets/images',
        imageHeight: 100,
      ),
    );
  }
}
