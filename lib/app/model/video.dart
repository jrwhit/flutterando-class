import '../../app/model/base_media.dart';

class Video extends BaseMedia {
  Video(
    String id,
    String title,
    String subtitle,
    String imageUrl,
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
