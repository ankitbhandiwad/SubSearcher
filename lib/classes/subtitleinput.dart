class Subtitleinput
{
  String language;
  String title;
  int? seasonnumber;
  int? episodenumber;
  
  

  Subtitleinput({ required this.language, required String title, required this.seasonnumber, required this.episodenumber}): title = title.replaceAll(' ', "%20");
  
}