import 'dart:io';
import 'package:app_blog_flutter/apis/blog.apis.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateBlogScreen extends StatefulWidget {
  @override
  _CreateBlogScreenState createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _titre;
  String? _description;
  File? _image;
  // int _auteur;
  bool _flag = true;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Blog')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Titre',
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _titre = value,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value,
              ),
              SizedBox(
                height: 19,
              ),
              Row(
                children: [
                  Expanded(
                    child: _image == null
                        ? ElevatedButton(
                            child: Text('Select Image'),
                            onPressed: () => _pickImage(ImageSource.gallery),
                          )
                        : Image.file(_image!),
                  ),
                  SizedBox(width: 19),
                  ElevatedButton(
                    child: Text('Take Photo'),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                ],
              ),

              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Author ID'),
              //   keyboardType: TextInputType.number,
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter an author ID';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) => _auteur = int.parse(value),
              // ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _flag
                      ? Colors.blue
                      : Colors.teal, // This is what you need!
                ),
                child: Text(
                  _flag ? 'Creer' : 'Green',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      final blog =
                          await createBlog(_titre!, _description!, _image!);
                      Navigator.pop(context, blog);
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
