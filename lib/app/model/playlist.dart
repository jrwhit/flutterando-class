import '../../app/model/video.dart';
import '../../app/model/base_media.dart';

class PlayList extends BaseMedia {
  final List<Video> content;
  final Duration amountDuration;
  PlayList(
    String id,
    String title,
    String subtitle,
    String imageUrl,
    this.content,
    this.amountDuration,
    Duration duration,
    String description,
  ) : super(
          id,
          title,
          subtitle,
          imageUrl,
          duration,
          description,
        );
}
