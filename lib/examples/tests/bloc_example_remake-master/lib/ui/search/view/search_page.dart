import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_api/nasa_api.dart';
import 'package:vedita_learning2/app_settings/app_colors.dart';
import 'package:vedita_learning2/navigation/router.dart';
import 'package:vedita_learning2/ui/search/bloc/search_bloc.dart';
import 'package:vedita_learning2/ui/search/widgets/nasa_card_widget.dart';
import 'package:vedita_learning2/ui/widgets/widgets.dart';

class SearchPage extends StatelessWidget{
  final String keyword;
  const SearchPage({
    Key? key,
    this.keyword = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageLoading =
        context.select<SearchBloc, bool>((bloc) => bloc.state.searching);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _BuildTitle(),
          const _BuildSearch(),
          if (pageLoading)
            const _BuildScrollingCardsShimmer()
          else
            const _BuildScrollingCards(),
        ],
      ),
    );
  }
}

class _BuildTitle extends StatelessWidget {
  const _BuildTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      backgroundColor: AppColors.backgroundColor,
      floating: true,
      centerTitle: true,
      title: Text(
        'NASA gallery',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

class _BuildSearch extends StatelessWidget {
  const _BuildSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addEvent = context.read<SearchBloc>().add;
    final keyword = context.select<SearchBloc, String>(
      (bloc) => bloc.state.keyword,
    );
    return SliverToBoxAdapter(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.greyColor,
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(70)),
              ),
              onChanged: (searchString) {
                addEvent(SearchEvent(searchString));
              },
            ),
            if (keyword == '')
              const SizedBox.shrink()
            else
              RawChip(
                onDeleted: () {
                  addEvent(RemoveKeyword());
                },
                label: Text(
                  '#$keyword',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BuildScrollingCards extends StatelessWidget {
  const _BuildScrollingCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nasaPhotos = context
        .select<SearchBloc, List<NasaPhoto>>((bloc) => bloc.state.nasaPhotos);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return GestureDetector(
            onTap: () {
              AppRouter.instance()
                  .push(DetailsRoute(nasaId: nasaPhotos[index].nasaId));
            },
            child: NasaImageCardWidget(nasaPhoto: nasaPhotos[index]),
          );
        },
        childCount: nasaPhotos.length,
      ),
    );
  }
}

class _BuildScrollingCardsShimmer extends StatelessWidget {
  const _BuildScrollingCardsShimmer({Key? key}) : super(key: key);

  Widget _generateCard(double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Container(
        height: height * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerWidget(height: height * 0.31),
            Padding(
              padding:
                  EdgeInsets.only(top: height * 0.018, left: width * 0.018),
              child: ShimmerWidget(
                width: width * 0.9,
                height: height * 0.02,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: height * 0.018, left: width * 0.018),
              child: ShimmerWidget(
                width: width * 0.9,
                height: height * 0.02,
              ),
            ),
            // borderRadius:
            // const BorderRadius.vertical(top: Radius.circular(20)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, __) => _generateCard(width, height),
        childCount: 2,
      ),
    );
  }
}
