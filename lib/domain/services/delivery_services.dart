import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bikeman/data/env/environment.dart';
import 'package:bikeman/data/local_secure/secure_storage.dart';
import 'package:bikeman/domain/models/response/get_all_delivery_response.dart';
import 'package:bikeman/domain/models/response/orders_by_status_response.dart';


class DeliveryServices {


  Future<List<Delivery>> getAlldelivery() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.endpointApi}/get-all-delivery'),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! }
    );

    return GetAllDeliveryResponse.fromJson(jsonDecode(resp.body)).delivery;
  }


  Future<List<OrdersResponse>> getOrdersForDelivery(String statusOrder) async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.endpointApi}/get-all-orders-by-delivery/$statusOrder'),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! }
    );

    return OrdersByStatusResponse.fromJson(jsonDecode(resp.body)).ordersResponse;
  }



}

final deliveryServices = DeliveryServices();
