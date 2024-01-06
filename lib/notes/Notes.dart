import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "NotesDBWorker.dart"; // Чтобы мы могли загрузить заметки
import "NotesList.dart"; // исходный код для 2 экранов 
import "NotesEntry.dart"; // Запись новой строки я так полагаю
import "NotesModel.dart" show NotesModel, notesModel; // модель для заметок? Зачем?

class Notes extends StatelessWidget {

  Notes() {
    notesModel.loadData("notes", NotesDBWorker.db);
  }

  Widget build(BuildContext inContext) {
	 return ScopedModel<NotesModel>(
	 	 model : notesModel,
	 	 child : ScopedModelDescendant<NotesModel>(
	 	 	 builder : (BuildContext inContext, Widget? inChild,NotesModel inModel) 
          { 
            return IndexedStack(
              index : inModel.stackIndex,
              children : [ NotesList(), NotesEntry() ]
            );
          }
		  )
	  );
  }
}