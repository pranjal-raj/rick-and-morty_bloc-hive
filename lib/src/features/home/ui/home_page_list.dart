import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../common/data/models/character_model.dart';
import '../../common/ui/character_card.dart';
import '../bloc/home_bloc.dart';

class PagedList extends StatefulWidget {
  final Bloc bloc;
  const PagedList({required this.bloc, super.key});

  @override
  State<PagedList> createState() => _PagedListState();
}

class _PagedListState extends State<PagedList> {
  final _pagingController =
      PagingController<int, CharacterModel>(firstPageKey: 1);
  static const _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      widget.bloc.add(HomeEndOfCharacterListReachedEvent(page: pageKey));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: widget.bloc as HomeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case (const (HomeNewPagesAddedState)):
            {
              debugPrint("yo");
              _updateList((state as HomeNewPagesAddedState).characterList,
                  state.pageKey);
            }
          default:
        }
      },
      builder: (context, state) {
        return Container(
            child: PagedListView(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate(itemBuilder: (
            context,
            character,
            index,
          ) {
            return CharacterCard(
                character: character as CharacterModel,
                bloc: HomeBloc(),
                onLikePressed: () {
                  debugPrint(character.name);
                  widget.bloc.add(HomeCharacterFavouriteClickedEvent(
                      characterList: _pagingController.itemList!,
                      index: index));
                });
          }),
        ));
      },
    );
  }

  Future<void> _updateList(
      List<CharacterModel> characterListNew, int pageKey) async {
    try {
      final isLastPage = characterListNew.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(characterListNew);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(characterListNew, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
