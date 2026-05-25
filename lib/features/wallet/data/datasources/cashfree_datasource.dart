import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart'
    as cf;
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfpayment.dart';

class CashfreeDataSource {
  final cfPaymentGatewayService = CFPaymentGatewayService();

  void init({
    required Function(String) onSuccess,
    required Function(CFErrorResponse, String) onFailure,
  }) {
    cfPaymentGatewayService.setCallback(onSuccess, onFailure);
  }

  void startPayment({
    required String paymentSessionId,
    required String orderId,
  }) {
    try {
      print('(((((((((((((((((((((((((((((((((((((((((object)))))))))))))))))))))))))))))))))))))))))');
      print(paymentSessionId);
      print(orderId);
      var session = CFSessionBuilder()
          .setEnvironment(CFEnvironment.PRODUCTION)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();
      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#2D7FB8")
          .build();
      var dropCheckoutPayment = CFDropCheckoutPaymentBuilder()
          .setSession(session)
          .setTheme(theme)
          .build();
      cfPaymentGatewayService.doPayment(dropCheckoutPayment);
    } catch (e) {
      print("failed");
      print(
        "_______________________++++++++++++++++++++++________________________",
      );
      print(e);
      rethrow;
    }
  }
}
