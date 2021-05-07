import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../../app/model/base_media.dart';
import '../../app/model/book.dart';
import '../../app/model/media_cached.dart';
import '../../app/model/playlist.dart';
import '../../app/model/trail.dart';
import '../../app/model/video.dart';
import '../../app/repository/home_repository.dart';
import '../../app/framework/navigation_service.dart';
import '../../app/view_model/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(NavigationService navigationService, this.homeRepository) : super(navigationService);

  final HomeRepository homeRepository;

  var homeItems = BehaviorSubject<Tuple6>.seeded(null);
  
  var banners = BehaviorSubject.seeded(List<BaseMedia>());
  var unfinishedMediaPlaybacks = BehaviorSubject.seeded(List<MediaCached>());
  var featuredVideos = BehaviorSubject.seeded(List<Video>());
  var featuredPlaylist = BehaviorSubject.seeded(List<PlayList>());
  var featuredBooks = BehaviorSubject.seeded(List<Book>());
  var featuredTrails = BehaviorSubject.seeded(List<Trail>());

  @override
  Future<void> firstLoad() async {
    homeItems.value = await homeRepository.getHomeItems();

    banners.value = homeItems.value.item1;
    unfinishedMediaPlaybacks.value = homeItems.value.item2;
    featuredVideos.value = homeItems.value.item3;
    featuredPlaylist.value = homeItems.value.item4;
    featuredBooks.value = homeItems.value.item5;
    featuredTrails.value = homeItems.value.item6;
  }

  @override
  void dispose() {
    homeItems.close();
    unfinishedMediaPlaybacks.close();
    banners.close();
    featuredVideos.close();
    featuredTrails.close();
    featuredBooks.close();
    featuredPlaylist.close();

    super.dispose();
  }
}