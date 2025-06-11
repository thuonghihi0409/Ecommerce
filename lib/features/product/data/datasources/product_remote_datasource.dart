import 'package:thuongmaidientu/features/product/data/models/product_detail_model.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<ListModel<ProductModel>> getListProduct();
  Future<ProductDetailModel> getProductDetail();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDatasource {
  ProductRemoteDataSourceImpl();

  @override
  Future<ListModel<ProductModel>> getListProduct() async {
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
          "productId": "1",
          "storeId": "101",
          "cover":
              "https://hdhaihung.com/uploaded/Tin-Tuc/2021/thiet-bi-hoi-nghi-truyen-hinh.png",
          "categoryId": "201",
          "brandId": "301",
          "productName": "Laptop Acer Nitro 5",
          "description": "Gaming laptop mạnh mẽ",
          "createdAt": "2024-06-01T10:00:00Z",
          "updatedAt": "2024-06-05T12:00:00Z",
          "price": 12.1
        },
        {
          "productId": "2",
          "storeId": "102",
          "cover":
              "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
          "categoryId": "202",
          "brandId": "302",
          "productName": "iPhone 15 Pro Max",
          "description": "Điện thoại cao cấp từ Apple",
          "createdAt": "2024-06-02T09:30:00Z",
          "updatedAt": "2024-06-05T13:00:00Z",
          "price": 20.0
        },
        {
          "productId": "3",
          "storeId": "103",
          "cover":
              "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
          "categoryId": "203",
          "brandId": "303",
          "productName": "Samsung Galaxy S24 Ultra",
          "description": "Flagship Android mạnh nhất",
          "createdAt": "2024-06-03T11:00:00Z",
          "updatedAt": "2024-06-05T14:00:00Z",
          "price": 25.0
        },
        {
          "productId": "4",
          "cover":
              "https://boba.vn/static/san-pham/phu-kien-cong-nghe/thiet-bi-cong-nghe/kinh-thuc-te-ao/kinh-thuc-te-ao-oculus-go-64gb-2018/kinh-thuc-.jpg",
          "storeId": "104",
          "categoryId": "204",
          "brandId": "304",
          "productName": "AirPods Pro 2",
          "description": "Tai nghe không dây chống ồn",
          "createdAt": "2024-06-04T12:00:00Z",
          "updatedAt": "2024-06-05T15:00:00Z",
          "price": 15.0
        },
        {
          "productId": "5",
          "storeId": "105",
          "cover":
              "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          "categoryId": "205",
          "brandId": "305",
          "productName": "Apple Watch Series 9",
          "description": "Đồng hồ thông minh đa năng",
          "createdAt": "2024-06-05T08:00:00Z",
          "updatedAt": "2024-06-05T16:00:00Z",
          "price": 30.0
        }
      ]
    };
    // if (response.statusCode == 200) {
    //   return ProductModel.fromJson(response.data);
    // } else {
    //   throw Exception('Login failed');
    // }
    return ListModel.fromJson(data, (json) => ProductModel.fromJson(json));
  }

  @override
  Future<ProductDetailModel> getProductDetail() async {
    final data = {
      "productId": "p001",
      "productName": "Laptop Gaming MSI",
      "description": "Laptop chuyên game hiệu năng cao",
      "price": 2499.99,
      "storeId": "s001",
      "categoryId": "c001",
      "createdAt": "2024-12-01T10:30:00.000Z",
      "updatedAt": "2025-01-15T14:45:00.000Z",
      "images": [
        {
          "id": "img001",
          "url": "https://example.com/images/laptop_front.jpg",
          "alt": "Laptop góc trước"
        },
        {
          "id": "img002",
          "url": "https://example.com/images/laptop_side.jpg",
          "alt": "Laptop góc nghiêng"
        }
      ],
      "variants": [
        {
          "id": "v001",
          "name": "RAM 16GB / SSD 512GB",
          "price": 2499.99,
          "stock": 10
        },
        {
          "id": "v002",
          "name": "RAM 32GB / SSD 1TB",
          "price": 2999.99,
          "stock": 5
        }
      ]
    };
    return ProductDetailModel.fromJson(data);
  }
}
