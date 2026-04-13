import 'dart:io';

import '../../domain/repositories/orders_repository.dart';
import '../../domain/entities/orders_response_entity.dart';
import '../../domain/entities/order_address_entity.dart';
import '../../domain/entities/courier_rate_entity.dart';
import '../../domain/entities/courier_priority_entity.dart';
import '../../domain/entities/courier_partner_entity.dart';
import '../datasources/orders_datasource.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersDataSource dataSource;

  OrdersRepositoryImpl(this.dataSource);

  @override
  Future<OrdersResponseEntity> getOrders(OrderListParams params) async {
    return await dataSource.getOrders(params);
  }

  @override
  Future<List<OrderAddressEntity>> getPickupAddresses() async {
    return await dataSource.getPickupAddresses();
  }

  @override
  Future<bool> setDefaultPickupAddress(int id) async {
    return await dataSource.patchDefaultPickupAddress(id);
  }

  @override
  Future<ShippingRateResponseEntity> getShippingRates(
    ShippingRateParams params,
  ) async {
    return await dataSource.getShippingRates(params);
  }

  @override
  Future<bool> createOrder(CreateOrderParams params) async {
    return await dataSource.createOrder(params);
  }

  @override
  Future<void> downloadTemplate() async {
    return await dataSource.downloadTemplate();
  }

  @override
  Future<bool> handleBulkUpload(File file) async {
    return await dataSource.handleBulkUpload(file);
  }

  @override
  Future<Map<String, dynamic>> deleteOrders(
    Map<String, dynamic> orderIds,
  ) async {
    return await dataSource.deleteOrders(orderIds);
  }

  @override
  Future<Map<String, dynamic>> shipOrders(Map<String, dynamic> orderIds) async {
    return await dataSource.shipOrders(orderIds);
  }

  @override
  Future<void> exportOrders(List<int> orderIds) async {
    return await dataSource.exportOrders(orderIds);
  }

  @override
  Future<CourierPriorityEntity> getCourierPriority() async {
    return await dataSource.getCourierPriority();
  }

  @override
  Future<bool> updateCourierPriority(Map<String, dynamic> data) async {
    return await dataSource.putCourierPriority(data);
  }

  @override
  Future<List<CourierPartnerEntity>> getCourierPartners() async {
    return await dataSource.getCourierPartners();
  }

  @override
  Future<Map<String, dynamic>> editOrder(int id, Map<String, dynamic> data) {
    return dataSource.editOrder(id, data);
  }
  
  @override
  Future<void> downloadShippingLabel(List<int> orderIds) {
    return dataSource.downloadShippingLabel(orderIds);
  }

  @override
  Future<void> updateInvoiceConfiguration(Map<String, dynamic> config) {
    return dataSource.updateInvoiceConfiguration(config);
  }

  @override
  Future<void> downloadOrderInvoice(List<int> orderIds) {
    return dataSource.downloadOrderInvoice(orderIds);
  }

  @override
  Future<void> generateManifestation(List<int> orderIds) {
    return dataSource.generateManifestation(orderIds);
  }

  @override
  Future<void> cancelOrders(List<int> orderIds) {
    return dataSource.cancelOrders(orderIds);
  }

  @override
  Future<void> cloneOrder(int id) {
    return dataSource.cloneOrder(id);
  }
}
