import 'dart:math';

import '../../app/model/book.dart';
import '../../app/model/media_cached.dart';
import '../../app/model/playlist.dart';
import '../../app/model/trail.dart';
import '../../app/model/video.dart';
import '../../app/model/base_media.dart';
import '../../app/core/constants/constants.dart';
import '../../app/core/constants/images.dart';
import '../../app/webservice/home_webservice.dart';

class HomeWebServiceImpl extends HomeWebservice {
  @override
  Future<List<dynamic>> fetchHomeItems() {
    var success = true;

    return Future.delayed(
        const Duration(milliseconds: 500),
        () => success
            ? <List<dynamic>>[
                BaseMedias,
                cachedMedia,
                videos,
                playlists,
                books,
                trails,
              ]
            : Future.error("404"));
  }

  static List<BaseMedia> BaseMedias = <BaseMedia>[
    BaseMedia(
      Random().nextInt(200).toString(),
      "Jacob Moura",
      "Um novo modelo de Comunidade",
      AppImages.pictureJacob,
      Duration(microseconds: Random().nextInt(50000) * 1000000.toInt()),
      "Aula 01",
    ),
    BaseMedia(
      Random().nextInt(200).toString(),
      "Fabio Akita",
      "Akitando",
      AppImages.pictureAkita,
      Duration(microseconds: Random().nextInt(50000) * 1000000.toInt()),
      "Live",
    ),
  ];
  static List<MediaCached> cachedMedia = <MediaCached>[
    MediaCached(
      id: Random().nextInt(200).toString(),
      type: CachedType.video,
      currentProgress:
          Duration(microseconds: Random().nextInt(50000) * 1000000.toInt()),
      content: videos[3],
    ),
    MediaCached(
      id: Random().nextInt(200).toString(),
      type: CachedType.video,
      currentProgress: Duration(microseconds: 500 * 1000000.toInt()),
      content: videos[4],
    ),
    // MediaCached(
    //   id: Random().nextInt(200).toString(),
    //   type: CachedType.playlist,
    //   currentProgress:
    //       Duration(microseconds: 500 * 1000000.toInt()),
    //   content: playlists[0],
    // ),
    // MediaCached(
    //   id: Random().nextInt(200).toString(),
    //   type: CachedType.playlist,
    //   currentProgress:
    //       Duration(microseconds: Random().nextInt(300) * 1000000.toInt()),
    //   content: playlists[1],
    // ),
  ];
  static List<Video> videos = <Video>[
    Video(Random().nextInt(200).toString(), "Latam", "", AppImages.latam,
        Duration(microseconds: Random().nextInt(50000) * 1000000.toInt()), ""),
    Video(
        Random().nextInt(200).toString(),
        "Flutter Engage",
        "",
        AppImages.flutterEngage,
        Duration(microseconds: Random().nextInt(50000) * 1000000.toInt()),
        ""),
    Video(
        Random().nextInt(200).toString(),
        "Flutterando alert",
        "",
        AppImages.flutterandoAlert,
        Duration(microseconds: Random().nextInt(50000) * 1000000.toInt()),
        ""),
    Video(
        Random().nextInt(200).toString(),
        "Gerência de estado",
        "Jacob Moura",
        AppImages.flutterandoGerenciaDeEstado,
        Duration(microseconds: Random().nextInt(50000) * 1000000.toInt()),
        "Aula 01"),
    Video(
      Random().nextInt(200).toString(),
      "Fabio Akita",
      "Akitando",
      AppImages.flutterandoAkitando,
      Duration(microseconds: 500 * 1000000.toInt()),
      "Live",
    ),
  ];
  static List<Book> books = <Book>[
    Book(
      Random().nextInt(200).toString(),
      "Flutter na prática",
      "Frank Zammeti - 2020",
      AppImages.flutterNaPratica,
    ),
    Book(
      Random().nextInt(200).toString(),
      '"Código limpo" - Habilidades práticas do agile Software',
      "Robert C. Martin - 2020",
      AppImages.codigoLimpo,
    ),
    Book(
      Random().nextInt(200).toString(),
      "Dart - Octuber 1, 2020",
      "Reder Glauber Gad Weyers - 2020",
      AppImages.dart,
    ),
  ];
  static List<PlayList> playlists = <PlayList>[
    PlayList(
      Random().nextInt(200).toString(),
      "RouterOutlet",
      "Jacob Moura",
      AppImages.flutterEngage,
      videos,
      Duration(microseconds: 60000 * 1000000.toInt()),
      Duration(microseconds: 500 * 1000000.toInt()),
      "Okotta",
    ),
    PlayList(
        Random().nextInt(200).toString(),
        'Arquitetura para micro-apps',
        "Jacob Moura",
        AppImages.flutterEngage,
        videos,
        Duration(microseconds: 60000 * 1000000.toInt()),
        Duration(microseconds: Random().nextInt(50000) * 1000000.toInt()),
        "okatte"),
  ];
  static List<Trail> trails = <Trail>[
    Trail(
      Random().nextInt(200).toString(),
      "Iniciante",
      """As an application project grows and becomes complex, it's hard to keep your code and project
       structure mantainable and reusable. Modular provides a bunch of Flutter-suiting solutions
        to deal with this""",
      AppImages.flutterEngage,
      TypeTrail.video,
    ),
    Trail(
      Random().nextInt(200).toString(),
      'Semana Modular',
      """Uma estrutura de dados (ED), em ciência da computação, é uma coleção tanto de valores
       (e seus relacionamentos) quanto de operações (sobre os valores e estruturas decorrentes).
        É uma implementação concreta de um tipo abstrato de dado (TAD) ou um tipo de dado (TD)
         básico ou primitivo. Assim, o termo ED pode ser considerado sinônimo de TD, se
          considerado TAD um hipônimo de TD, isto é, se um TAD for um TD.""",
      AppImages.flutterEngage,
      TypeTrail.text,
    ),
  ];
}
