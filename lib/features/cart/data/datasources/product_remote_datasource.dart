import 'package:thuongmaidientu/features/cart/data/models/cart_item_model.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class CartRemoteDatasource {
  Future<ListModel<CartItemModel>> getListCart();
}

class CartRemoteDataSourceImpl implements CartRemoteDatasource {
  CartRemoteDataSourceImpl();

  @override
  Future<ListModel<CartItemModel>> getListCart() async {
    // final response = await dio.post(
    //   '/login',
    //   data: {'email': email, 'password': password},
    // );

    final data = {
      "count": 5,
      "next": null,
      "previous": null,
      "results": [
        {
          "store": {
            "id": "store_001",
            "name": "Cửa hàng công nghệ",
            "logo": "https://example.com/logo.png",
            "address": "123 Đường ABC, Quận 1, TP.HCM",
            "ratingAverage": 4.5,
            "totalProducts": 128
          },
          "productItem": [
            {
              "productDetail": {
                "id": "product_123",
                "name": "Tai nghe Bluetooth X123",
                "description": "Chất lượng âm thanh cao, pin lâu",
                "price": 550000,
                "images": [
                  "https://example.com/images/1.jpg",
                  "https://example.com/images/2.jpg"
                ],
                "category": "Âm thanh"
              },
              "variant": {
                "id": "variant_1",
                "name": "Màu đen",
                "price": 550000,
                "cover": "https://example.com/images/variant_black.jpg"
              },
              "number": 2
            },
            {
              "productDetail": {
                "id": "product_456",
                "name": "Chuột gaming RGB",
                "description": "Đèn RGB, DPI điều chỉnh",
                "price": 320000,
                "images": ["https://example.com/images/mouse1.jpg"],
                "category": "Phụ kiện"
              },
              "variant": {
                "id": "variant_2",
                "name": "Màu trắng",
                "price": 320000,
                "cover": "https://example.com/images/variant_white.jpg"
              },
              "number": 1
            }
          ]
        }
      ]
    };
    // if (response.statusCode == 200) {
    //   return CartModel.fromJson(response.data);
    // } else {
    //   throw Exception('Login failed');
    // }
    return ListModel.fromJson(data, (json) => CartItemModel.fromJson(json));
  }
}
