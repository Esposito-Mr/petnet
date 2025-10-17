class Pet {
  final String id;
  final String name;
  final String imageUrl;
  final String associationName;
  final String location;
  final String gender;
  final bool isFavorite;

  const Pet({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.associationName,
    required this.location,
    required this.gender,
    this.isFavorite = false,
  });
}