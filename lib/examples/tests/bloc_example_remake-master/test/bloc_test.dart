import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_repository/hive_repository.dart' as hive_repository;
import 'package:mockito/mockito.dart';
import 'package:user_repository/user_repository.dart' as user_repository;
import 'package:vedita_learning2/ui/bottom_nav_bar/bloc/main_screen_bloc.dart';
import 'package:vedita_learning2/ui/home/bloc/home_bloc.dart';

class MockHiveRepository extends Mock implements hive_repository.HiveRepository {
  //TODO Необходимо задать вывод методов (when не катит) (исправить)
  @override
  Stream<hive_repository.StorageStatus> get status
  {
    return Stream.fromIterable(
              [hive_repository.StorageStatus.loading, hive_repository.StorageStatus.hasData],);
  }
}

class MockUserRepository extends Mock implements user_repository.UserRepository {
  @override
  Future<user_repository.User> getUser() async => const user_repository.User(id: '21');
}

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
      'emits state with Categories.myTasks or Categories.inProgress when matching event added',
      build: HomeBloc.new,
      act: (bloc) => bloc
        ..add(const ChangeCategory(Categories.myTasks))
        ..add(const ChangeCategory(Categories.inProgress)),
      expect: () => <HomePageState>[
        homeBloc.state.copyWith(category: Categories.myTasks),
        homeBloc.state.copyWith(category: Categories.inProgress),
      ],
    );

    blocTest<HomeBloc, HomePageState>(
      'emits state with certain index, when page is changing',
      build: HomeBloc.new,
      act: (bloc) => bloc
        ..add(const ChangeSelectedDot(0))
        ..add(const ChangeSelectedDot(2)),
      expect: () => <HomePageState>[
        homeBloc.state.copyWith(selectedDotIndex: 0),
        homeBloc.state.copyWith(selectedDotIndex: 2),
      ],
    );
  });

  group('MainBloc test', () {
    late final MockHiveRepository mockHiveRepository;
    late final MockUserRepository mockUserRepository;
    late final MainBloc mainBloc;
    setUp(() {
      mockHiveRepository = MockHiveRepository();
      mockUserRepository = MockUserRepository();
      mainBloc = MainBloc(
          userRepository: mockUserRepository,
          hiveRepository: mockHiveRepository,);
    });

    blocTest<MainBloc, MainScreenState>('Multiple task received test',
        build: ()=>mainBloc,
        setUp: () {
          // when(mockHiveRepository.tasks).thenAnswer(
          //   (_) => [
          //     Task(
          //       title: '',
          //       taskStartTime: TimeOfDay.now(),
          //       taskEndTime: TimeOfDay.now(),
          //       type: TaskTypes.bde,
          //       dateTime: DateTime.now(),
          //     ),
          //     Task(
          //       title: '',
          //       taskStartTime: TimeOfDay.now(),
          //       taskEndTime: TimeOfDay.now(),
          //       type: TaskTypes.bde,
          //       dateTime: DateTime.now(),
          //     ),
          //   ],
          // );
          // when(mockHiveRepository.status).thenReturn(Stream.fromIterable(
          //       [StorageStatus.loading, StorageStatus.hasData],),
          // );
        },
        // act: (bloc)=>bloc.add()
        // expect: () => <MainScreenState>[
        //       MainScreenState.loading(),
        //     ],
    );
  });
}
