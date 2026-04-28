class ApiEndpoints {
  const ApiEndpoints._();

  static const String baseUrl = 'https://fakestoreapi.com';

  // Products
  static const String products = '/products';

  static String productById(int id) => '/products/$id';
}
