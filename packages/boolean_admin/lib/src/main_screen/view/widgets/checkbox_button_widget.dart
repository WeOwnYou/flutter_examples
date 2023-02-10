part of 'switcher_block_card.dart';

class CheckboxButtonWidget extends StatelessWidget {
  const CheckboxButtonWidget({
    super.key,
    required this.selected,
    required this.blockId,
  });

  final bool selected;
  final String blockId;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 0,
      padding: const EdgeInsets.only(left: _buttonSize / 2),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: () {
        context.read<MainBloc>().add(
              UpdateSingleSwitcherEvent(
                blockId: blockId,
                switcherType: SwitcherType.checkboxSwitcher,
                value: !selected,
              ),
            );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _buttonSize,
            height: _buttonSize,
            margin: const EdgeInsets.only(right: _buttonPadding),
            child: Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey.withOpacity(0.5);
                }
                return AppColors.green;
              }),
              value: selected,
              onChanged: (value) {
                context.read<MainBloc>().add(
                      UpdateSingleSwitcherEvent(
                        blockId: blockId,
                        switcherType: SwitcherType.checkboxSwitcher,
                        value: !selected,
                      ),
                    );
              },
            ),
          ),
          Text(
            'Checkbox',
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w400,
              color: AppColors.mainTextBlack,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
