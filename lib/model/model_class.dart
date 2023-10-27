class User {
  final int id;
  final String name;
  final String company;
  late final List photos;
  final String catchPhrase;
  final String bs;

  User({
    required this.id,
    required this.name,
    required this.company,
    required this.photos,
    required this.catchPhrase,
    required this.bs,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    company: json["company"]["name"] ?? "",
    photos: json["idontknow"] ?? [],
    catchPhrase: json["company"]["catchPhrase"] ?? "",
    bs: json["company"]["bs"] ?? "",
  );
}