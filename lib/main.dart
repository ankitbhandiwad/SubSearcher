import 'package:flutter/material.dart';
import 'package:subtitleapp/pages/search.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import 'package:subtitleapp/services/notiservice.dart';




void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
  await Permission.notification.request();
}
  if (Platform.isAndroid || Platform.isIOS) {
  await Notiservice().initNotification();
}


    runApp(MaterialApp(
      initialRoute: '/home',
      routes:
      {
        // '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/search': (context) => Search(),

      },
    ),
  );

}

class Home extends StatelessWidget {

  

  const Home({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(12,12,21, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(12,12,21, 1),
        title: Text(
          'SubSearcher',
          style: TextStyle(
            color: Color.fromRGBO(97, 160, 225, 1),
          ),
          ),
        centerTitle:  true,
      ),
      body: Center(
        child: Column(
          
          children: 
          [
            SizedBox(height: 30),
            FilledButton.icon(
              onPressed: () 
              {
                Navigator.pushNamed(context, '/search');
              },
              style: FilledButton.styleFrom(
                backgroundColor: Color.fromRGBO(97, 160, 225, 1)
              ),
              icon: Icon(Icons.search),
              label: Text(
                'Search',
              style: TextStyle(),
              ),
            ),
            // SizedBox(height: 30),
            // ElevatedButton(
            //   onPressed: () {
            //     Notiservice().showNotification(title: "Hi", body: "hi");
            //   },
            //   child: Icon(Icons.notifications),
            // ),
            SizedBox(height: 30),
            RichText(text: TextSpan(text: 'Welcome to SubSearcher!\n\nSource Information:\n\nOpenSubtitles has a wide selection but only allows 5 downloads a day.\nGestdown has a limited selection but unlimited downloads.', style: TextStyle(
              color: Color.fromRGBO(97, 160, 225, 1),
            )),
            
            )
          ],
        ),
      ),
    );
  }
}