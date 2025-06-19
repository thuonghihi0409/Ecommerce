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
            "rating_average": 4.5,
            "total_products": 128
          },
          "product_item": [
            {
              "product_detail": {
                "product_id": "p001",
                "product_name": "Laptop Gaming MSI",
                "description": "Laptop chuyên game hiệu năng cao",
                "price": 2499.99,
                "store_id": "s001",
                "category_id": "c001",
                "created_at": "2024-12-01T10:30:00.000Z",
                "updated_at": "2025-01-15T14:45:00.000Z",
                "avg_rating": 4.8,
                "total_sold": 11000,
                "total_rating": 210,
                "images": [
                  {
                    "id": "img001",
                    "url":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                    "alt": "Laptop góc trước"
                  },
                  {
                    "id": "img002",
                    "url":
                        "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
                    "alt": "Laptop góc nghiêng"
                  }
                ],
                "variants": [
                  {
                    "id": "v001",
                    "name": "RAM 16GB / SSD 512GB",
                    "price": 2499.99,
                    "stock": 10,
                    "cover":
                        "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
                  },
                  {
                    "id": "v002",
                    "name": "RAM 32GB / SSD 1TB",
                    "price": 505000,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v002",
                    "name": "RAM 16GB / SSD 1TB",
                    "price": 299999,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v003",
                    "name": "RAM 32GB / SSD 1TB",
                    "price": 295000,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v004",
                    "name": "RAM 16GB / SSD 0.5TB",
                    "price": 1299999,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v005",
                    "name": "RAM 32GB / SSD 0.5TB",
                    "price": 2999344,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  }
                ]
              },
              "variant": {
                "id": "variant_1",
                "name": "Màu đen",
                "price": 550000,
                "cover":
                    "https://gongangshop.vn/wp-content/uploads/2024/07/Loa-bluetooth-phi-hanh-gia.webp"
              },
              "number": 2
            },
            {
              "product_detail": {
                "product_id": "p001",
                "product_name": "Laptop Gaming MSI",
                "description": "Laptop chuyên game hiệu năng cao",
                "price": 2499.99,
                "store_id": "s001",
                "category_id": "c001",
                "created_at": "2024-12-01T10:30:00.000Z",
                "updated_at": "2025-01-15T14:45:00.000Z",
                "avg_rating": 4.8,
                "total_sold": 11000,
                "total_rating": 210,
                "images": [
                  {
                    "id": "img001",
                    "url":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                    "alt": "Laptop góc trước"
                  },
                  {
                    "id": "img002",
                    "url":
                        "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
                    "alt": "Laptop góc nghiêng"
                  }
                ],
                "variants": [
                  {
                    "id": "v001",
                    "name": "RAM 16GB / SSD 512GB",
                    "price": 2499.99,
                    "stock": 10,
                    "cover":
                        "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
                  },
                  {
                    "id": "v002",
                    "name": "RAM 32GB / SSD 1TB",
                    "price": 505000,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v002",
                    "name": "RAM 16GB / SSD 1TB",
                    "price": 299999,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v003",
                    "name": "RAM 32GB / SSD 1TB",
                    "price": 295000,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v004",
                    "name": "RAM 16GB / SSD 0.5TB",
                    "price": 1299999,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v005",
                    "name": "RAM 32GB / SSD 0.5TB",
                    "price": 2999344,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  }
                ]
              },
              "variant": {
                "id": "variant_2",
                "name": "Màu trắng",
                "price": 320000,
                "cover":
                    "https://thanhnien.mediacdn.vn/uploaded/thuthao/2018_11_10/14_ZHRV.jpg?width=500",
              },
              "number": 1
            }
          ]
        },
        {
          "store": {
            "id": "store_001",
            "name": "Cửa hàng công nghệ",
            "logo": "https://example.com/logo.png",
            "address": "123 Đường ABC, Quận 1, TP.HCM",
            "rating_average": 4.5,
            "total_products": 128
          },
          "product_item": [
            {
              "product_detail": {
                "product_id": "p001",
                "product_name": "Laptop Gaming MSI",
                "description": "Laptop chuyên game hiệu năng cao",
                "price": 2499.99,
                "store_id": "s001",
                "category_id": "c001",
                "created_at": "2024-12-01T10:30:00.000Z",
                "updated_at": "2025-01-15T14:45:00.000Z",
                "avg_rating": 4.8,
                "total_sold": 11000,
                "total_rating": 210,
                "images": [
                  {
                    "id": "img001",
                    "url":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                    "alt": "Laptop góc trước"
                  },
                  {
                    "id": "img002",
                    "url":
                        "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
                    "alt": "Laptop góc nghiêng"
                  }
                ],
                "variants": [
                  {
                    "id": "v001",
                    "name": "RAM 16GB / SSD 512GB",
                    "price": 2499.99,
                    "stock": 10,
                    "cover":
                        "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
                  },
                  {
                    "id": "v002",
                    "name": "RAM 32GB / SSD 1TB",
                    "price": 505000,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v002",
                    "name": "RAM 16GB / SSD 1TB",
                    "price": 299999,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v003",
                    "name": "RAM 32GB / SSD 1TB",
                    "price": 295000,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v004",
                    "name": "RAM 16GB / SSD 0.5TB",
                    "price": 1299999,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v005",
                    "name": "RAM 32GB / SSD 0.5TB",
                    "price": 2999344,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  }
                ]
              },
              "variant": {
                "id": "variant_1",
                "name": "Màu đen",
                "price": 550000,
                "cover":
                    "https://gongangshop.vn/wp-content/uploads/2024/07/Loa-bluetooth-phi-hanh-gia.webp"
              },
              "number": 2
            },
            {
              "product_detail": {
                "product_id": "p001",
                "product_name": "Laptop Gaming MSI",
                "description": "Laptop chuyên game hiệu năng cao",
                "price": 2499.99,
                "store_id": "s001",
                "category_id": "c001",
                "created_at": "2024-12-01T10:30:00.000Z",
                "updated_at": "2025-01-15T14:45:00.000Z",
                "avg_rating": 4.8,
                "total_sold": 11000,
                "total_rating": 210,
                "images": [
                  {
                    "id": "img001",
                    "url":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                    "alt": "Laptop góc trước"
                  },
                  {
                    "id": "img002",
                    "url":
                        "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
                    "alt": "Laptop góc nghiêng"
                  }
                ],
                "variants": [
                  {
                    "id": "v001",
                    "name": "RAM 16GB / SSD 512GB",
                    "price": 2499.99,
                    "stock": 10,
                    "cover":
                        "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
                  },
                  {
                    "id": "v002",
                    "name": "RAM 32GB / SSD 1TB",
                    "price": 505000,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v002",
                    "name": "RAM 16GB / SSD 1TB",
                    "price": 299999,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v003",
                    "name": "RAM 32GB / SSD 1TB",
                    "price": 295000,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v004",
                    "name": "RAM 16GB / SSD 0.5TB",
                    "price": 1299999,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v005",
                    "name": "RAM 32GB / SSD 0.5TB",
                    "price": 2999344,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  }
                ]
              },
              "variant": {
                "id": "variant_2",
                "name": "Màu trắng",
                "price": 320000,
                "cover":
                    "https://thanhnien.mediacdn.vn/uploaded/thuthao/2018_11_10/14_ZHRV.jpg?width=500",
              },
              "number": 1
            }
          ]
        },
        {
          "store": {
            "id": "store_001",
            "name": "Cửa hàng công nghệ",
            "logo": "https://example.com/logo.png",
            "address": "123 Đường ABC, Quận 1, TP.HCM",
            "rating_average": 4.5,
            "total_products": 128
          },
          "product_item": [
            {
              "product_detail": {
                "product_id": "p001",
                "product_name": "Laptop Gaming MSI",
                "description": "Laptop chuyên game hiệu năng cao",
                "price": 2499.99,
                "store_id": "s001",
                "category_id": "c001",
                "created_at": "2024-12-01T10:30:00.000Z",
                "updated_at": "2025-01-15T14:45:00.000Z",
                "avg_rating": 4.8,
                "total_sold": 11000,
                "total_rating": 210,
                "images": [
                  {
                    "id": "img001",
                    "url":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                    "alt": "Laptop góc trước"
                  },
                  {
                    "id": "img002",
                    "url":
                        "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
                    "alt": "Laptop góc nghiêng"
                  }
                ],
                "variants": [
                  {
                    "id": "v001",
                    "name": "RAM 16GB / SSD 512GB",
                    "price": 2499.99,
                    "stock": 10,
                    "cover":
                        "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
                  },
                  {
                    "id": "v002",
                    "name": "RAM 32GB / SSD 1TB",
                    "price": 505000,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v002",
                    "name": "RAM 16GB / SSD 1TB",
                    "price": 299999,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v003",
                    "name": "RAM 32GB / SSD 1TB",
                    "price": 295000,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v004",
                    "name": "RAM 16GB / SSD 0.5TB",
                    "price": 1299999,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v005",
                    "name": "RAM 32GB / SSD 0.5TB",
                    "price": 2999344,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  }
                ]
              },
              "variant": {
                "id": "variant_1",
                "name": "Màu đen",
                "price": 550000,
                "cover":
                    "https://gongangshop.vn/wp-content/uploads/2024/07/Loa-bluetooth-phi-hanh-gia.webp"
              },
              "number": 2
            },
            {
              "product_detail": {
                "product_id": "p001",
                "product_name": "Laptop Gaming MSI",
                "description": "Laptop chuyên game hiệu năng cao",
                "price": 2499.99,
                "store_id": "s001",
                "category_id": "c001",
                "created_at": "2024-12-01T10:30:00.000Z",
                "updated_at": "2025-01-15T14:45:00.000Z",
                "avg_rating": 4.8,
                "total_sold": 11000,
                "total_rating": 210,
                "images": [
                  {
                    "id": "img001",
                    "url":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                    "alt": "Laptop góc trước"
                  },
                  {
                    "id": "img002",
                    "url":
                        "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
                    "alt": "Laptop góc nghiêng"
                  }
                ],
                "variants": [
                  {
                    "id": "v001",
                    "name": "RAM 16GB / SSD 512GB",
                    "price": 2499.99,
                    "stock": 10,
                    "cover":
                        "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
                  },
                  {
                    "id": "v002",
                    "name": "RAM 32GB / SSD 1TB",
                    "price": 505000,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v002",
                    "name": "RAM 16GB / SSD 1TB",
                    "price": 299999,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v003",
                    "name": "RAM 32GB / SSD 1TB",
                    "price": 295000,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v004",
                    "name": "RAM 16GB / SSD 0.5TB",
                    "price": 1299999,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  },
                  {
                    "id": "v005",
                    "name": "RAM 32GB / SSD 0.5TB",
                    "price": 2999344,
                    "stock": 5,
                    "cover":
                        "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
                  }
                ]
              },
              "variant": {
                "id": "variant_2",
                "name": "Màu trắng",
                "price": 320000,
                "cover":
                    "https://thanhnien.mediacdn.vn/uploaded/thuthao/2018_11_10/14_ZHRV.jpg?width=500",
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
