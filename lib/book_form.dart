import 'package:flutter/material.dart';

class AddBookForm extends StatefulWidget {
  final Function(String title, String author, String publishedDate,
      String genre, String description) onAddBook;

  const AddBookForm({Key? key, required this.onAddBook}) : super(key: key);

  @override
  _AddBookFormState createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _author = '';
  String _publishedDate = '';
  String _genre = '';
  String _description = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onAddBook(_title, _author, _publishedDate, _genre, _description);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the book title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the author';
                  }
                  return null;
                },
                onSaved: (value) {
                  _author = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Published Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the published date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _publishedDate = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Genre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the genre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _genre = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
