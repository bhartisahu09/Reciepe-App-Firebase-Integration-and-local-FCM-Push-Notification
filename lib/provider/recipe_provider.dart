import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:recipe_app/services/notification_service.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class RecipeProvider extends ChangeNotifier {
  final bool _isLoading = false;
  bool get isLoading => _isLoading;

//----Local Notification 
 Future<void> showRecipeNotification() async {
  const String imageUrl =
      'https://images.unsplash.com/photo-1498837167922-ddd27525d352';

  // Step 1: Download image
  final Directory tempDir = await getTemporaryDirectory();
  final String filePath = '${tempDir.path}/recipe_image.jpg';

  final http.Response response = await http.get(Uri.parse(imageUrl));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);

  // Step 2: Use FilePathAndroidBitmap
  final BigPictureStyleInformation bigPictureStyleInformation =
      BigPictureStyleInformation(
    FilePathAndroidBitmap(filePath),
    largeIcon: FilePathAndroidBitmap(filePath),
    contentTitle: 'Get All Recipe Items',
    summaryText: 'Explore a variety of delicious recipes!',
  );

  final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'recipe_channel_id',
    'Recipe Notifications',
    channelDescription: 'Notification when seeing all recipes',
    importance: Importance.high,
    priority: Priority.high,
    styleInformation: bigPictureStyleInformation,
  );

  final NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await NotificationService.flutterLocalNotificationsPlugin.show(
    0,
    'Get All Recipe Items',
    'Explore a variety of delicious recipes!',
    platformChannelSpecifics,
    payload: 'see_all_recipes',
  );
}
}
