import 'dart:convert';

import 'package:http/http.dart';

class OpenSubtitlesFetchLang
{
  Future<List<String>> getLangs() async
  {
    Response response = await get(Uri.parse('https://stoplight.io/mocks/opensubtitles/opensubtitles-api/2781383/infos/languages'));
    Map data = jsonDecode(response.body);
    
    List<String> new_list = [];
    for (int i = 0; i < data.length; i++)
    {
      new_list.add(data[i]);
    }
    return new_list;
  }
}