import 'package:gvconta/widgets/dynamic_treeview.dart';

class Category implements BaseData {
  final int id;
  final int parentId;
  String name;
  //String fullpath;

  ///Any extra data you want to get when tapped on children
  Map<String, dynamic> extras;

  Category({this.id, this.parentId, this.name, this.extras});
  @override
  String getId() {
    return this.id.toString();
  }

  @override
  Map<String, dynamic> getExtraData() {
    return this.extras;
  }

  @override
  String getParentId() {
    return this.parentId.toString();
  }

  @override
  String getTitle() {
    return this.name;
  }
}
