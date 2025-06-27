import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../models/review_model.dart';

abstract class ReviewRemoteDatasource {
  Future<ListModel<ReviewModel>> getListReview();
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDatasource {
  ReviewRemoteDataSourceImpl();

  @override
  Future<ListModel<ReviewModel>> getListReview() async {
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
          "id": "r1",
          "content": "Sản phẩm tốt, giao hàng nhanh.",
          "image_urls": [
            "https://example.com/image1.jpg",
            "https://example.com/image1.jpg",
            "https://example.com/image1.jpg",
            "https://example.com/image1.jpg",
            "https://example.com/image1.jpg",
            "https://example.com/image2.jpg"
          ],
          "rating": 5,
          "likes_count": 12,
          "user": {
            "id": "u123",
            "username": "nguyenvana",
            "password":
                "12345678", // Thường sẽ không trả về password thật trong thực tế
            "phone": "0987654321",
            "email": "nguyenvana@example.com",
            "role": "customer",
            "birth": "2000-01-15T00:00:00.000Z",
            "gender": "male",
            "fullname": "Nguyễn Văn A",
            "image": "https://example.com/avatar.jpg"
          },
          "product_id": "p1",
          "variant": {
            "id": "v001",
            "name": "RAM 16GB / SSD 512GB",
            "price": 2499.99,
            "stock": 10,
            "cover":
                "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          },
          "created_at": "2024-06-01T10:00:00Z"
        },
        {
          "id": "r2",
          "content": "Hàng đẹp như mô tả, đáng mua.",
          "image_urls": [],
          "rating": 4,
          "likes_count": 5,
          "user": {
            "id": "u123",
            "username": "nguyenvana",
            "password":
                "12345678", // Thường sẽ không trả về password thật trong thực tế
            "phone": "0987654321",
            "email": "nguyenvana@example.com",
            "role": "customer",
            "birth": "2000-01-15T00:00:00.000Z",
            "gender": "male",
            "fullname": "Nguyễn Văn A",
            "image": "https://example.com/avatar.jpg"
          },
          "product_id": "p1",
          "variant": {
            "id": "v001",
            "name": "RAM 16GB / SSD 512GB",
            "price": 2499.99,
            "stock": 10,
            "cover":
                "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          },
          "created_at": "2024-06-02T14:30:00Z"
        },
        {
          "id": "r3",
          "content": "Không hài lòng lắm vì đóng gói sơ sài.",
          "image_urls": ["https://example.com/image3.jpg"],
          "rating": 2,
          "likes_count": 3,
          "user": {
            "id": "u123",
            "username": "nguyenvana",
            "password":
                "12345678", // Thường sẽ không trả về password thật trong thực tế
            "phone": "0987654321",
            "email": "nguyenvana@example.com",
            "role": "customer",
            "birth": "2000-01-15T00:00:00.000Z",
            "gender": "male",
            "fullname": "Nguyễn Văn A",
            "image": "https://example.com/avatar.jpg"
          },
          "product_id": "p2",
          "variant": {
            "id": "v001",
            "name": "RAM 16GB / SSD 512GB",
            "price": 2499.99,
            "stock": 10,
            "cover":
                "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          },
          "created_at": "2024-06-03T08:20:00Z"
        },
        {
          "id": "r4",
          "content": "Chất lượng ok, giá hợp lý.",
          "image_urls": [],
          "rating": 4,
          "likes_count": 8,
          "user": {
            "id": "u123",
            "username": "nguyenvana",
            "password":
                "12345678", // Thường sẽ không trả về password thật trong thực tế
            "phone": "0987654321",
            "email": "nguyenvana@example.com",
            "role": "customer",
            "birth": "2000-01-15T00:00:00.000Z",
            "gender": "male",
            "fullname": "Nguyễn Văn A",
            "image": "https://example.com/avatar.jpg"
          },
          "product_id": "p2",
          "variant": {
            "id": "v001",
            "name": "RAM 16GB / SSD 512GB",
            "price": 2499.99,
            "stock": 10,
            "cover":
                "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          },
          "created_at": "2024-06-04T09:00:00Z"
        },
        {
          "id": "r5",
          "content": "Màu sắc không giống hình.",
          "image_urls": ["https://example.com/image4.jpg"],
          "rating": 3,
          "likes_count": 1,
          "user": {
            "id": "u123",
            "username": "nguyenvana",
            "password":
                "12345678", // Thường sẽ không trả về password thật trong thực tế
            "phone": "0987654321",
            "email": "nguyenvana@example.com",
            "role": "customer",
            "birth": "2000-01-15T00:00:00.000Z",
            "gender": "male",
            "fullname": "Nguyễn Văn A",
            "image": "https://example.com/avatar.jpg"
          },
          "product_id": "p3",
          "variant": {
            "id": "v001",
            "name": "RAM 16GB / SSD 512GB",
            "price": 2499.99,
            "stock": 10,
            "cover":
                "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          },
          "created_at": "2024-06-05T11:15:00Z"
        },
        {
          "id": "r6",
          "content": "Hàng mới 100%, đóng gói kỹ, sẽ ủng hộ tiếp.",
          "image_urls": ["https://example.com/image5.jpg"],
          "rating": 5,
          "likes_count": 10,
          "user": {
            "id": "u123",
            "username": "nguyenvana",
            "password":
                "12345678", // Thường sẽ không trả về password thật trong thực tế
            "phone": "0987654321",
            "email": "nguyenvana@example.com",
            "role": "customer",
            "birth": "2000-01-15T00:00:00.000Z",
            "gender": "male",
            "fullname": "Nguyễn Văn A",
            "image": "https://example.com/avatar.jpg"
          },
          "product_id": "p4",
          "variant": {
            "id": "v001",
            "name": "RAM 16GB / SSD 512GB",
            "price": 2499.99,
            "stock": 10,
            "cover":
                "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          },
          "created_at": "2024-06-06T16:45:00Z"
        },
        {
          "id": "r7",
          "content": "Giao trễ, nhưng hàng tốt.",
          "image_urls": [],
          "rating": 4,
          "likes_count": 2,
          "user": {
            "id": "u123",
            "username": "nguyenvana",
            "password":
                "12345678", // Thường sẽ không trả về password thật trong thực tế
            "phone": "0987654321",
            "email": "nguyenvana@example.com",
            "role": "customer",
            "birth": "2000-01-15T00:00:00.000Z",
            "gender": "male",
            "fullname": "Nguyễn Văn A",
            "image": "https://example.com/avatar.jpg"
          },
          "product_id": "p4",
          "variant": {
            "id": "v001",
            "name": "RAM 16GB / SSD 512GB",
            "price": 2499.99,
            "stock": 10,
            "cover":
                "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          },
          "created_at": "2024-06-07T13:30:00Z"
        },
        {
          "id": "r8",
          "content": "Rất không hài lòng. Hỏng khi nhận.",
          "image_urls": ["https://example.com/image6.jpg"],
          "rating": 1,
          "likes_count": 0,
          "user": {
            "id": "u123",
            "username": "nguyenvana",
            "password":
                "12345678", // Thường sẽ không trả về password thật trong thực tế
            "phone": "0987654321",
            "email": "nguyenvana@example.com",
            "role": "customer",
            "birth": "2000-01-15T00:00:00.000Z",
            "gender": "male",
            "fullname": "Nguyễn Văn A",
            "image": "https://example.com/avatar.jpg"
          },
          "product_id": "p5",
          "variant": {
            "id": "v001",
            "name": "RAM 16GB / SSD 512GB",
            "price": 2499.99,
            "stock": 10,
            "cover":
                "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          },
          "created_at": "2024-06-08T10:10:00Z"
        },
        {
          "id": "r9",
          "content": "Đúng hàng chính hãng, yên tâm dùng.",
          "image_urls": [
            "https://example.com/image7.jpg",
            "https://example.com/image8.jpg"
          ],
          "rating": 5,
          "likes_count": 9,
          "user": {
            "id": "u123",
            "username": "nguyenvana",
            "password":
                "12345678", // Thường sẽ không trả về password thật trong thực tế
            "phone": "0987654321",
            "email": "nguyenvana@example.com",
            "role": "customer",
            "birth": "2000-01-15T00:00:00.000Z",
            "gender": "male",
            "fullname": "Nguyễn Văn A",
            "image": "https://example.com/avatar.jpg"
          },
          "product_id": "p6",
          "variant": {
            "id": "v001",
            "name": "RAM 16GB / SSD 512GB",
            "price": 2499.99,
            "stock": 10,
            "cover":
                "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          },
          "created_at": "2024-06-09T18:00:00Z"
        },
        {
          "id": "r10",
          "content": "Ổn áp trong tầm giá, shop nhiệt tình.",
          "image_urls": [],
          "rating": 4,
          "likes_count": 4,
          "user": {
            "id": "u123",
            "username": "nguyenvana",
            "password":
                "12345678", // Thường sẽ không trả về password thật trong thực tế
            "phone": "0987654321",
            "email": "nguyenvana@example.com",
            "role": "customer",
            "birth": "2000-01-15T00:00:00.000Z",
            "gender": "male",
            "fullname": "Nguyễn Văn A",
            "image": "https://example.com/avatar.jpg"
          },
          "product_id": "p6",
          "variant": {
            "id": "v001",
            "name": "RAM 16GB / SSD 512GB",
            "price": 2499.99,
            "stock": 10,
            "cover":
                "https://techlandshop.com/wp-content/uploads/camera-yoosee-00-300x300.jpg",
          },
          "created_at": "2024-06-10T15:25:00Z"
        }
      ]
    };
    // if (response.statusCode == 200) {
    //   return ReviewModel.fromJson(response.data);
    // } else {
    //   throw Exception('Login failed');
    // }
    return ListModel.fromJson(data, (json) => ReviewModel.fromJson(json));
  }
}
