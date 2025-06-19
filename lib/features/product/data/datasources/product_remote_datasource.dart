import 'package:thuongmaidientu/features/product/data/models/category_model.dart';
import 'package:thuongmaidientu/features/product/data/models/product_detail_model.dart';
import 'package:thuongmaidientu/features/product/data/models/store_model.dart';
import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<ListModel<ProductModel>> getListProduct();
  Future<ProductDetailModel> getProductDetail();
  Future<Store> getStore();
  Future<List<ProductModel>> getListProductSummerice();
  Future<List<Category>> getListCategory();
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
          "product_id": "1",
          "store_id": "101",
          "cover":
              "https://hdhaihung.com/uploaded/Tin-Tuc/2021/thiet-bi-hoi-nghi-truyen-hinh.png",
          "category_id": "201",
          "brand_id": "301",
          "product_name": "Laptop Acer Nitro 5",
          "description": "Gaming laptop mạnh mẽ",
          "created_at": "2024-06-01T10:00:00Z",
          "updated_at": "2024-06-05T12:00:00Z",
          "price": 12,
          "avg_rating": 4.5,
          "total_sold": 10000
        },
        {
          "product_id": "2",
          "store_id": "102",
          "cover":
              "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
          "category_id": "202",
          "brand_id": "302",
          "product_name": "iPhone 15 Pro Max",
          "description": "Điện thoại cao cấp từ Apple",
          "created_at": "2024-06-02T09:30:00Z",
          "updated_at": "2024-06-05T13:00:00Z",
          "price": 20.0,
          "avg_rating": 4.2,
          "total_sold": 1040
        },
        {
          "product_id": "3",
          "store_id": "103",
          "cover":
              "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
          "category_id": "203",
          "brand_id": "303",
          "product_name": "Samsung Galaxy S24 Ultra",
          "description": "Flagship Android mạnh nhất",
          "created_at": "2024-06-03T11:00:00Z",
          "updated_at": "2024-06-05T14:00:00Z",
          "price": 25.0,
          "avg_rating": 4.9,
          "total_sold": 1520
        },
        {
          "product_id": "4",
          "cover":
              "https://boba.vn/static/san-pham/phu-kien-cong-nghe/thiet-bi-cong-nghe/kinh-thuc-te-ao/kinh-thuc-te-ao-oculus-go-64gb-2018/kinh-thuc-.jpg",
          "store_id": "104",
          "category_id": "204",
          "brand_id": "304",
          "product_name": "AirPods Pro 2",
          "description": "Tai nghe không dây chống ồn",
          "created_at": "2024-06-04T12:00:00Z",
          "updated_at": "2024-06-05T15:00:00Z",
          "price": 15.0,
          "avg_rating": 3.5,
          "total_sold": 100
        },
        {
          "product_id": "5",
          "store_id": "105",
          "cover":
              "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          "category_id": "205",
          "brand_id": "305",
          "product_name": "Apple Watch Series 9",
          "description": "Đồng hồ thông minh đa năng",
          "created_at": "2024-06-05T08:00:00Z",
          "updated_at": "2024-06-05T16:00:00Z",
          "price": 30.0,
          "avg_rating": 4.7,
          "total_sold": 10700
        },
        {
          "product_id": "5",
          "store_id": "105",
          "cover":
              "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          "category_id": "205",
          "brand_id": "305",
          "product_name": "Apple Watch Series 9",
          "description": "Đồng hồ thông minh đa năng",
          "created_at": "2024-06-05T08:00:00Z",
          "updated_at": "2024-06-05T16:00:00Z",
          "price": 30.0,
          "avg_rating": 4.7,
          "total_sold": 10700
        },
        {
          "product_id": "5",
          "store_id": "105",
          "cover":
              "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          "category_id": "205",
          "brand_id": "305",
          "product_name": "Apple Watch Series 9",
          "description": "Đồng hồ thông minh đa năng",
          "created_at": "2024-06-05T08:00:00Z",
          "updated_at": "2024-06-05T16:00:00Z",
          "price": 30.0,
          "avg_rating": 4.7,
          "total_sold": 10700
        },
        {
          "product_id": "5",
          "store_id": "105",
          "cover":
              "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          "category_id": "205",
          "brand_id": "305",
          "product_name": "Apple Watch Series 9",
          "description": "Đồng hồ thông minh đa năng",
          "created_at": "2024-06-05T08:00:00Z",
          "updated_at": "2024-06-05T16:00:00Z",
          "price": 30.0,
          "avg_rating": 4.7,
          "total_sold": 10700
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
    };
    return ProductDetailModel.fromJson(data);
  }

  @override
  Future<Store> getStore() async {
    final data = {
      "id": "store_01",
      "name": "Tech Shop",
      "logo_url":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/LEGO_logo.svg/768px-LEGO_logo.svg.png",
      "address": "123 Nguyễn Văn Linh, Quận 7, TP.HCM",
      "average_rating": 4.5,
      "total_products": 120,
    };

    return StoreModel.fromJson(data);
  }

  @override
  Future<List<ProductModel>> getListProductSummerice() async {
    // final response = await dio.post(
    //   '/login',
    //   data: {'email': email, 'password': password},
    // );

    final data = [
      {
        "product_id": "1",
        "store_id": "101",
        "cover":
            "https://hdhaihung.com/uploaded/Tin-Tuc/2021/thiet-bi-hoi-nghi-truyen-hinh.png",
        "category_id": "201",
        "brand_id": "301",
        "product_name": "Laptop Acer Nitro 5",
        "description": "Gaming laptop mạnh mẽ",
        "created_at": "2024-06-01T10:00:00Z",
        "updated_at": "2024-06-05T12:00:00Z",
        "price": 12,
        "avg_rating": 4.5,
        "total_sold": 10000
      },
      {
        "product_id": "2",
        "store_id": "102",
        "cover":
            "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
        "category_id": "202",
        "brand_id": "302",
        "product_name": "iPhone 15 Pro Max",
        "description": "Điện thoại cao cấp từ Apple",
        "created_at": "2024-06-02T09:30:00Z",
        "updated_at": "2024-06-05T13:00:00Z",
        "price": 20.0,
        "avg_rating": 4.2,
        "total_sold": 1040
      },
      {
        "product_id": "3",
        "store_id": "103",
        "cover":
            "https://aurora.edu.vn/wp-content/uploads/2023/05/lukas_blazek_mc_S_Dtb_WXUZU_unsplash_7bc2fc449a.jpg",
        "category_id": "203",
        "brand_id": "303",
        "product_name": "Samsung Galaxy S24 Ultra",
        "description": "Flagship Android mạnh nhất",
        "created_at": "2024-06-03T11:00:00Z",
        "updated_at": "2024-06-05T14:00:00Z",
        "price": 25.0,
        "avg_rating": 4.9,
        "total_sold": 1520
      },
      {
        "product_id": "4",
        "cover":
            "https://boba.vn/static/san-pham/phu-kien-cong-nghe/thiet-bi-cong-nghe/kinh-thuc-te-ao/kinh-thuc-te-ao-oculus-go-64gb-2018/kinh-thuc-.jpg",
        "store_id": "104",
        "category_id": "204",
        "brand_id": "304",
        "product_name": "AirPods Pro 2",
        "description": "Tai nghe không dây chống ồn",
        "created_at": "2024-06-04T12:00:00Z",
        "updated_at": "2024-06-05T15:00:00Z",
        "price": 15.0,
        "avg_rating": 3.5,
        "total_sold": 100
      },
      {
        "product_id": "5",
        "store_id": "105",
        "cover":
            "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
        "category_id": "205",
        "brand_id": "305",
        "product_name": "Apple Watch Series 9",
        "description": "Đồng hồ thông minh đa năng",
        "created_at": "2024-06-05T08:00:00Z",
        "updated_at": "2024-06-05T16:00:00Z",
        "price": 30.0,
        "avg_rating": 4.7,
        "total_sold": 10700
      }
    ];

    // if (response.statusCode == 200) {
    //   return ProductModel.fromJson(response.data);
    // } else {
    //   throw Exception('Login failed');
    // }
    return data.map((item) => ProductModel.fromJson(item)).toList();
  }

  @override
  Future<List<CategoryModel>> getListCategory() async {
    final data = [
      {
        "id": "1",
        "cover":
            "https://thoibaonganhang.vn/stores/news_dataimages/minhvl/122019/18/10/3454_4855477_AirPods.jpg",
        "name": "Category 1",
        "description": "Danh mục các sản phẩm điện thoại"
      },
      {
        "id": "2",
        "cover":
            "https://thoibaonganhang.vn/stores/news_dataimages/minhvl/122019/18/10/3506_4855468_amazon_echo.jpg",
        "name": "Category 2",
        "description": "Danh mục các sản phẩm điện thoại"
      },
      {
        "id": "3",
        "cover":
            "https://kenh14cdn.com/k:thumb_w/600/pgHuXrcq18KdYtKp3bAtptdIKIxsLl/Image/2013/07/h2-b3d63/14-san-pham-cong-nghe-sang-tao-nhat-moi-thoi-dai.jpg",
        "name": "Category 3",
        "description": "Danh mục các sản phẩm điện thoại"
      },
      {
        "id": "5",
        "cover":
            "https://xenangnhapkhau.com/wp-content/uploads/2023/09/San-pham-cong-nghe-gia-dinh-robot-hut-bui-thong-minh.jpg",
        "name": "Category 4",
        "description": "Danh mục các sản phẩm điện thoại"
      },
      {
        "id": "4",
        "cover":
            "https://xenangnhapkhau.com/wp-content/uploads/2023/09/San-pham-cong-nghe-gia-dinh-robot-hut-bui-thong-minh.jpg",
        "name": "Category 5",
        "description": "Danh mục các sản phẩm điện thoại"
      },
      {
        "id": "6",
        "cover":
            "https://xenangnhapkhau.com/wp-content/uploads/2023/09/May-phun-suong-thong-minh-san-pham-cong-nghe-gia-dinh-ban-chay-trong-nhung-ngay-nong-buc.jpg",
        "name": "Caterory 6",
        "description": "Danh mục các sản phẩm điện thoại"
      },
      {
        "id": "7",
        "cover":
            "https://video.vietjack.com/upload2/images/1657376072/1657376301-image13.png",
        "name": "Category 7",
        "description": "Danh mục các sản phẩm điện thoại"
      },
      {
        "id": "8",
        "cover":
            "https://video.vietjack.com/upload2/images/1657376072/1657376301-image12.png",
        "name": "Category 8",
        "description": "Danh mục các sản phẩm điện thoại"
      }
    ];

    return data.map((item) => CategoryModel.fromJson(item)).toList();
  }
}
