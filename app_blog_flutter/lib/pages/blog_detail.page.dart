import 'package:flutter/material.dart';
import '../apis/blog.apis.dart';
import '../model/blog.model.dart';

class BlogDetailsScreen extends StatelessWidget {
  final int id;

  BlogDetailsScreen({required this.id});

  final HttpService httpService = HttpService();

  // void _deleteBlog(int id) async {
  //   // try {
  //     await deleteBlog(id);
  //     print(id);
  //     // Navigator.of(context).pop();
  //   // } catch (e) {
  //   //   // Afficher un message d'erreur s'il y a eu un problème lors de la suppression du blog
  //   //   ScaffoldMessenger.of(context)
  //   //       .showSnackBar(SnackBar(content: Text('Failed to delete blog')));
  //   //   print(id);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await httpService.deletePost(id);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: FutureBuilder<Blog>(
        future: fetchBlogDetails(id),
        builder: (BuildContext context, AsyncSnapshot<Blog> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Afficher l'indicateur de progression si la connexion est en cours
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Afficher un message d'erreur s'il y a eu un problème lors de la récupération des détails du blog
            return Text('Failed to fetch blog details');
          } else {
            // Afficher les détails du blog si ceux-ci ont été récupérés avec succès
            final blog = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Card(
                    child: Column(
                      children: [
                        Container(
                          child: Image.network(
                            blog.image!,
                          ),
                        ),
                        Text(
                          blog.titre!,
                          style: TextStyle(fontSize: 19, color: Colors.blue),
                        ),
                        Text(blog.description!),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteBlog(blog.id!);
                            // Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
