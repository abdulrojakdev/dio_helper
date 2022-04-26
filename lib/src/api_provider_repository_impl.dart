// /*
// Developer: Lakhani kamlesh
// Create Date: 20-11-21 3:41
// */
//
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:dio_helper_flutter/dio_helper.dart';
//
// import 'api_provider_repository.dart';
//
// class ApiProviderImpl implements ApiProviderRepository {
//   final DioHelper dioHelper;
//
//   ApiProviderImpl({required this.dioHelper});
//
//   @override
//   Future getApi(String pathUrl, {Map<String, dynamic>? queryParameter}) async {
//     return await dioHelper.request(pathUrl,
//         queryParameter: queryParameter, dioMethod: DioMethod.get);
//   }
//
//   @override
//   Future imageUpload(String pathUrl, {required FormData formData}) async {
//     return await dioHelper.request(pathUrl, data: formData);
//   }
//
//   @override
//   Future postApi(String pathUrl,
//       {Map<String, dynamic>? queryParameters,
//       data,
//       Map<String, dynamic>? header}) async {
//     return await dioHelper.request(
//       pathUrl,
//       data: data,
//       queryParameter: queryParameters,
//       header: header,
//       dioMethod: DioMethod.post,
//     );
//   }
//
//   @override
//   void imageUploadMap(String pathUrl,
//       {Map<String, dynamic>? imageUploadParameter}) {
//     FormData formData = FormData.fromMap(imageUploadParameter!);
//     imageUploadParameter.forEach((key, value) async {
//       if ((value) is File) {
//         //create multipart using filepath, string or bytes
//         MapEntry<String, MultipartFile> pic = MapEntry(
//             key,
//             MultipartFile.fromFileSync(value.path,
//                 filename: value.path.split('/').last));
//         formData.files.add(pic);
//       } else if ((value) is List<File>) {
//         List<MapEntry<String, MultipartFile>> files = [];
//         value.forEach((element) async {
//           MapEntry<String, MultipartFile> pic = MapEntry(
//               key,
//               MultipartFile.fromFileSync(element.path,
//                   filename: element.path.split('/').last));
//           files.add(pic);
//         });
//         formData.files.addAll(files);
//       }
//     });
//   }
// }
