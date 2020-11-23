class ItemSize {
  ItemSize.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  // verificar se temos stock

  bool get hasStock => stock > 0;

  String name;
  num price;
  int stock;

  @override
  String toString() {
    return 'ItemSize{name: $name, price $price, stock: $stock}';
  }
}
