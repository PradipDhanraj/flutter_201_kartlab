class ProductCategory {
  final String name;
  final int categoryId;
  ProductCategory(this.name, this.categoryId);
}

class ProductModel {
  final int productId;
  final int categoryId;
  final String name;
  final String imageUrl;
  final String desc;
  final bool wishList;
  final bool isLiked;
  final bool isInCart;
  ProductModel(
    this.productId,
    this.categoryId,
    this.name,
    this.imageUrl,
    this.desc, [
    this.wishList = false,
    this.isLiked = false,
    this.isInCart = false,
  ]);
}

class RegistryItem {
  final int id;
  final String evetName;
  final String desc;
  DateTime eventDate;
  RegistryItem(this.id, this.evetName, this.eventDate, this.desc);
}
