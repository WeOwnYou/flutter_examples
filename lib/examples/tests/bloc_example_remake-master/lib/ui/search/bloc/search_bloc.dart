import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_api/nasa_api.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchPageEvent, SearchState> {
  SearchBloc()
      : super(const SearchState.initial()) {
    on<SearchEvent>(_onSearchEvent);
    on<ChangePage>(_onChangePage);
    on<AddKeyword>(_onAddKeyword);
    on<RemoveKeyword>(_onRemoveKeyword);
    on<SearchById>(_onSearchById);
    add(SearchEvent(''));
  }

  Future<void> _onSearchEvent(
    SearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(searching: true));
    final nasaPhotos = await NasaService.instance.searchNasaPhotos(
      searchName: event.searchString,
      pageIndex: state.pageIndex ?? 1,
      keyword: state.keyword,
    );
    return emit(
      state.copyWith(
        nasaPhotos: nasaPhotos,
        searching: false,
      ),
    );
  }

  Future<void> _onChangePage(
    ChangePage event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(searching: true));
    final nasaPhotos = await NasaService.instance.searchNasaPhotos(
      searchName: state.requestString,
      pageIndex: event.page,
      keyword: state.keyword,
    );
    return emit(
      state.copyWith(
        nasaPhotos: nasaPhotos,
        pageIndex: event.page,
        searching: false,
      ),
    );
  }

  Future<void> _onAddKeyword(
    AddKeyword event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(searching: true));
    final nasaPhotos = await NasaService.instance.searchNasaPhotos(
      searchName: state.requestString,
      pageIndex: state.pageIndex ?? 1,
      keyword: event.keyword,
    );
    return emit(
      state.copyWith(
        nasaPhotos: nasaPhotos,
        keyword: event.keyword,
        searching: false,
      ),
    );
  }

  Future<void> _onRemoveKeyword(
    RemoveKeyword event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(searching: true));
    final nasaPhotos = await NasaService.instance.searchNasaPhotos(
      searchName: state.requestString,
      pageIndex: state.pageIndex ?? 1,
    );
    return emit(
      state.copyWith(
        nasaPhotos: nasaPhotos,
        keyword: '',
        searching: false,
      ),
    );
  }

  Future<void> _onSearchById(
    SearchById event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(searching: true));
    final nasaPhoto = await NasaService.instance.searchNasaPhotos(
      searchName: '',
      nasaId: event.id,
    );
    return emit(state.copyWith(nasaPhotos: nasaPhoto, searching: false));
  }
}
