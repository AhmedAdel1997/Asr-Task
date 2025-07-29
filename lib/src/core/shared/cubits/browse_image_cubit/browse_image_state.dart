// part of 'browse_image_cubit.dart';

// final class BrowseImageState extends Equatable {
//   final BaseStatus status;
//   final File? image;
//   final double progressValue;

//   const BrowseImageState({
//     required this.status,
//     required this.image,
//     required this.progressValue,
//   });

//   factory BrowseImageState.initial() => const BrowseImageState(
//         status: BaseStatus.initial,
//         image: null,
//         progressValue: 0.0,
//       );

//   BrowseImageState copyWith({
//     BaseStatus? status,
//     File? image,
//     double? progressValue,
//   }) {
//     return BrowseImageState(
//       status: status ?? this.status,
//       progressValue: progressValue ?? this.progressValue,
//       image: image,
//     );
//   }

//   @override
//   List<Object> get props => [
//         status,
//         progressValue,
//         image ?? -1,
//       ];
// }
