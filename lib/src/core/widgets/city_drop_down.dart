// import 'package:flutter/material.dart';
// import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
// import 'package:flutter_base/src/features/auth/data/models/city_model.dart';
// import 'package:flutter_base/src/features/auth/presentation/cubit/get_cities_cubit/get_cities_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// import '../../config/language/locale_keys.g.dart';
// import '../helpers/validators.dart';
// import '../shared/base_state.dart';
// import 'app_drop_down.dart';

// class CityDropDown extends StatelessWidget {
//   final String? value;
//   final Function(String?)? onChanged;

//   const CityDropDown({
//     super.key,
//     required this.value,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CityWidget(
//       value: value,
//       onChanged: onChanged,
//     );
//   }
// }

// class CityWidget extends StatefulWidget {
//   const CityWidget({
//     super.key,
//     required this.value,
//     required this.onChanged,
//   });

//   final String? value;
//   final Function(String? value)? onChanged;

//   @override
//   State<CityWidget> createState() => _CityWidgetState();
// }

// class _CityWidgetState extends State<CityWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<GetCitiesCubit, GetCitiesState>(
//       listener: (context, state) {
//         if (state.status == BaseStatus.success) {
//           if (state.cities.isNotEmpty && widget.value != null) {
//             final city = state.cities.firstWhere(
//               (element) => element.id == int.parse(widget.value!),
//               orElse: () {
//                 return CityModel(id: 0, city: '');
//               },
//             );
//             if (city.id != 0) {
//               widget.onChanged!(city.id.toString());
//             }
//           }
//         }
//       },
//       builder: (context, state) {
//         return Skeletonizer(
//           enabled: state.status == BaseStatus.loading,
//           child: AppDropdownStringValue(
//             value: widget.value,
//             validator: (value) => Validators.validateEmpty(value),
//             hint: LocaleKeys.selectFromList,
//             onChanged: widget.onChanged,
//             items: state.cities
//                 .map(
//                   (e) => DropdownMenuItem(
//                     value: e.id.toString(),
//                     child: Text(
//                       e.city,
//                       style: const TextStyle()
//                           .medium
//                           .setHintColor
//                           .s14
//                           .setFontFamily,
//                     ),
//                   ),
//                 )
//                 .toList(),
//           ),
//         );
//       },
//     );
//   }
// }
