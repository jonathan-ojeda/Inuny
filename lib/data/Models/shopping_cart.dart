class CartItem {
  final int id;
  final String title;
  final double price;
  int quantity;
  int selectedQuantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    this.selectedQuantity = 0,
  });

  void setQuantity(int newQuantity) {
    quantity = newQuantity;
  }
}
