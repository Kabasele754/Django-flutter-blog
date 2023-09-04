import 'package:flutter/material.dart';

import '../apis/blog.apis.dart';
import '../model/blog.model.dart';
import 'blog.create.page.dart';
import 'blog_detail.page.dart';

class BlogListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blogs')),
      body: FutureBuilder<List<Blog>>(
        future: fetchBlogs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final blog = snapshot.data![index];
                return ListTile(
                  title: Container(
                    child: Card(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Image.network(
                                blog.image!,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    blog.titre!,
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.blue),
                                  ),
                                  Text(blog.description!),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BlogDetailsScreen(
                                            id: blog.id!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Voir plus",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                  // Text(blog.titre!),
                  // subtitle: Text(blog.description!),
                  // leading: Image.network(blog.image!),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateBlogScreen()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
