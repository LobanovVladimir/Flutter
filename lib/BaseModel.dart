import "package:scoped_model/scoped_model.dart";

class BaseModel extends Model {
  int stackIndex = 0;
  List entityList = [ ];
  var entityBeingEdited;
  late String chosenDate;

  void setChosenDate(String inDate) {
	 chosenDate = inDate;
	 notifyListeners(); // обновляет экран чтобы показать данные
  }

  void loadData(String inEntityType, dynamic inDatabase) async { // будет вызываться когда объект будет добавляться или удаляться из entityList
	 entityList = await inDatabase.getAll();
	 notifyListeners();
  }

}

