class ApiRoutes {
  static String login = "/user-auth/login";
  static String register = "/user-auth/register";
  static String logOut = "/user-auth/logout";
  static String getProduct = "/app/get-products";
  static String createProduct = "/app/create-product";
  static String getOrders = "/app/get-orders";
  static String createOrder = "/app/create-order";

  static String getOrderDetails(String id) => "/app/get-order-details/$id";
}
