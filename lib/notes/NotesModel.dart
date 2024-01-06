import "../BaseModel.dart";

class Note 
{  // экземляры этого класса - заметки
  late int id;
  late String title;
  late String content;
  late String color; //цвет для задания фона
    String toString() 
    {
      return "{ id=$id, title=$title, "
      "content=$content, color=$color }";
    } 
}


class NotesModel extends BaseModel{
 late String color;
	void setColor(String inColor) {
	 	color = inColor;
	 	notifyListeners();
  }
}

NotesModel notesModel = NotesModel();
