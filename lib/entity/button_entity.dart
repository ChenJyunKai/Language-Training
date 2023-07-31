import 'package:rpg/router/routes.dart';

class ButtonEntity {
  ButtonEntity({
    this.imagePath = '',
    this.imageSize = 0,
    this.imageTopPosition = -40,
    this.imageLeftPosition = -10,
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.navigatorUrl,
  });

  final String imagePath;
  final double imageSize;
  final double imageTopPosition;
  final double imageLeftPosition;
  final String titleTxt;
  final String startColor;
  final String endColor;
  final String? navigatorUrl;

  static List<ButtonEntity> home = <ButtonEntity>[
    ButtonEntity(
      imagePath: 'assets/lottie/dog.json',
      imageSize: 130,
      titleTxt: '鍛鍊',
      startColor: '#FA7D82',
      endColor: '#FFB295',
      navigatorUrl: trainUrl,
    ),
    ButtonEntity(
      imagePath: 'assets/lottie/chat.json',
      imageSize: 120,
      titleTxt: '聊天',
      startColor: '#FF5287',
      endColor: '#FE95B6',
      navigatorUrl: chatUrl,
    ),
    ButtonEntity(
      imagePath: 'assets/lottie/sword.json',
      imageSize: 200,
      imageTopPosition: -50,
      imageLeftPosition: -50,
      titleTxt: '對戰',
      startColor: '#B766AD',
      endColor: '#CA8EC2',
    ),
    ButtonEntity(
      imagePath: 'assets/lottie/setting.json',
      imageSize: 120,
      titleTxt: '設定',
      startColor: '#46A3FF',
      endColor: '#84C1FF',
      navigatorUrl: settingUrl,
    ),
  ];
}
