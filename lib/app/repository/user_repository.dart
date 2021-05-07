import 'package:flutterando_class/app/core/constants/constants.dart';
import 'package:tuple/tuple.dart';

import '../webservice/user_webservice.dart';
import '../model/media_cached.dart';

class UserRepository {
  final UserWebservice _userWebservice;

  UserRepository(UserWebservice userWebservice)
      : _userWebservice = userWebservice;

  Future<Tuple2<List<MediaCached>, List<MediaCached>>> getCachedMedia() async{
    var list = await _userWebservice.fetchCached();
    var cachedTypeVideo = List<MediaCached>();
    var cachedTypePlaylist = List<MediaCached>();

    for(MediaCached cached in list){
      if(cached.type == CachedType.video){
        cachedTypeVideo.add(cached);
      }else{
        cachedTypePlaylist.add(cached);
      }
    }
    return Tuple2(cachedTypeVideo, cachedTypePlaylist);
  }
}
