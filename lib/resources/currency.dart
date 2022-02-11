class Currency {
  static final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  static String create({required int cents}) {
    return ("\$${(cents / 100).toStringAsFixed(2)}").replaceAllMapped(reg, (match) => '${match[1]},');
  }
}