import 'package:flutter/material.dart';
import 'package:gvconta/model/category.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/system/user_provider.dart';
import 'package:gvconta/widgets/category_banner.dart';
import 'package:gvconta/widgets/dynamic_treeview.dart';
import 'package:gvconta/system/db.dart' as db;
import 'package:gvconta/widgets/loading.dart';
import 'package:gvconta/widgets/red_error.dart';

class CategoryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Categorias: ' + user.name),
      ),
      body: Column(
        children: <Widget>[
          CategoryBanner(title: 'Gastos', isExpense: true, user: user),
          _buildCategoryStreamBuilder(db.getExpenseList(user.uid)),
          CategoryBanner(
              title: 'Ingresos',
              isExpense: false,
              user: user), //TODO: buscar otra manera
          _buildCategoryStreamBuilder(db.getIncomeList(user.uid)),
        ],
      ),
    );
  }

  StreamBuilder<List<Category>> _buildCategoryStreamBuilder(
      Stream<List<Category>> categoryStream) {
    categoryStream.listen((onData) {
      print('Something happened');
    });
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
          data: getCategoryList(snapshot.data),
          config: Config(
            parentTextStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            rootId: "1",
            parentPaddingEdgeInsets:
                EdgeInsets.only(left: 8, top: 0, bottom: 0),
            childrenPaddingEdgeInsets:
                EdgeInsets.only(left: 16, top: 0, bottom: 0),
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
          width: MediaQuery.of(context).size.width,
        );
      },
    );
  }
}

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
