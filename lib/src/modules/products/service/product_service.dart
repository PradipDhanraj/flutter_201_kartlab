abstract class ProductService {
  dynamic getProductList();
}

class ProductServiceImplementation extends ProductService {
  @override
  getProductList() {
    throw UnimplementedError();
  }
}
