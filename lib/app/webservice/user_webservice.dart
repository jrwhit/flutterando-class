import '../model/media_cached.dart';

abstract class UserWebservice {
  Future<List<MediaCached>> fetchCached();
}