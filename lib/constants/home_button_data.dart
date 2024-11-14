import 'package:rpg/router/routes.dart';

class HomeButtonEntity {
  HomeButtonEntity({
    this.imagePath = '',
    this.imageSize = 0,
    this.imageTopPosition = -40,
    this.imageLeftPosition = -10,
    this.startColor = '',
    this.endColor = '',
    this.navigatorUrl,
  });

  final String imagePath;
  final double imageSize;
  final double imageTopPosition;
  final double imageLeftPosition;
  final String startColor;
  final String endColor;
  final String? navigatorUrl;

  static List<HomeButtonEntity> list = <HomeButtonEntity>[
    HomeButtonEntity(
      imagePath: 'assets/lottie/dog.json',
      imageSize: 130,
      startColor: '#FA7D82',
      endColor: '#FFB295',
      navigatorUrl: trainUrl,
    ),
    HomeButtonEntity(
      imagePath: 'assets/lottie/chat.json',
      imageSize: 120,
      startColor: '#FF5287',
      endColor: '#FE95B6',
      navigatorUrl: skillUrl,
    ),
    HomeButtonEntity(
      imagePath: 'assets/lottie/sword.json',
      imageSize: 200,
      imageTopPosition: -50,
      imageLeftPosition: -50,
      startColor: '#B766AD',
      endColor: '#CA8EC2',
      navigatorUrl: battleUrl,
    ),
    HomeButtonEntity(
      imagePath: 'assets/lottie/setting.json',
      imageSize: 120,
      startColor: '#46A3FF',
      endColor: '#84C1FF',
      navigatorUrl: settingUrl,
    ),
  ];
}