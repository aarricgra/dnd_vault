// ignore: file_names
class CharacterEntity {
  final String name;    
  final String title;    
  final String image;
  final String portrait;
  final String lore;

  CharacterEntity({
    required this.name,
    required this.title,
    required this.image,
    required this.lore,
    required this.portrait
  });

  factory CharacterEntity.fromMap(Map<String, dynamic> data) {
    return CharacterEntity(
      name: data['name'] ?? '',
      title: data['title'] ?? '',
      image: data['image'] ?? '',
      portrait: data['portrait'] ?? '',
      lore: data['lore'] ?? '',
    );
  }
}
