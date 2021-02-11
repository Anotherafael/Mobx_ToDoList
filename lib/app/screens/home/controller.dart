import 'package:mobx/mobx.dart';
import 'package:mobx_to_do_list/app/models/item.dart';
part 'controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  
  @observable
  ObservableList<Item> listItems = [
    Item(title: "Aprender Flutter", check: true),
    Item(title: "Praticar PHP", check: true),
    Item(title: "Bater", check: false),
  ].asObservable();

  @computed
  int get totalChecked => listItems.where((item) => item.check == true).length;
  
  @computed
  List<Item> get listFiltered {
    if (filter.isEmpty) {
      return listItems;
    } else {
      return listItems.where((item) => item.title.contains(filter)).toList();
    }
  }

  @observable
  String filter = '';

  @action
  setFilter(String value) => filter = value;


  @action
  addItem (Item item) {
    listItems.add(item);
  }

  @action
  removeItem (Item model) {
    listItems.removeWhere((item) => item.title == model.title);
  }
}