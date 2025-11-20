
class Supplier {
  final String id;
  final String name;
  final String? location;
  final String? phone;
  final double? rating;
  final List<String> crops;
  final Map<String, dynamic>? prices;

  Supplier({
    required this.id,
    required this.name,
    this.location,
    this.phone,
    this.rating,
    required this.crops,
    this.prices,
  });

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      phone: map['phone'],
      rating: map['rating'] != null
          ? double.tryParse(map['rating'].toString())
          : null,
      crops: map['crops'] != null ? List<String>.from(map['crops']) : [],
      prices: map['prices'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'phone': phone,
      'rating': rating,
      'crops': crops,
      'prices': prices,
    };
  }
}
