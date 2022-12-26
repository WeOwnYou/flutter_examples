import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedita_learning2/ui/search/bloc/search_bloc.dart';

class SearchEmptyPage extends AutoRouter implements AutoRouteWrapper {
  const SearchEmptyPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (ctx) => SearchBloc(),
      child: this,
    );
  }
}
