import 'package:flutter_riverpod/flutter_riverpod.dart';

final agenciesProvider = StateProvider<List<Agency>>((ref) => []);

class Agency {
  final String id;
  final String name;
  final String address;

  Agency({required this.id, required this.name, required this.address});
  
  // You can add methods here for agency management, such as fetching agencies from an API, updating agency details, etc.
}
