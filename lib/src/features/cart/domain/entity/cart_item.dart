class CartItem {
  final int productId;
  final String title;
  final String image;
  final double price;
  final int quantity;

  CartItem({
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
  });

  CartItem copyWith({int? quantity}) => CartItem(
    productId: productId,
    title: title,
    image: image,
    price: price,
    quantity: quantity ?? this.quantity,
  );
}
