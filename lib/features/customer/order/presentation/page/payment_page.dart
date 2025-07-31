import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class PayPalDemo extends StatelessWidget {
  const PayPalDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PayPal Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => PaypalCheckoutView(
                  sandboxMode: true,
                  clientId: dotenv.env["PAYPAL_CLIENT_ID"]!,
                  secretKey: "", // Có thể bỏ qua nếu không dùng server
                  transactions: const [
                    {
                      "amount": {
                        "total": '10',
                        "currency": 'USD',
                        "details": {
                          "subtotal": '10',
                          "shipping": '0',
                          "shipping_discount": 0
                        }
                      },
                      "description": "Mua sản phẩm công nghệ",
                      "item_list": {
                        "items": [
                          {
                            "name": "Tai nghe Bluetooth",
                            "quantity": 1,
                            "price": '10',
                            "currency": 'USD'
                          }
                        ],
                      }
                    }
                  ],
                  note: "Cảm ơn bạn đã mua hàng!",
                  onSuccess: (Map params) {
                    debugPrint("Payment success: $params");
                    // Helper.showToastBottom(
                    //     message: "Thanh toán thành công",
                    //     type: ToastType.success);
                    // Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    debugPrint("Payment canceled");
                    Navigator.pop(context);
                  },
                  onError: (error) {
                    debugPrint("Payment error: $error");
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
          child: const Text('Thanh toán PayPal'),
        ),
      ),
    );
  }
}
