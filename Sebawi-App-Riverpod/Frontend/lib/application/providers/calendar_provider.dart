import 'package:Sebawi/data/models/calendars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/data/services/api_path.dart';

class CalendarsNotifier extends AsyncNotifier<List<Calendar>?>  {
  @override
  Future<List<Calendar>?> build() async {
    return await _fetchCalendars();
  }

  Future<List<Calendar>?> _fetchCalendars() async {
    final service = RemoteService();
    return await service.getCalendar() ?? [];
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchCalendars());
  }
}

final calendarsProvider = AsyncNotifierProvider<CalendarsNotifier, List<Calendar>?>(() {
  return CalendarsNotifier();
});
