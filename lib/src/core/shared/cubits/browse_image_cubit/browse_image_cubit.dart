// import 'dart:io';

// import 'package:equatable/equatable.dart';
// import 'package:flutter_base/src/core/widgets/custom_messages.dart';
// import 'package:flutter_base/src/features/auth/domain/usecases/update_user_image.dart';
// import 'package:flutter_base/src/features/auth/presentation/cubit/profile_cubit/profile_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../config/res/constants_manager.dart';
// import '../../../helpers/image_helper.dart';
// import '../../../network/api_endpoints.dart';
// import '../../../network/network_request.dart';
// import '../../../network/network_service.dart';
// import '../../base_state.dart';

// part 'browse_image_state.dart';

// class BrowseImageCubit extends Cubit<BrowseImageState> {
//   BrowseImageCubit({required this.updateUserImageUseCase})
//       : super(BrowseImageState.initial());

//   final UpdateUserImageUseCase updateUserImageUseCase;

//   Future<void> updateProfileImage() async {
//     final image0 = await ImageHelper.pickImage();
//     emit(state.copyWith(image: image0));
//     if (image0 != null) {
//       final image = state.image;
//       if (image != null) {
//         emit(state.copyWith(status: BaseStatus.loading, image: image));
//         final NetworkRequest networkRequest = NetworkRequest(
//           path: ApiConstants.profileImage,
//           method: RequestMethod.post,
//           body: {
//             "_method": 'PUT',
//             "file": image,
//           },
//           onSendProgress: (count, total) {
//             emit(state.copyWith(progressValue: (count / total), image: image));
//           },
//         );
//         final result = await sl<NetworkService>().callApi<String>(
//           networkRequest,
//           mapper: (json) => json['profile_pic'],
//         );
//         MessageUtils.showSnackBar(result.message);
//         sl<ProfileCubit>().setProfileImage(result.data);

//         emit(state.copyWith(status: BaseStatus.success, image: null));
//       }
//     }
//   }

//   // Future<void> selectImage({
//   //   required UploadType uploadType,
//   // }) async {
//   //   if (uploadType == UploadType.profileImage) {
//   //     updateProfileImage();
//   //   } else {
//   //     uploadFile(
//   //       path: ApiConstants.profileImage,
//   //       onSuccess: () {},
//   //     );
//   //   }
//   // }

//   void removeImage() {
//     emit(state.copyWith(image: null));
//   }
// }
