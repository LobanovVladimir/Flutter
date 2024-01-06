import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
import "utils.dart" as utils;
import 'dart:io';

void main() {
	 startMeUp() async {
	 	 Directory docsDir =
	 	 	 await getApplicationDocumentsDirectory(); // также есть другой метод getExternalStorageDirectory(). Возвращает путь к хранилищу где можно записывать и хранить данные
	 	 utils.docsDir = docsDir; // но это для долговременного хранения для быстрого используем getTemporaryDirectory
	 	 runApp(const FlutterBook());
}
	 startMeUp();
}

class FlutterBook extends StatelessWidget {
  const FlutterBook({super.key});
 // 166 страница
	 @override
  Widget build(BuildContext inContext) {
    return MaterialApp(
	 	 	 home : DefaultTabController(
	 	 	 	  length : 4,
          child : Scaffold(
            appBar : AppBar(
              title : const Text("FlutterBook"),
              bottom : const TabBar(
                  tabs : [
                    Tab(icon : Icon(Icons.date_range),
                      text : "Appointments"),
                    Tab(icon : Icon(Icons.contacts),
                      text : "Contacts"),
                    Tab(icon : Icon(Icons.note),
                      text : "Notes"),
                    Tab(icon : Icon(Icons.assignment_turned_in),
                      text : "Tasks")
                  ]
                )
	 	 	 	 	  ),
	 	 	 	 	  body : TabBarView(
	 	 	 	 	 	 children : [
	 	 	 	 	 	 	 Appointments(), Contacts(), Notes(), Tasks()
						]
					)
				)
			)
	 	 );
}
}
