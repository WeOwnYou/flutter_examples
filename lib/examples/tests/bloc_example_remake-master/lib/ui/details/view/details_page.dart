import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_api/nasa_api.dart';
import 'package:vedita_learning2/navigation/router.dart';
import 'package:vedita_learning2/ui/search/bloc/search_bloc.dart';

class DetailsPage extends StatelessWidget {
  final String nasaId;

  const DetailsPage({
    Key? key,
    @PathParam('id') required this.nasaId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nasaPhoto = context.select<SearchBloc, NasaPhoto>((bloc) =>
    bloc.state.nasaPhotos
        .where((photo) => photo.nasaId == nasaId)
        .first,);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                    tag: nasaId,
                    child: ClipRRect(
                      child: Image.network(nasaPhoto.link),
                    ),
                  ),
                  _BuildImageDescription(
                    photo: nasaPhoto,
                  ),
                ],
              ),
            ),
    );
  }
}

class _BuildImageDescription extends StatelessWidget {
  final NasaPhoto photo;
  const _BuildImageDescription({Key? key, required this.photo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BuildDetailTextWidget(
          text: photo.title,
          isTitle: true,
        ),
        _BuildDetailTextWidget(text: photo.description),
        Wrap(
          children: [
            ...List.generate(photo.keywords.length, (index) {
              final tag = photo.keywords[index];
              return Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ChoiceChip(
                  label: Text(
                    '#$tag',
                    overflow: TextOverflow.ellipsis,
                  ),
                  selected: false,
                  onSelected: (_) {
                    context.read<SearchBloc>().add(AddKeyword(tag));
                    AppRouter.instance().navigate(SearchRoute());
                  },
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}

class _BuildDetailTextWidget extends StatelessWidget {
  final String? text;
  final bool isTitle;
  const _BuildDetailTextWidget({
    Key? key,
    required this.text,
    this.isTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Center(
              child: Text(
                text!,
                style: TextStyle(
                  fontWeight: isTitle ? FontWeight.bold : null,
                  fontSize: 20,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
