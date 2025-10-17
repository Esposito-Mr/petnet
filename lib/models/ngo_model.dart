class NGO {
  final String id;
  final String name;
  final String logoUrl;
  final DateTime lastActionTimestamp; // For sorting

  const NGO({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.lastActionTimestamp,
  });
}