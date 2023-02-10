part of 'switcher_block_card.dart';

class RadioButtonWidget extends StatelessWidget {
  final bool value;
  final bool selected;
  final String blockId;
  const RadioButtonWidget({
    super.key,
    required this.value,
    required this.selected,
    required this.blockId,
  });

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
                switcherType: SwitcherType.radioSwitcher,
                value: value,
              ),
            );
      },
      child: Row(
        children: [
          Container(
            width: _buttonSize,
            height: _buttonSize,
            margin: const EdgeInsets.only(right: _buttonPadding),
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Radio<bool>(
              value: value,
              groupValue: selected,
              activeColor: AppColors.green,
              onChanged: (a) {
                context.read<MainBloc>().add(
                      UpdateSingleSwitcherEvent(
                        blockId: blockId,
                        switcherType: SwitcherType.radioSwitcher,
                        value: value,
                      ),
                    );
              },
            ),
          ),
          Text(
            'Radio ${value ? 1 : 2}',
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
