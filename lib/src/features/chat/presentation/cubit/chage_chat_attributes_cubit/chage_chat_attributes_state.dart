part of 'chage_chat_attributes_cubit.dart';

final class ChageChatAttributesState extends Equatable {
  final BaseStatus status;
  final List<AssetGenImage> backgroundList;
  final AssetGenImage selectedBackground;

  final List<Color> colorList;
  final Color selectedColor;

  const ChageChatAttributesState({
    required this.status,
    required this.backgroundList,
    required this.selectedBackground,
    required this.colorList,
    required this.selectedColor,
  });

  factory ChageChatAttributesState.initial() => ChageChatAttributesState(
        status: BaseStatus.initial,
        backgroundList: [
          AppAssets.images.firstBg,
          AppAssets.images.secondBg,
          AppAssets.images.secondBg,
          AppAssets.images.firstBg,
          AppAssets.images.firstBg,
          AppAssets.images.secondBg,
        ],
        selectedBackground: AppAssets.images.firstBg,
        colorList: const [
          Color(0xffC5048E),
          Color(0xff6C52FF),
          Color(0xffFFDD00),
          Color(0xffFF5852),
          Color(0xff00A4B6),
          Color(0xff009022),
        ],
        selectedColor: const Color(0xff6C52FF),
      );

  ChageChatAttributesState copyWith({
    BaseStatus? status,
    List<AssetGenImage>? backgroundList,
    AssetGenImage? selectedBackground,
    List<Color>? colorList,
    Color? selectedColor,
  }) {
    return ChageChatAttributesState(
      status: status ?? this.status,
      backgroundList: backgroundList ?? this.backgroundList,
      selectedBackground: selectedBackground ?? this.selectedBackground,
      colorList: colorList ?? this.colorList,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  @override
  List<Object> get props =>
      [status, backgroundList, selectedBackground, colorList, selectedColor];
}
