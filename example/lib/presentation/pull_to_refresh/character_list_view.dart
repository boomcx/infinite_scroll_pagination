import 'package:breaking_bapp/character_summary.dart';
import 'package:breaking_bapp/remote_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CharacterListView extends StatefulWidget {
  @override
  _CharacterListViewState createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  static const _pageSize = 10;

  final PagingController<int, CharacterSummary> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    print('Future<void> _fetchPage(int pageKey) pageKey $pageKey');
    try {
      final newItems = await RemoteApi.getCharacterList(pageKey, _pageSize);

      final isLastPage = _pagingController.itemCount + newItems.length > 30;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, CharacterSummary>.separated(
          scrollController: ScrollController(),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<CharacterSummary>(
            // animateTransitions: true,
            // noMoreItemsIndicatorBuilder: (context) =>
            //     Text('noMoreItemsIndicatorBuilder'),
            // newPageErrorIndicatorBuilder: (context) =>
            //     Text('newPageErrorIndicatorBuilder'),
            // newPageProgressManualBuilder: (context) =>
            //     Text('newPageProgressManualBuilder'),
            noItemsFoundIndicatorBuilder: (context) =>
                Text('noItemsFoundIndicatorBuilder'),
            // firstPageErrorIndicatorBuilder: (context) =>
            //     Text('firstPageErrorIndicatorBuilder'),
            // newPageProgressIndicatorBuilder: (context) =>
            //     Text('newPageProgressIndicatorBuilder'),
            // firstPageProgressIndicatorBuilder: (context) =>
            //     Text('firstPageProgressIndicatorBuilder'),
            itemBuilder: (context, item, index) => SizedBox(
              height: 100,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(item.url),
                ),
                title: Text('$index----${item.author}'),
              ),
            ),
          ),
          separatorBuilder: (context, index) => const Divider(),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
