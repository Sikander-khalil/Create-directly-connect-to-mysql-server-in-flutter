class User {
  final int? id;
  String? name;


  User({ this.id,
    required this.name,
  });

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];


}