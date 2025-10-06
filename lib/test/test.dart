import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



Future<void> searchSubtitles() async {
  await dotenv.load(fileName: ".env");
  final apiKey = dotenv.env['API_KEY'];
    try {
      Response response = await Dio().get(
        "https://subsearcherbackend.onrender.com/subtitles",
        queryParameters: {
          'episode_number': 1,
          'languages': 'en',
          'season_number': 1,
          'query': 'squid',
          
        },
        options: Options(
          followRedirects: true,
          headers: {
            "Api-Key": apiKey,
            "User-Agent": "SubSearcher v1.0.0",
          },
          responseType: ResponseType.json,
        ),
      );

      

      Map data = response.data;

      print(data);

      for (int i = 0; i < data["data"].length; i++) {
        var files = data["data"][i]["attributes"]["files"];

//         if (files is List && files.isNotEmpty) {
//           search.opensubtitleresults.add(
//             Opensubtitleresults(
//               language: data["data"][i]["attributes"]["language"],
//               id: data["data"][i]["attributes"]["subtitle_id"],
//               file_name: data["data"][i]["attributes"]["files"][0]["file_name"],
//               new_download_count: data["data"][i]["attributes"]["new_download_count"],
//               file_id: data["data"][i]["attributes"]["files"][0]["file_id"],
//             ),
//           );
//         }
      }
    } on DioException catch (e) {
//       print('${search.userinputepisode}, ${search.userinputlanguage}, ${search.userinputseason}, ${search.userinputtitle}');
      print("DioException caught:");
      print("Status Code: ${e.response?.statusCode}");
      print("Headers: ${e.response?.headers}");
      print("Data: ${e.response?.data}");
      print("Request: ${e.requestOptions}");
      print("Error Type: ${e.type}");
      print("Message: ${e.message}");
      print("RequestOptions:");
      print("URI: ${e.requestOptions.uri}");
      print("Method: ${e.requestOptions.method}");
      print("Headers: ${e.requestOptions.headers}");
      print("Query Parameters: ${e.requestOptions.queryParameters}");
      print("Path: ${e.requestOptions.path}");
      print("Data: ${e.requestOptions.data}");
      // print(e.response?.headers);
    }
  }

void main()
 {
  searchSubtitles();
}