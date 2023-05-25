import 'dart:ui';

//1.获取屏幕物理大小

double physicalWidth = window.physicalSize.width;

double physicalHeight = window.physicalSize.height;

// 2.获取dpr

double dpr = window.devicePixelRatio;

// 3.宽度和高度

double screenWidth = physicalWidth / dpr;

double screenHeight = physicalHeight / dpr;