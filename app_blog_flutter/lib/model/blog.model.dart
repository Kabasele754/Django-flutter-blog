class Blog {
  final int? id;
  final String? titre;
  final String? description;
  final String? image;
  // final int auteur;

  Blog({this.id, this.titre, this.description, this.image});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      titre: json['titre'],
      description: json['description'],
      image: json['image'],
      // auteur: json['auteur'],
    );
  }

  Map<String, dynamic> toJson() => {
        'titre': titre,
        'description': description,
        'image': image,
        // 'auteur': auteur,
      };
}
