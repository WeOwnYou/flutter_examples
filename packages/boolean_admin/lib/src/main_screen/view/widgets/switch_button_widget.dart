part of 'switcher_block_card.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
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
                switcherType: SwitcherType.simpleSwitcher,
                value: !selected,
              ),
            );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Switch name',
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w400,
              color: AppColors.mainTextBlack,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            width: _buttonPadding,
          ),
          SizedBox(
            height: _buttonSize,
            child: AspectRatio(
              aspectRatio: 24 / 14,
              child: Switch.adaptive(
                value: selected,
                activeColor: AppColors.green,
                onChanged: (_) {
                  context.read<MainBloc>().add(
                        UpdateSingleSwitcherEvent(
                          blockId: blockId,
                          switcherType: SwitcherType.simpleSwitcher,
                          value: !selected,
                        ),
                      );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
