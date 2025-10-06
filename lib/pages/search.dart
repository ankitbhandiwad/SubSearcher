import 'package:flutter/material.dart';
import 'package:subtitleapp/classes/opensubtitleresults.dart';
// import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:subtitleapp/classes/subtitleresults.dart';
// import 'package:http/http.dart';
// import 'dart:convert';
// import 'package:subtitleapp/classes/subtitleinput.dart';
import 'package:dio/dio.dart' hide Response;
import 'package:file_picker/file_picker.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:subtitleapp/services/notiservice.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:subtitleapp/services/opensubtitlesdownloader.dart';
import 'package:subtitleapp/classes/gestdownsearcher.dart';

String mode = 'null';

List<Opensubtitleresults> opensubtitleresults = 
  [
    
  ];

List<SubtitleResults> results =
  [
    // SubtitleResults(language: 'EN', title: 'Horimiya S01E01', downloadCount: '1220', uploaddate: '01-22-2024'),
  ];

late Future<List<Map>> data;

String userinputtitle = "";
String userinputlanguage = '';
int? userinputseason;
int? userinputepisode;


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  
  String? selectedDirectory = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      backgroundColor: const Color.fromRGBO(12,12,21, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(12,12,21, 1),
        actions: [
          
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 4, 0),
            child: ElevatedButton( //OPENSUBTITLES SEARCH BUTTON
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(97, 160, 225, 1),
              ),
              onPressed: ()
              {
                mode = 'opensubtitles';
                setState(() {});
            
                showDialog(
                    context: context,
                    builder: (BuildContext context)
                    {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setDialongState)
                        {
                        return AlertDialog
                        (
                          backgroundColor: Color.fromRGBO(97, 160, 225, 1),
                          title: Text("Enter Show Details", style: TextStyle(color: Color.fromRGBO(12,12,21, 1))),
                          content: Column
                          (
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: 
                            [
                              TextField
                              (
                                decoration: InputDecoration
                                (
                                  hintText: "Title of Show", hintStyle: TextStyle(color: Color.fromRGBO(12,12,21, 1)),
                                ),
                                onChanged: (value)
                                {
                                  userinputtitle = value;
                                  setState(() {});
                                }
                              ),
                              Row(
                                children: 
                                [
                                  Flexible(
                                    child: TextField
                                    (
                                      decoration: InputDecoration
                                      (
                                        hintText: "Season", hintStyle: TextStyle(color: Color.fromRGBO(12,12,21, 1))
                                      ),
                                      keyboardType: TextInputType.numberWithOptions(),
                                      onChanged: (value)
                                      {
                                        userinputseason = int.tryParse(value) ?? 1;
                                        setState(() {
                                          
                                        });
                                      }
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Flexible(
                                    child: TextField
                                    (
                                      decoration: InputDecoration
                                      (
                                        hintText: "Episode", hintStyle: TextStyle(color: Color.fromRGBO(12,12,21, 1))
                                      ),
                                      keyboardType: TextInputType.numberWithOptions(),
                                      onChanged: (value)
                                      {
                                        userinputepisode = int.tryParse(value) ?? 1;
                                        setState(() {
                                          
                                        });
                                      }
                                      
                                    ),
                                  ),
                                ]
                              ),
                              TextField
                              (
                                decoration: InputDecoration
                                (
                                  hintText: "Language: 'en', 'zh'", hintStyle: TextStyle(color: Color.fromRGBO(12,12,21, 1))
                                ),
                                onChanged: (value)
                                {
                                  userinputlanguage = value;
                                  setState(() {
                                    
                                  });
                                }
                              ),
                              
                              
                            ],
                          ),
                          actions:
                          [
                            Center(
                              child: ElevatedButton( //choose folder
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(97, 160, 225, 1),
                                  ),
                                  onPressed: () async
                                  {
                                    selectedDirectory = await FilePicker.platform.getDirectoryPath();
                                    setState(() {
                                      
                                    });
                                    setDialongState(() {});
                                  },
                                  child: Icon(Icons.folder, color: Color.fromRGBO(12,12,21, 1),),
                                ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                              [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(97, 160, 225, 1)
                                  ),
                                  onPressed: () {Navigator.of(context).pop();}, child: Text("Cancel", style: TextStyle(color: Color.fromRGBO(12,12,21, 1)),)), //CANCEL BUTTON
                                SizedBox(width: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(97, 160, 225, 1),
                                  ),
                                  onPressed: selectedDirectory != null ? () async { //opensub SUBMIT BUTTON
                        
                                    opensubtitleresults.clear();
                                    results.clear();
                                    setState(() {});
                                    await DownloadOpenSubtitles().searchSubtitles();
                                    // print(data);
                                    
                                    if (mounted) {
                                    Navigator.of(context).pop();
                                    }
                                    userinputtitle = "";
                                    userinputlanguage = '';
                                    userinputseason = null;
                                    userinputepisode = null;
                                    setState(() {});
                                }
                                : null,
                                child: Text("Submit", style: TextStyle(color: Color.fromRGBO(12,12,21, 1)))),
                                
                              ],
                            ),
                          ],
                        );
                      }
                    );
                  }
                );
              },
              child: Row(
                children: [
                  Icon(Icons.search_sharp),
                  Text('OpenSubtitles')
                ],
              ),
            
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(4, 0, 8, 0),
            child: ElevatedButton(
              //THIS IS THE GESTDOWN SEARCH BUTTON
              
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(97, 160, 225, 1),
              ),
              onPressed: () {
                  mode = 'gestdown';
                  setState(() {});
                  showDialog(
                    context: context,
                    builder: (context)
                    {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setDialongState)
                        {
                          return AlertDialog
                        (
                          backgroundColor: Color.fromRGBO(97, 160, 225, 1),
                          title: Text("Enter Show Details", style: TextStyle(color: Color.fromRGBO(12,12,21, 1))),
                          content: Column
                          (
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: 
                            [
                              TextField
                              (
                                decoration: InputDecoration
                                (
                                  hintText: "Title of Show", hintStyle: TextStyle(color: Color.fromRGBO(12,12,21, 1)),
                                ),
                                onChanged: (value)
                                {
                                  userinputtitle = value;
                                  setState(() {});
                                }
                              ),
                              Row(
                                children: 
                                [
                                  Flexible(
                                    child: TextField
                                    (
                                      decoration: InputDecoration
                                      (
                                        hintText: "Season", hintStyle: TextStyle(color: Color.fromRGBO(12,12,21, 1))
                                      ),
                                      keyboardType: TextInputType.numberWithOptions(),
                                      onChanged: (value)
                                      {
                                        userinputseason = int.tryParse(value) ?? 1;
                                        setState(() {
                                          
                                        });
                                      }
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Flexible(
                                    child: TextField
                                    (
                                      decoration: InputDecoration
                                      (
                                        hintText: "Episode", hintStyle: TextStyle(color: Color.fromRGBO(12,12,21, 1))
                                      ),
                                      keyboardType: TextInputType.numberWithOptions(),
                                      onChanged: (value)
                                      {
                                        userinputepisode = int.tryParse(value) ?? 1;
                                        setState(() {
                                          
                                        });
                                      }
                                      
                                    ),
                                  ),
                                ]
                              ),
                              TextField
                              (
                                decoration: InputDecoration
                                (
                                  hintText: "Language: 'English', 'Chinese'", hintStyle: TextStyle(color: Color.fromRGBO(12,12,21, 1))
                                ),
                                onChanged: (value)
                                {
                                  userinputlanguage = value;
                                  setState(() {
                                    
                                  });
                                }
                              ),
                              
                              
                            ],
                          ),
                          actions:
                          [
                            Center(
                              child: ElevatedButton( //choose folder
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(97, 160, 225, 1),
                                  ),
                                  onPressed: () async
                                  {
                                    selectedDirectory = await FilePicker.platform.getDirectoryPath();
                                    setState(() {
                                      
                                    });
                                    setState(() {
                                        
                                      });
                                      setDialongState(() {});
                                  },
                                  child: Icon(Icons.folder, color: Color.fromRGBO(12,12,21, 1),),
                                ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                              [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(97, 160, 225, 1)
                                  ),
                                  onPressed: () {Navigator.of(context).pop();}, child: Text("Cancel", style: TextStyle(color: Color.fromRGBO(12,12,21, 1)),)), //CANCEL BUTTON
                                SizedBox(width: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(97, 160, 225, 1),
                                  ),
                                  onPressed: selectedDirectory != null ? () async { //GEST SUBMIT BUTTON
                                  results.clear();
                                  opensubtitleresults.clear();
                                  setState(() {});
                                  Gestdownsearcher().fillGestData();
                                  setState(() {});
                                  await Gestdownsearcher().fillGestResults();
                                  setState(() {});
                                  // print(data);
                                  userinputtitle = "";
                                  userinputlanguage = '';
                                  userinputseason = null;
                                  userinputepisode = null;
                                  Navigator.of(context).pop();
                                }
                                : null,
                                child: Text("Submit", style: TextStyle(color: Color.fromRGBO(12,12,21, 1)))),
                              ],
                            ),
                          ],
                        );
                      }
                    );
                  }
                );
              },
              child: Row(
                children: [
                  Icon(Icons.search),
                  Text('Gestdown'),
                ],
              ),
            ),
          ),
          
        ],
      ),
      body: SafeArea
      (
        child: Padding(
        padding: EdgeInsets.all(2),
          child: ListView.builder(
            itemCount: mode == 'gestdown' ? results.length : opensubtitleresults.length,
            itemBuilder: (context, index)
            {
              if (mode == 'gestdown') {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Color.fromRGBO(97, 160, 225, 1),
                    child: ListTile(
                      onTap: () async {
                        //download the file
                        await Dio().download("https://api.gestdown.info/subtitles/download/${results[index].subtitleid}", "$selectedDirectory/${results[index].title}.srt");
                        
                        Notiservice().showNotification(title: "File Downloaded", body: "Location: $selectedDirectory/${results[index].title}.srt");
                        Fluttertoast.showToast(
                          msg: "File Downloaded: $selectedDirectory/${results[index].title}.srt",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color.fromRGBO(97, 160, 225, 1),
                          textColor: Color.fromRGBO(12,12,21, 1),
                          fontSize: 16.0
                        );
                      },
                      leading: Icon(Icons.usb),
                      title: Text(results[index].title),
                      subtitle: Text('${results[index].downloadCount}'),
                    ),
                  ),
                );

              }
              else if (mode == 'opensubtitles')
              {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Color.fromRGBO(97, 160, 225, 1),
                    child: ListTile(
                      onTap: () async {
                        //download the file
                        // await Dio().download("https://api.gestdown.info/subtitles/download/${results[index].subtitleid}", "$selectedDirectory/${results[index].title}.srt");
                        
                        OpenSubDownloadLinkandName linkandName = await DownloadOpenSubtitles().requestopensubtitle(index);

                        await Dio().download(linkandName.link, "$selectedDirectory/${opensubtitleresults[index].file_name}.srt");

                        Notiservice().showNotification(title: "File Downloaded", body: "Location: $selectedDirectory/${opensubtitleresults[index].file_name}.srt");
                        Fluttertoast.showToast(
                          msg: "File Downloaded: $selectedDirectory/${opensubtitleresults[index].file_name}.srt",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color.fromRGBO(97, 160, 225, 1),
                          textColor: Color.fromRGBO(12,12,21, 1),
                          fontSize: 16.0
                        );
                      },
                      leading: Icon(Icons.usb),
                      title: Text(opensubtitleresults[index].file_name),
                      subtitle: Text('${opensubtitleresults[index].language}'),
                    ),
                  ),
                );
              }
              else
              {
                return Padding(
                  padding: EdgeInsets.all(2),
                  child: Text("You broke the app!")
                );
              }
            }
          ),
        ),
      ),
    );
  }
}