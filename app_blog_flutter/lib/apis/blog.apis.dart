import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import '../model/blog.model.dart';

Future<Blog> createBlog(
    String titre, String description, File imageFile) async {
  final request = http.MultipartRequest(
      'POST', Uri.parse('https://achille.pythonanywhere.com/blogs/'))
    ..fields['titre'] = titre
    ..fields['description'] = description
    // ..fields['auteur'] = auteur.toString()
    ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));
  final response = await request.send();
  if (response.statusCode == 201) {
    final json = jsonDecode(await response.stream.bytesToString());
    return Blog.fromJson(json);
  } else {
    throw Exception('Failed to create blog');
  }
}

// List of blog

Future<List<Blog>> fetchBlogs() async {
  List<Blog> blogs = [];
  var url = Uri.parse("https://achille.pythonanywhere.com/blogs/");
  var response = await http.get(
    url,
  );

  print(response.statusCode);
  print("Voir blogs ${response.body.toString()}");

  if (response.statusCode == 200) {
    var jsons = jsonDecode(response.body);
    print("Je peux voir ca ${jsons}");
    for (var json in jsons['data']) {
      print("Je suis dans le blogs ${json}");

      blogs.add(Blog.fromJson(json));
      print("Apre add blogs okk $blogs");
    }
  }
  return blogs;
}

// get one blog

Future<Blog> fetchBlogDetails(int id) async {
  var url = Uri.parse("https://achille.pythonanywhere.com/blogs/$id");
  var response = await http.get(
    url,
  );
  if (response.statusCode == 200) {
    // Si la requête réussit, renvoyer les détails du blog récupérés
    // print("Voir blogs ${response.body.toString()}");
    var jsons = jsonDecode(response.body);
    // print(Blog.fromJson(json.decode(response.body)));
    return Blog.fromJson(jsons['data']);
  } else {
    // Sinon, lancer une exception
    throw Exception('Failed to fetch blog details');
  }
}

// effacer un blog

// Future<void> deleteBlog(int id) async {
//   var url = Uri.parse("https://achille.pythonanywhere.com/blogs/$id");
//   var response = await http.delete(
//     url,
//   );
//   print("voir url $url");
//   print("voir blog delete $id");
//   if (response.statusCode != 204) {
//     // Si la requête échoue, lancer une exception
//     throw Exception('Failed to delete blog');
//   }
// }

Future<void> deleteBlog(int id) async {
  final response = await http
      .delete(Uri.parse('https://achille.pythonanywhere.com/blogs/$id'));

  if (response.statusCode == 200) {
    fetchBlogs();
  } else {
    throw Exception('Failed to delete data');
  }
}

class HttpService {
  final String postsURL = "https://achille.pythonanywhere.com/blogs/";

  // ...

  Future deletePost(int id) async {
    Response res = await http
        .delete(Uri.parse('https://achille.pythonanywhere.com/blogs/$id'));

    if (res.statusCode == 200) {
      print("Deleted");
    } else {
      throw "Sorry! Unable to delete this post.";
    }
  }
}
