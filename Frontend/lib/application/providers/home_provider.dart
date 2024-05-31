import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/data/services/api_path.dart';

class HomeProvider extends ChangeNotifier {


  Future<String?> addToCalendar(String date, String id) async {
    final service = RemoteService();
    await service.addToCalendar(date, id);
    return null;
  }

  Future<String?> deleteCalendar(String id) async {
    final service = RemoteService();
    await service.deleteCalendar(id);
    return null;
  }

  Future<String?> updateCalendar(String date, String id) async {
    final service = RemoteService();
    await service.updateCalendar(date, id);
    return null;
  }

}

// Provider definition
final homeProvider = ChangeNotifierProvider((ref) => HomeProvider());
