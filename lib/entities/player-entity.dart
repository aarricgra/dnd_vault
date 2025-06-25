// ignore: file_names
class PlayerEntity {
  final String shortName;     // ← viene del ID del documento
  final String fullName;      // ← viene de 'name' en el documento
  final String image;
  final String portrait;
  final int age;
  final String race;
  final String background;

  PlayerEntity({
    required this.shortName,
    required this.fullName,
    required this.image,
    required this.age,
    required this.race,
    required this.background,
    required this.portrait
  });

  factory PlayerEntity.fromMap(Map<String, dynamic> data, String id) {
    return PlayerEntity(
      shortName: id,
      fullName: data['name'] ?? '',
      image: data['image'] ?? '',
      portrait: data['portrait'] ?? '',
      age: data['age'] ?? 0,
      race: data['race'] ?? '',
      background: data['background'] ?? '',
    );
  }
}
