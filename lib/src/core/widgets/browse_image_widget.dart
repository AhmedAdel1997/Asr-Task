// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../config/res/constants_manager.dart';
// import '../../features/auth/domain/usecases/update_user_image.dart';
// import '../shared/cubits/browse_image_cubit/browse_image_cubit.dart';
// import 'selet_image_widget.dart';

// class BrowseImageWidget extends StatelessWidget {
//   const BrowseImageWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => BrowseImageCubit(
//           updateUserImageUseCase: sl<UpdateUserImageUseCase>()),
//       child: const BrowseImageBody(),
//     );
//   }
// }

// class BrowseImageBody extends StatelessWidget {
//   const BrowseImageBody({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BrowseImageCubit, BrowseImageState>(
//       builder: (context, state) {
//         return SeletImageWidget(
//           image: state.image,
//           status: state.status,
//           progressValue: state.progressValue,
//           currentImage: null,
//           onSuccess: () {
//             context.read<BrowseImageCubit>().updateProfileImage();
//           },
//         );
//       },
//     );
//   }
// }
