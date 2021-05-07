import 'package:flutter/material.dart';

import 'package:page_indicator/page_indicator.dart';

import '../../../app/view/base/base_screen_view_state.dart';
import '../../../app/view_model/home_view_model.dart';
import '../../../app/core/constants/colors.dart';
import '../../../app/core/constants/images.dart';
import '../../../app/model/book.dart';
import '../../../app/model/media_cached.dart';
import '../../../app/model/playlist.dart';
import '../../../app/model/trail.dart';
import '../../../app/model/video.dart';
import '../../../app/widget/banner_card.dart';
import '../../../app/widget/book_card.dart';
import '../../../app/widget/header_title.dart';
import '../../../app/widget/indicator_fork.dart';
import '../../../app/widget/playlist_card.dart';
import '../../../app/widget/trails_card.dart';
import '../../../app/widget/video_card.dart';
import '../../../app/widget/video_default_horizontal_card.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends BaseScreenViewState<HomeView, HomeViewModel> {
  final _salePageController = PageController();
  final _currentSalePageNotifier = ValueNotifier<int>(0);

  @override
  Widget buildParent(BuildContext context, Widget child) {
    return Scaffold(
      body: child,
    );
  }

  @override
  Widget buildInitializedState(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildCarousel(context),
        ),
        SliverToBoxAdapter(
          child: _buildResumePlayback(context),
        ),
        SliverToBoxAdapter(
          child: _buildFeaturedVideos(context),
        ),
        SliverToBoxAdapter(
          child: _buildFeaturedPlayList(context),
        ),
        SliverToBoxAdapter(
          child: _buildFeaturedBooks(context),
        ),
        SliverToBoxAdapter(
          child: _buildFeaturedTrails(context),
        ),
      ],
    );
  }

  Widget _buildCarousel(BuildContext context) => MyPageIndicatorContainer(
        pageViewHeight: 360,
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 20,
        ),
        shape: IndicatorShape.circle(size: 10),
        indicatorSpace: 4,
        length: viewModel.banners.value?.length ?? 0,
        indicatorSelectorColor: AppColors.accent,
        indicatorColor: AppColors.accent.withOpacity(0.5),
        child: PageView.builder(
          controller: _salePageController,
          itemCount: viewModel.banners.value?.length ?? 0,
          itemBuilder: (context, index) {
            return BannerCard(
                viewModel.banners.value[index], viewModel.goProgress);
          },
          onPageChanged: (int index) {
            _currentSalePageNotifier.value = index;
          },
        ),
      );

  Widget _buildResumePlayback(BuildContext context) => Column(
        children: [
          StreamBuilder<List<MediaCached>>(
            stream: viewModel.unfinishedMediaPlaybacks,
            initialData: viewModel.unfinishedMediaPlaybacks.value,
            builder: (context, snap) {
              var unfinishedMedia = snap.data;

              return unfinishedMedia != null && unfinishedMedia.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: HeaderTitle(
                            "Continue de onde parou",
                            buildTag: false,
                          ),
                        ),
                        Container(
                          height: 120,
                          alignment: Alignment.centerLeft,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: unfinishedMedia.length,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            itemBuilder: (context, index) {
                              return VideoDefaultHorizontalCard(
                                unfinishedMedia[index].content,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 12);
                            },
                          ),
                        ),
                      ],
                    )
                  : Container();
            },
          ),
        ],
      );

  Widget _buildFeaturedVideos(BuildContext context) => Column(
        children: [
          StreamBuilder<List<Video>>(
            stream: viewModel.featuredVideos,
            initialData: viewModel.featuredVideos.value,
            builder: (context, AsyncSnapshot<List<Video>> snap) {
              var featuredVideos = snap.data;

              return featuredVideos != null && featuredVideos.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: HeaderTitle(
                            "Flutterando videos",
                            buildTag: true,
                            buildFeaturedTitle: true,
                          ),
                        ),
                        Container(
                          height: 180,
                          alignment: Alignment.centerLeft,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: featuredVideos.length,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            itemBuilder: (context, index) {
                              return VideoCard(
                                featuredVideos[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 12);
                            },
                          ),
                        ),
                      ],
                    )
                  : Container();
            },
          ),
        ],
      );

  Widget _buildFeaturedPlayList(BuildContext context) => Column(
        children: [
          StreamBuilder<List<PlayList>>(
            stream: viewModel.featuredPlaylist,
            initialData: viewModel.featuredPlaylist.value,
            builder: (context, AsyncSnapshot<List<PlayList>> snap) {
              var featuredPlayList = snap.data;

              return featuredPlayList != null && featuredPlayList.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: HeaderTitle(
                            "Flutterando playlist",
                            buildTag: true,
                            buildFeaturedTitle: true,
                            pathSvg: AppImages.play,
                            buildBackgroundSvg: true,
                          ),
                        ),
                        Container(
                          height: 210,
                          alignment: Alignment.centerLeft,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: featuredPlayList.length,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            itemBuilder: (context, index) {
                              return PlayListCard(
                                featuredPlayList[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 12);
                            },
                          ),
                        ),
                      ],
                    )
                  : Container();
            },
          ),
        ],
      );

  Widget _buildFeaturedBooks(BuildContext context) => Column(
        children: [
          StreamBuilder<List<Book>>(
            stream: viewModel.featuredBooks,
            initialData: viewModel.featuredBooks.value,
            builder: (context, AsyncSnapshot<List<Book>> snap) {
              var featuredBook = snap.data;

              return featuredBook != null && featuredBook.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: HeaderTitle(
                            "Flutterando books",
                            buildTag: true,
                            buildFeaturedTitle: true,
                            pathSvg: AppImages.rectangle,
                            buildBackgroundSvg: true,
                          ),
                        ),
                        Container(
                          height: 360,
                          alignment: Alignment.centerLeft,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: featuredBook.length,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            itemBuilder: (context, index) {
                              return BookCard(
                                featuredBook[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 12);
                            },
                          ),
                        ),
                      ],
                    )
                  : Container();
            },
          ),
        ],
      );

  Widget _buildFeaturedTrails(BuildContext context) => Column(
        children: [
          StreamBuilder<List<Trail>>(
            stream: viewModel.featuredTrails,
            initialData: viewModel.featuredTrails.value,
            builder: (context, AsyncSnapshot<List<Trail>> snap) {
              var featuredTrail = snap.data;

              return featuredTrail != null && featuredTrail.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: HeaderTitle(
                            "Trilhas de conhecimento",
                          ),
                        ),
                        Container(
                          height: 160,
                          alignment: Alignment.centerLeft,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: featuredTrail.length,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            itemBuilder: (context, index) {
                              return TrailsCard(
                                featuredTrail[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 12);
                            },
                          ),
                        ),
                      ],
                    )
                  : Container();
            },
          ),
        ],
      );

  @override
  void dispose() {
    _salePageController.dispose();
    super.dispose();
  }
}
