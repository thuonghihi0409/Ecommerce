import 'package:flutter/material.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Stream'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // Header hoặc phần intro cho Live
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live Stream đang diễn ra!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Theo dõi các buổi live hot nhất ngay tại đây.',
                  style: TextStyle(fontSize: 16, color: Colors.deepPurple[700]),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Phần video stream hoặc các hình ảnh thumbnail
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Giả sử có 10 livestream
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 5,
                    child: Column(
                      children: [
                        // Hình ảnh thu nhỏ của video
                        Image.asset(
                          'assets/thumbnail.jpg', // Thay bằng ảnh thumbnail của livestream
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Icon(Icons.live_tv, color: Colors.deepPurple),
                              SizedBox(width: 8),
                              Text(
                                'Livestream ${index + 1}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple[900],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
