import 'package:boolean_admin/src/main_screen/bloc/main_bloc.dart';
import 'package:boolean_admin/src/main_screen/view/widgets/custom_progress_indicator.dart';
import 'package:boolean_admin/src/main_screen/view/widgets/switcher_block_card.dart';
import 'package:boolean_admin/src/res/app_colors.dart';
import 'package:boolean_admin/src/res/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final alwaysScrollableBouncingPhysics =
        const AlwaysScrollableScrollPhysics()
            .applyTo(const BouncingScrollPhysics());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: AppConstants.mainHorizontalPaddingRatio * width,
        leading: const SizedBox.shrink(),
        centerTitle: false,
        title: Text(
          'List',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w600,
            color: AppColors.mainTextBlack,
            fontSize: 32,
          ),
        ),
      ),
      body: CustomProgressIndicator(
        onRefresh: context.read<MainBloc>().forceUpdate,
        indicatorSize: height * AppConstants.mainVerticalPaddingRatio * 2,
        verticalPadding: height * AppConstants.mainVerticalPaddingRatio,
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            return ListView.separated(
              physics: alwaysScrollableBouncingPhysics,
              itemBuilder: (ctx, index) {
                return SwitcherBlockCard(
                  switcherBlock: state.switcherBlocks[index],
                );
              },
              separatorBuilder: (ctx, index) {
                return SizedBox(
                  height: height * 0.03125,
                );
              },
              itemCount: state.switcherBlocks.length,
            );
          },
        ),
      ),
    );
  }
}
