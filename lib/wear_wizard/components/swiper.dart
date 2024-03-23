import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

class MyCarousel extends StatelessWidget {
  final List<String> imageUrls;

  MyCarousel({Key? key, required this.imageUrls}) : super(key: key);
  final BorderRadius borderRadius = BorderRadius.circular(14);
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: FractionallySizedBox(
          heightFactor: 0.56, // 设置轮播图高度
          child: Stack(
            children: [
              Swiper(
                itemCount: imageUrls.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  );
                },
                // 添加其他参数，比如自动播放、循环、等等
                autoplay: false,
                autoplayDelay: 3000,
                autoplayDisableOnInteraction: true,
                loop: true,
                // 隐藏底部指示器
                // pagination: const SwiperPagination(builder: SwiperPagination.dots),
                // 控制按钮
                control: const SwiperControl(
                  // 修改箭头按钮的大小
                  size: 24.0,
                  color: Color(0xFFcccccc),
                    padding: EdgeInsets.all(12.0),
                ),
              ),
            Positioned(
              left: 18,
              bottom: 20,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      // 左下角按钮点击事件
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      // child: Image.asset('assets/button_image.png', width: 24, height: 24),
                      child: Image.network('https://via.placeholder.com/40x40/0000FF/FFFFFF'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      // 左下角按钮点击事件
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      // child: Image.asset('assets/button_image.png', width: 24, height: 24),
                      child: Image.network('https://via.placeholder.com/40x40/0000FF/FFFFFF'),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 12,
              bottom: 20,
              child: ElevatedButton(
                onPressed: () {
                  // 右下角按钮的点击事件
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Icon(Icons.add),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}