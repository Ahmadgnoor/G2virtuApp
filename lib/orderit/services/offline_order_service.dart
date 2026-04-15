import 'dart:convert';
import 'package:orderit/locators/locator.dart';
import 'package:orderit/common/services/offline_storage_service.dart';
import 'package:orderit/orderit/models/sales_order_model.dart';
import 'package:orderit/orderit/services/cart_service.dart';

class OfflineOrderService {
  Future saveOfflineOrder(SalesOrderModel order) async {
    var data = locator.get<OfflineStorage>().getItem('offline_orders');

    List orders = [];

    if (data['data'] != null) {
      orders = jsonDecode(data['data']);
    }

    orders.add(order.toJson());

    await locator
        .get<OfflineStorage>()
        .putItem('offline_orders', jsonEncode(orders));
  }

  Future syncOfflineOrders() async {
    var storage = locator.get<OfflineStorage>();

    var data = storage.getItem('offline_orders');

    if (data['data'] == null) return;

    List orders = jsonDecode(data['data']);

    if (orders.isEmpty) return;
    print("Offline Orders Before Sync: ${orders.length}");
    var cartService = locator.get<CartService>();

    var remainingOrders = [];

    for (var element in orders) {
      var order = SalesOrderModel.fromJson(element);

      var result = await cartService.postSalesOrder(order, isOffline: true);

      if (!result) {
        remainingOrders.add(element);
      }
    }
    print("Before remove: ${storage.getItem('offline_orders')}");
    await storage.remove('offline_orders');
    print("After remove: ${storage.getItem('offline_orders')}");
  }
}
