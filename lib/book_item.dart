import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final int index;

  const BookItem({required this.index});

  @override
  Widget build(BuildContext context) {
    // var headline6;
    return Card(
      elevation: 3,
      child: Center(
        child: Text(
          'Book ${index + 1}',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
              ),
        ),
      ),
    );
  }
}
