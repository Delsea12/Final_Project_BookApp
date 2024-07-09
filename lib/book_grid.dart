import 'package:flutter/material.dart';
import 'package:simple_books_app/book_item.dart';

class BookGridView extends StatelessWidget {
  const BookGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(10, (index) {
        return BookItem(index: index);
      }),
    );
  }
}
