import 'package:flutterando_class/app/model/base_media.dart';
import 'package:flutterando_class/app/model/book.dart';
import 'package:flutterando_class/app/model/media_cached.dart';
import 'package:flutterando_class/app/model/playlist.dart';
import 'package:flutterando_class/app/model/trail.dart';
import 'package:flutterando_class/app/model/video.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

import '../../app/webservice/home_webservice.dart';

class HomeRepository {
  final HomeWebservice _homeWebservice;
  HomeRepository({@required HomeWebservice homeWebservice})
      : _homeWebservice = homeWebservice;

  Future<
      Tuple6<List<BaseMedia>, List<MediaCached>, List<Video>, List<PlayList>,
          List<Book>, List<Trail>>> getHomeItems() async {
    var homeItems = await _homeWebservice.fetchHomeItems();
    return Tuple6(
      homeItems[0],
      homeItems[1],
      homeItems[2],
      homeItems[3],
      homeItems[4],
      homeItems[5],
    );
  }
}
