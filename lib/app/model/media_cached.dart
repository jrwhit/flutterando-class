import '../core/constants/constants.dart';

import 'base_media.dart';

class MediaCached {
  String id;
  CachedType type;
  BaseMedia content;
  final Duration currentProgress;

  MediaCached({this.type, this.content, this.id, this.currentProgress});
}
