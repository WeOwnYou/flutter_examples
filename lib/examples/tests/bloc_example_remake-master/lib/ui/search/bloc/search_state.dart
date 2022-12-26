part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String requestString;
  final String nasaId;
  final int? pageIndex;
  final String keyword;
  final bool searching;
  final List<NasaPhoto> nasaPhotos;

  const SearchState._({
    this.requestString = '',
    this.nasaId = '',
    this.pageIndex = 1,
    this.keyword = '',
    this.searching = true,
    this.nasaPhotos = const [],
  });

  const SearchState.initial() : this._();
  const SearchState.search({
    String? keyword,
    String? nasaId,
    int? pageIndex,
    required String requestString,
  }) : this._(
          requestString: requestString,
          nasaId: nasaId??'',
          pageIndex: pageIndex ?? 1,
          keyword: keyword ?? '',
          searching: true,
        );

  SearchState copyWith({
    String? requestString,
    int? pageIndex,
    String? keyword,
    bool? searching,
    List<NasaPhoto>? nasaPhotos,
  }) {
    return SearchState._(
      requestString: requestString ?? this.requestString,
      pageIndex: pageIndex ?? this.pageIndex,
      keyword: keyword ?? this.keyword,
      searching: searching ?? this.searching,
      nasaPhotos: nasaPhotos ?? this.nasaPhotos,
    );
  }

  @override
  List<Object?> get props =>
      [requestString, pageIndex, keyword, searching, nasaPhotos];
}
