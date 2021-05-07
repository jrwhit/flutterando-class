import 'package:rxdart/rxdart.dart';

import '../framework/navigation_service.dart';
import '../repository/user_repository.dart';
import '../model/media_cached.dart';
import '../view_model/base/base_view_model.dart';

class ProgressViewModel extends BaseViewModel {
  ProgressViewModel(NavigationService navigationService, this.userRepository)
      : super(navigationService);

  final UserRepository userRepository;

  var unfinishedVideo = BehaviorSubject.seeded(List<MediaCached>());
  var finishedVideo = BehaviorSubject.seeded(List<MediaCached>());

  var unfinishedPlaylist = BehaviorSubject.seeded(List<MediaCached>());
  var finishedPlaylist = BehaviorSubject.seeded(List<MediaCached>());

  @override
  Future<void> firstLoad() async {
    var tuple2 = await userRepository.getCachedMedia();

    var cachedVideo = tuple2.item1;
    var cachedPlaylist = tuple2.item2;

    for(MediaCached cachedVideo in cachedVideo){
      if(cachedVideo.currentProgress == cachedVideo.content.duration){
        finishedVideo.value.add(cachedVideo);
      }else{
        unfinishedVideo.value.add(cachedVideo);
      }
    }

    for(MediaCached cachedPlaylist in cachedPlaylist){
      if(cachedPlaylist.currentProgress == cachedPlaylist.content.duration){
        finishedPlaylist.value.add(cachedPlaylist);
      }else{
        unfinishedPlaylist.value.add(cachedPlaylist);
      }
    }
  }

  @override
  void dispose() {
    unfinishedPlaylist.close();
    finishedPlaylist.close();

    unfinishedVideo.close();
    finishedVideo.close();

    super.dispose();
  }
}
