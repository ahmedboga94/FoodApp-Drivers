import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodappdrivers/global/global.dart';

class CartFunctions {
  static separateItemIDs() {
    List<String> separateItemIDsList = [], defaultItemsList = [];

    defaultItemsList = sharedPreferences!.getStringList("userCart")!;
    for (int i = 0; i < defaultItemsList.length; i++) {
      String item = defaultItemsList[i].toString();
      var pos = item.lastIndexOf(":");
      String getItemID = (pos != -1) ? item.substring(0, pos) : item;
      separateItemIDsList.add(getItemID);
    }
    return separateItemIDsList;
  }

  static separateItemQtys() {
    List<int> separateItemQtysList = [];
    List<String> defaultItemsList = [];

    defaultItemsList = sharedPreferences!.getStringList("userCart")!;
    for (int i = 1; i < defaultItemsList.length; i++) {
      String item = defaultItemsList[i].toString();
      List<String> listItemCharacters = item.split(":").toList();
      int qtyToNumber = int.parse(listItemCharacters[1].toString());

      separateItemQtysList.add(qtyToNumber);
    }
    return separateItemQtysList;
  }

  static clearCartNow() {
    sharedPreferences!.setStringList("userCart", ["garbageValue"]);
    List<String>? emptyList = sharedPreferences!.getStringList("userCart");
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update({"userCart": emptyList}).then((value) {
      sharedPreferences!.setStringList("userCart", emptyList!);
    });
  }
}
