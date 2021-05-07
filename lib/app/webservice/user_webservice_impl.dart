import '../model/media_cached.dart';
import '../webservice/home_webservice_impl.dart';

import 'user_webservice.dart';

class UserWebserviceImpl extends UserWebservice {
  @override
  Future<List<MediaCached>> fetchCached() {
    var success = true;

    return Future.delayed(
      Duration(milliseconds: 500),
      () => success
          ? HomeWebServiceImpl.cachedMedia
          : Future.error("failed load list cached"),
    );
  }
}
