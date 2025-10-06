import 'package:http/http.dart';
import 'package:subtitleapp/classes/subtitleinput.dart';
import 'package:subtitleapp/pages/search.dart' as search;
import 'dart:convert';
import 'package:subtitleapp/classes/subtitleresults.dart';



class Gestdownsearcher
{
  Future<List<Map>> GetGestResults(Subtitleinput input) async
  {
    try {
          Response response = await get(Uri.parse('https://api.gestdown.info/subtitles/find/${input.language}/${input.title}/${input.seasonnumber}/${input.episodenumber}'));
          // print('Response body: \'${response.body}\'');
          Map data = jsonDecode(response.body);
          // print(data);
          

          return [data];
        } on Exception catch (e) 
        {
            print('could not get data from api: $e');
            
            return [];
        }
  }

    void fillGestData()
  {

    search.data = Gestdownsearcher().GetGestResults(Subtitleinput(language: search.userinputlanguage, title: search.userinputtitle, seasonnumber: search.userinputseason, episodenumber: search.userinputepisode));
  }
  
  Future<void> fillGestResults() async
  {
    List<Map> temp = await search.data;
    for (int i = 0; i < temp[0]['matchingSubtitles'].length; i++)
    {
      
      search.results.add(SubtitleResults(language: temp[0]['matchingSubtitles'][i]['language'], title: temp[0]['episode']['title'], downloadCount: (temp[0]['matchingSubtitles'][i]['downloadCount']).toString(), uploaddate: temp[0]['matchingSubtitles'][i]['discovered'], subtitleid: temp[0]['matchingSubtitles'][i]['subtitleId']));
      // print(temp[0]['matchingSubtitles'][i]['subtitleid']);
    }
    // print(results);
  }



}