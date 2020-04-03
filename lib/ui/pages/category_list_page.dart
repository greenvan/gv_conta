import 'package:flutter/material.dart';
import 'package:gvconta/model/category.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/system/i18n.dart';
import 'package:gvconta/system/user_provider.dart';
import 'package:gvconta/ui/widgets/category_banner.dart';
import 'package:gvconta/ui/widgets/dynamic_treeview.dart';
import 'package:gvconta/system/db.dart' as db;
import 'package:gvconta/ui/widgets/loading.dart';
import 'package:gvconta/ui/widgets/red_error.dart';

class CategoryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

    var labels = I18n.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(labels.categories + ': ' + user.name),
      ),
      body: SingleChildScrollView(
        child: UserProvider(
          user: user,
          child: Column(
            children: <Widget>[
              CategoryBanner(
                  title: labels.expenses, type: 'expenses', user: user),
              _buildCategoryStreamBuilder(db.getExpenseList(user.uid)),
              CategoryBanner(
                  title: labels.incomes, type: 'incomes', user: user),
              _buildCategoryStreamBuilder(db.getIncomeList(user.uid)),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<List<Category>> _buildCategoryStreamBuilder(
      Stream<List<Category>> categoryStream) {
    /* categoryStream.listen((onData) {
      print('Something happened');
      print(onData);
    });*/
    return StreamBuilder(
      stream: categoryStream,
      builder: (context, AsyncSnapshot<List<Category>> snapshot) {
        if (snapshot.hasError) {
          return RedError(snapshot.error);
        }
        if (!snapshot.hasData) {
          return Loading();
        }

        return DynamicTreeView(
          data: snapshot.data, //getCategoryList(snapshot.data),
          config: Config(
            parentTextStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            rootId: "1",
            parentPaddingEdgeInsets:
                EdgeInsets.only(left: 8, top: 0, bottom: 0),
            childrenPaddingEdgeInsets:
                EdgeInsets.only(left: 16, top: 0, bottom: 0),
            //showAddIconButton: false,
            //showEditIconButton: false,
            //showDeleteIconButton: false,
          ),
          onTap: (m) {
            print("onChildTap -> $m");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => ScreenTwo(
                          data: m,
                        )));
          },

          onAddPressed: (m) {
            displayAddDialog(
              context: context,
              category: Category(
                parentId: m['id'], //La nueva categoría la tendrá como padre
                extras: m['extra'], //mismos extras que el padre
              ),
              user: UserProvider.of(context).user,
              title: I18n.of(context).addCategory,
            );
          },

          onEditPressed: (m) {
            displayEditDialog(
              context: context,
              category: Category(
                id: m['id'],
                name: m['title'],
                parentId: m['parent_id'], //no es necesario
                extras: m['extra'],
              ),
              user: UserProvider.of(context).user,
              title: I18n.of(context).editCategory,
            );
          },
          onDeletePressed: (m) {
            displayDeleteDialog(
              context: context,
              category: Category(
                id: m['id'],
                name: m['title'],
                parentId: m['parent_id'], //no es necesario
                extras: m['extra'],
              ),
              user: UserProvider.of(context).user,
              title: I18n.of(context).deleteCategory,
            );
          },
          width: MediaQuery.of(context).size.width,
        );
      },
    );
  }
}

/*
List<BaseData> getCategoryList(List<Category> categories) {
  List<BaseData> categoryList = [
    Category(
      id: '1',
      name: 'Root',
      parentId: '-1',
      extras: {'key': 'extradata1'},
    )
  ];
  categoryList.addAll(categories);
  return categoryList;
}
*/
class ScreenTwo extends StatelessWidget {
  final Map data;
  ScreenTwo({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${data['title']}"),
      ),
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              "ID: ${data['id']}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              "PARENT-ID ${data['parent_id']}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              "EXTRAS: ${data['extra']}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

displayAddDialog(
    {BuildContext context,
    String oldValue,
    String title,
    Category category,
    User user}) async {
  TextEditingController _textFieldController =
      new TextEditingController(text: oldValue);
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: _textFieldController,
            decoration:
                InputDecoration(hintText: I18n.of(context).enterName + ": "),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(I18n.of(context).ADD),
              onPressed: () {
                category.name = _textFieldController.text;

                if (category.extras['type'] == 'expenses') {
                  db.addExpense(user, category);
                } else {
                  db.addIncome(user, category);
                }
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(I18n.of(context).CANCEL),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

displayEditDialog(
    {BuildContext context, String title, Category category, User user}) async {
  final TextEditingController _textFieldController =
      new TextEditingController(text: category.getTitle());
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: _textFieldController,
            decoration:
                InputDecoration(hintText: I18n.of(context).enterName + ": "),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(I18n.of(context).EDIT),
              onPressed: () {
                category.name =
                    _textFieldController.text; //Debe tener como extras type

                db.updateCategoryName(user, category);
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(I18n.of(context).CANCEL),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

displayDeleteDialog(
    {BuildContext context, String title, Category category, User user}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(I18n.of(context).confirmDeleteCategory),
          actions: <Widget>[
            new FlatButton(
              child: new Text(I18n.of(context).DELETE),
              onPressed: () {
                //TODO: no permitir la eliminación si tiene hijos

                db.deleteCategory(user, category);
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(I18n.of(context).CANCEL),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
