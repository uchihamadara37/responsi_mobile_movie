class Food {
  int? id;
  String name;
  String? imagePath; // Path to the image file
  double price;
  String? origin;

  Food({
    this.id,
    required this.name,
    this.imagePath,
    required this.price,
    this.origin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image_path': imagePath,
      'price': price,
      'origin': origin,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'],
      name: map['name'],
      imagePath: map['image_path'],
      price: map['price'],
      origin: map['origin'],
    );
  }
}