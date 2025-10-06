// import 'dart:convert';
import 'package:subtitleapp/classes/opensubtitleresults.dart';
import 'package:subtitleapp/pages/search.dart' as search;
import 'package:dio/dio.dart';
// import 'package:http/http.dart' ;

class OpenSubDownloadLinkandName
{
  String link;
  String file_name;

  OpenSubDownloadLinkandName({required this.link, required this.file_name});
}


class DownloadOpenSubtitles
{

  late List<String> resultsList;

  // Future<void> searchSubtitles() async
  // {
  //   Response response =
  //     await Dio().get(
  //       "https://api.opensubtitles.com/api/v1/subtitles",
  //       queryParameters: {'episode_number': search.userinputepisode, 'languages': search.userinputlanguage, "season_number": search.userinputseason, "query": search.userinputtitle},
  //       options: Options(
  //       headers: {
  //         'User-Agent': 'SubSearcher v0.1',
  //         'Api-Key': 'yzH9BPmZp3d587bzGcyir2JF9SzVVPrJ',
          
          
  //       },
  //     )
  //   );
    
  //   Map data = await response.data;

  //   // print(data["data"][1]["id"]);
    
  //   // print("${data["data"][0]["attributes"]["language"]}, ${data["data"][0]["attributes"]["subtitle_id"]}, ${data["data"][0]["attributes"]["files"][0]["file_name"]}, ${data["data"][0]["attributes"]["new_download_count"]}");

  //   for (int i = 0; i < data["data"].length; i++) {
  //     var files = data["data"][i]["attributes"]["files"];

  //     if (files is List && files.isNotEmpty)
  //     {
  //       search.opensubtitleresults.add(Opensubtitleresults(language: data["data"][i]["attributes"]["language"], id: data["data"][i]["attributes"]["subtitle_id"], file_name: data["data"][i]["attributes"]["files"][0]["file_name"], new_download_count: data["data"][i]["attributes"]["new_download_count"], file_id: data["data"][i]["attributes"]["files"][0]["file_id"]));
  //     }
  //   }
  // }

    Future<void> searchSubtitles() async {
    try {
      Response response = await Dio().get(
        "https://subsearcherbackend.onrender.com/subtitles",
        queryParameters: {
          'episode_number': search.userinputepisode,
          'languages': search.userinputlanguage,
          'season_number': search.userinputseason,
          'query': search.userinputtitle,
          
        },
        options: Options(
          followRedirects: true,
          headers: {
            "Api-Key": "jnVRM9kQIWonBnsS108IAk58ZcWLLukO",
            "User-Agent": "SubSearcher v1.0.0",
          },
          responseType: ResponseType.json,
        ),
      );

      

      Map data = response.data;

      // print(data);

      for (int i = 0; i < data["data"].length; i++) {
        var files = data["data"][i]["attributes"]["files"];

        if (files is List && files.isNotEmpty) {
          search.opensubtitleresults.add(
            Opensubtitleresults(
              language: data["data"][i]["attributes"]["language"],
              id: data["data"][i]["attributes"]["subtitle_id"],
              file_name: data["data"][i]["attributes"]["files"][0]["file_name"],
              new_download_count: data["data"][i]["attributes"]["new_download_count"],
              file_id: data["data"][i]["attributes"]["files"][0]["file_id"],
            ),
          );
        }
      }
    } on DioException catch (e) {
      print('${search.userinputepisode}, ${search.userinputlanguage}, ${search.userinputseason}, ${search.userinputtitle}');
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



    Future<OpenSubDownloadLinkandName> requestopensubtitle(index) async
    {
      Response response =
        await Dio().post(
          "https://api.opensubtitles.com/api/v1/download",
          data: {"file_id": search.opensubtitleresults[index].file_id},
          options: Options(
          headers: {
            'Api-Key': 'yzH9BPmZp3d587bzGcyir2JF9SzVVPrJ',
            'User-Agent': 'SubSearcher v1.0.0',
            'Accept': 'application/json',
            'Content-Type': 'application/json',

          },
        )
      );

      return OpenSubDownloadLinkandName(link: response.data["link"], file_name: response.data["file_name"]);
    }

}