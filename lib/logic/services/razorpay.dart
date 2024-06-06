import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayServices {
  static final _instance = Razorpay();

  static Future<void> checkoutOrder(
    String name,
    contact,
    double amount, {
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
  }) async {
    var options = {
      'key': 'rzp_test_PmKjpbGJZo2i1Z',
      'amount': amount.toInt(),
      'name': name,
      'prefill': {'contact': contact, 'email': 'test@razorpay.com'}
    };
    _instance.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      onSuccess(response);
      _instance.clear();
    });
    _instance.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      onFailure(response);
      _instance.clear();
    });
    _instance.open(options);
  }
}
