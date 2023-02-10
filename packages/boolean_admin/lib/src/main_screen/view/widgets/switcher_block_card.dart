import 'package:boolean_admin/src/main_screen/bloc/main_bloc.dart';
import 'package:boolean_admin/src/res/app_colors.dart';
import 'package:boolean_admin/src/res/app_constants.dart';
import 'package:boolean_admin_repository/boolean_admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

part 'checkbox_button_widget.dart';
part 'radio_button_widget.dart';
part 'switch_button_widget.dart';

const _buttonSize = 14.0;
const _buttonPadding = 9.0;

class SwitcherBlockCard extends StatelessWidget {
  final SwitcherBlock switcherBlock;
  const SwitcherBlockCard({
    required this.switcherBlock,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4.0,
            color: Color.fromRGBO(182, 188, 196, 0.25),
          ),
        ],
      ),
      child: Column(
        children: [
          ColoredBox(
            color: AppColors.secondBgGrey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * AppConstants.mainHorizontalPaddingRatio,
                vertical: height * 0.03125,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    switcherBlock.name,
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondTextBlack,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'id: ${switcherBlock.id}',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGrey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * AppConstants.mainHorizontalPaddingRatio,
              vertical: height * AppConstants.mainVerticalPaddingRatio,
            ),
            child: SizedBox(
              height: 0.22 * height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SwitchWidget(
                    selected: switcherBlock.simpleSwitcherState,
                    blockId: switcherBlock.id,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: AppConstants.mainHorizontalPaddingRatio * width,
                        ),
                        child: RadioButtonWidget(
                          value: true,
                          selected: switcherBlock.radioSwitcherState,
                          blockId: switcherBlock.id,
                        ),
                      ),
                      RadioButtonWidget(
                        value: false,
                        selected: switcherBlock.radioSwitcherState,
                        blockId: switcherBlock.id,
                      ),
                    ],
                  ),
                  CheckboxButtonWidget(
                    selected: switcherBlock.checkboxSwitcherState,
                    blockId: switcherBlock.id,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
