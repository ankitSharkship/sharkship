abstract class PhonePeRepository {
  Future<Map<String, dynamic>?> startPayment({
    required String request,
    required String flowId,
  });
}
