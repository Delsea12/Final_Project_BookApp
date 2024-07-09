import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookDetailPage extends StatefulWidget {
  final String bookTitle;

  const BookDetailPage({Key? key, required this.bookTitle}) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  List<BookDetail> bookDetails = [];

  @override
  void initState() {
    super.initState();
    _loadBookDetails();
  }

  void _loadBookDetails() async {
    FirebaseFirestore.instance
        .collection('books')
        .doc(widget.bookTitle)
        .collection('details')
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        bookDetails = querySnapshot.docs.map((doc) {
          return BookDetail(
            id: doc.id,
            author: doc['author'],
            publishedDate: doc['publishedDate'],
            genre: doc['genre'],
            description: doc['description'],
          );
        }).toList();
      });
    });
  }

  void _addBook() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddBookDialog(
          onBookAdded: (author, genre, publishDate, description) {
            FirebaseFirestore.instance
                .collection('books')
                .doc(widget.bookTitle)
                .collection('details')
                .add({
              'author': author,
              'publishedDate': publishDate,
              'genre': genre,
              'description': description,
            }).then((DocumentReference docRef) {
              setState(() {
                bookDetails.add(BookDetail(
                  id: docRef.id,
                  author: author,
                  publishedDate: publishDate,
                  genre: genre,
                  description: description,
                ));
              });
            });
          },
        );
      },
    );
  }

  void _editBook(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditBookDialog(
          initialBook: bookDetails[index],
          onBookUpdated: (author, genre, publishDate, description) {
            FirebaseFirestore.instance
                .collection('books')
                .doc(widget.bookTitle)
                .collection('details')
                .doc(bookDetails[index].id)
                .update({
              'author': author,
              'publishedDate': publishDate,
              'genre': genre,
              'description': description,
            }).then((_) {
              setState(() {
                bookDetails[index] = BookDetail(
                  id: bookDetails[index].id,
                  author: author,
                  publishedDate: publishDate,
                  genre: genre,
                  description: description,
                );
              });
            });
          },
        );
      },
    );
  }

  void _deleteBook(int index) {
    FirebaseFirestore.instance
        .collection('books')
        .doc(widget.bookTitle)
        .collection('details')
        .doc(bookDetails[index].id)
        .delete()
        .then((_) {
      setState(() {
        bookDetails.removeAt(index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: bookDetails.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text('Book ${index + 1} Details'),
              children: [
                Column(
                  children: [
                    TextFormField(
                      initialValue: bookDetails[index].author,
                      decoration: const InputDecoration(labelText: 'Author'),
                      onChanged: (value) {
                        setState(() {
                          bookDetails[index].author = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: bookDetails[index].publishedDate,
                      decoration:
                          const InputDecoration(labelText: 'Published Date'),
                      readOnly: true,
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light().copyWith(
                                  primary: Colors.blue,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null) {
                          setState(() {
                            bookDetails[index].publishedDate =
                                pickedDate.toString().split(' ')[0];
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: bookDetails[index].genre,
                      decoration: const InputDecoration(labelText: 'Genre'),
                      onChanged: (value) {
                        setState(() {
                          bookDetails[index].genre = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: bookDetails[index].description,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      onChanged: (value) {
                        setState(() {
                          bookDetails[index].description = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editBook(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteBook(index),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBook,
        tooltip: 'Add Book',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BookDetail {
  String id;
  String author;
  String publishedDate;
  String genre;
  String description;

  BookDetail({
    this.id = '',
    this.author = '',
    this.publishedDate = '',
    this.genre = '',
    this.description = '',
  });
}

class AddBookDialog extends StatefulWidget {
  final Function(String, String, String, String) onBookAdded;

  const AddBookDialog({Key? key, required this.onBookAdded}) : super(key: key);

  @override
  _AddBookDialogState createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _author;
  late String _publishedDate;
  late String _genre;
  late String _description;

  @override
  void initState() {
    super.initState();
    _author = '';
    _publishedDate = '';
    _genre = '';
    _description = '';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onBookAdded(_author, _genre, _publishedDate, _description);
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: Colors.blue,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        _publishedDate = pickedDate.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Book'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            const SizedBox(height: 8),
            TextFormField(
              readOnly: true,
              controller: TextEditingController(text: _publishedDate),
              decoration: const InputDecoration(labelText: 'Published Date'),
              onTap: () => _pickDate(context),
            ),
            const SizedBox(height: 8),
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
            const SizedBox(height: 8),
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class EditBookDialog extends StatefulWidget {
  final BookDetail initialBook;
  final Function(String, String, String, String) onBookUpdated;

  const EditBookDialog({
    Key? key,
    required this.initialBook,
    required this.onBookUpdated,
  }) : super(key: key);

  @override
  _EditBookDialogState createState() => _EditBookDialogState();
}

class _EditBookDialogState extends State<EditBookDialog> {
  late TextEditingController _authorController;
  late TextEditingController _publishedDateController;
  late TextEditingController _genreController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _authorController = TextEditingController(text: widget.initialBook.author);
    _publishedDateController =
        TextEditingController(text: widget.initialBook.publishedDate);
    _genreController = TextEditingController(text: widget.initialBook.genre);
    _descriptionController =
        TextEditingController(text: widget.initialBook.description);
  }

  @override
  void dispose() {
    _authorController.dispose();
    _publishedDateController.dispose();
    _genreController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final String author = _authorController.text;
    final String publishedDate = _publishedDateController.text;
    final String genre = _genreController.text;
    final String description = _descriptionController.text;

    widget.onBookUpdated(author, genre, publishedDate, description);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Book'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _authorController,
              decoration: const InputDecoration(labelText: 'Author'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _publishedDateController,
              decoration: const InputDecoration(labelText: 'Published Date'),
              readOnly: true,
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: ColorScheme.light().copyWith(
                          primary: Colors.blue,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (pickedDate != null) {
                  setState(() {
                    _publishedDateController.text =
                        pickedDate.toString().split(' ')[0];
                  });
                }
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _genreController,
              decoration: const InputDecoration(labelText: 'Genre'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
