import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:rxdart/rxdart.dart';

import '../../../app/core/constants/colors.dart';
import '../../../app/core/constants/images.dart';
import '../../../app/model/media_cached.dart';
import '../../../app/widget/header_title.dart';
import '../../../app/widget/video_cached_horizontal_card.dart';
import '../../../app/view_model/progress_view_model.dart';

import 'base_screen_view_state.dart';

class ProgressView extends StatefulWidget {
  @override
  _ProgressViewState createState() => _ProgressViewState();
}

class _ProgressViewState
    extends BaseScreenViewState<ProgressView, ProgressViewModel>
    with SingleTickerProviderStateMixin {
  @override
  Widget buildParent(BuildContext context, Widget child) {
    return Scaffold(
      body: child,
    );
  }

  @override
  Widget buildInitializedState(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          _buildAppBar(),
          SizedBox(
            height: 40,
          ),
          _buildTabBar(_tabController),
          _buildTabView(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FloatingActionButton(
          heroTag: "goBack",
          elevation: 0,
          mini: true,
          isExtended: false,
          child: Icon(
            Icons.chevron_left,
            size: 40,
            color: AppColors.secondary,
          ),
          onPressed: viewModel.goBack,
          backgroundColor: AppColors.floatingButton,
        ),
        Text(
          "Meu progresso",
          style: Theme.of(context).textTheme.headline3.copyWith(
                color: AppColors.secondary,
              ),
        ),
        FloatingActionButton(
          heroTag: "sort",
          elevation: 0,
          mini: true,
          isExtended: false,
          child: Image.asset(
            AppImages.sort,
            height: 40,
            width: 40,
          ),
          backgroundColor: Colors.transparent,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTabBar(TabController controller) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 6,
      ),
      child: TabBar(
        controller: controller,
        unselectedLabelColor: AppColors.secondary,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.secondary,
        indicator: BoxDecoration(
            color: AppColors.selectedTabBar,
            borderRadius: BorderRadius.circular(8)),
        tabs: <Widget>[
          _buildTabItem("FlutterandoVideos"),
          _buildTabItem("FlutterandoPlaylists"),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title) {
    return Tab(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            direction: Axis.horizontal,
            children: [
              SizedBox(
                width: 8,
              ),
              Flexible(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        color: AppColors.secondary,
                        fontSize: 12,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabView() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                _buildTabViewItemVideo(
                    "Em andamento(${viewModel.unfinishedVideo.value.length})",
                    viewModel.unfinishedVideo),
                const SizedBox(height: 20),
                _buildTabViewItemVideo(
                    "Concluídos(${viewModel.finishedVideo.value.length})",
                    viewModel.finishedVideo),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildTabViewItemPlaylist(
                    "Em andamento(${viewModel.unfinishedPlaylist.value.length})",
                    viewModel.unfinishedPlaylist),
                _buildTabViewItemPlaylist(
                    "Concluídos(${viewModel.finishedPlaylist.value.length})",
                    viewModel.finishedPlaylist),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabViewItemVideo(
      String headerTitle, BehaviorSubject<List<MediaCached>> stream) {
    return StreamBuilder<List<MediaCached>>(
      stream: stream,
      initialData: stream.value,
      builder: (context, snap) {
        var list = snap.data;

        return Column(
          children: [
            HeaderTitle(
              headerTitle,
              buildTag: false,
            ),
            stream.value.isEmpty || stream.value == null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 90,
                    ),
                    child: Text("Nenhuma mídia adicionada"),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 12,
                      );
                    },
                    itemBuilder: (context, index) {
                      return VideoCachedHorizontalCard(
                        list[index],
                      );
                    },
                  ),
          ],
        );
      },
    );
  }

  Widget _buildTabViewItemPlaylist(
      String headerTitle, BehaviorSubject<List<MediaCached>> stream) {
    return StreamBuilder<List<MediaCached>>(
      stream: stream,
      initialData: stream.value,
      builder: (context, snap) {
        var list = snap.data;

        return Column(
          children: [
            HeaderTitle(
              headerTitle,
              buildTag: false,
            ),
            stream.value.isEmpty || stream.value == null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 90,
                    ),
                    child: Text(
                      "Nenhum conteúdo encontrado",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            color: AppColors.secondary,
                          ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 12,
                      );
                    },
                    itemBuilder: (context, index) {
                      return VideoCachedHorizontalCard(
                        list[index],
                      );
                    },
                  ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    pickIndex = BehaviorSubject.seeded(0);
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    pickIndex.close();
    _tabController.dispose();

    super.dispose();
  }

  var pickIndex;
  TabController _tabController;
}
