import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vedita_learning2/ui/home/bloc/home_bloc.dart';

void main() {
  group('HomeBloc test', () {
    late HomeBloc homeBloc;
    setUp(() {
      homeBloc = HomeBloc();
    });

    test('Initial state is Initial', () {
      expect(homeBloc.state, const HomePageState.initial());
    });

    blocTest<HomeBloc, HomePageState>(
      'emits Categories.inProgress and myTasks when changedCategoryInProgress or MyTasks',
      build: HomeBloc.new,
      act: (bloc) => bloc
        ..add(const ChangeCategory(Categories.myTasks))
        ..add(const ChangeCategory(Categories.inProgress)),
      expect: () => <HomePageState>[
        homeBloc.state.copyWith(category: Categories.myTasks),
        homeBloc.state.copyWith(category: Categories.inProgress),
      ],
    );
  });
}
