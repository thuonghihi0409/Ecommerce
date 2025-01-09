
class Product {
  String? id;
  String? name;
  String? description;
  String? material;
  final String brandId;
  String? genderId;
  int? discount;
  List<ColorItem>? colors;
  String? typeDetailsId;
  bool hidden;
  Product({
    this.id,
    this.name,
    this.description,
    this.material,
    required this.brandId,
    this.genderId,
    this.discount,
    this.colors,
    this.typeDetailsId,
    required this.hidden,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      material: json['material'],
      brandId: json['brandId'],
      genderId: json['genderId'],
      discount: json['discount'],
      colors: json['colors'] != null
          ? List<ColorItem>.from(
          json['colors'].map((x) => ColorItem.fromJson(x)))
          : null,
      typeDetailsId: json['typeDetailsId'],
      hidden: json['hidden'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'material': material,
      'brandId': brandId,
      'genderId': genderId,
      'discount': discount,
      'colors': colors?.map((x) => x.toJson()).toList(),
      'typeDetailsId': typeDetailsId,
    };
  }
}

class ColorItem {
  String? id;
  String? productId;
  String? name;
  String? color;
  int? price;
  List<String>? images;
  List<Size>? sizes;

  ColorItem({
    this.id,
    this.productId,
    this.name,
    this.color,
    this.price,
    this.images,
    this.sizes,
  });

  factory ColorItem.fromJson(Map<String, dynamic> json) {
    return ColorItem(
      id: json['_id'],
      productId: json['productId'],
      name: json['name'],
      color: json['color'],
      price: json['price'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      sizes: json['sizes'] != null
          ? List<Size>.from(json['sizes'].map((x) => Size.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productId': productId,
      'name': name,
      'color': color,
      'price': price,
      'images': images,
      'sizes': sizes?.map((x) => x.toJson()).toList(),
    };
  }
}

class Size {
  String? id;
  String? name;
  int? quantity;

  Size({
    this.id,
    this.name,
    this.quantity,
  });

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      id: json['_id'],
      name: json['name'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'quantity': quantity,
    };
  }
}
