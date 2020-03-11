import 'package:flutter/material.dart';
import 'package:gvconta/model/category.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/widgets/navigation_arguments.dart';
import 'package:gvconta/widgets/dynamic_treeview.dart';

class CategoryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

    //TODO ver si necesitamos un evento o no

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Categorias:' + user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: DynamicTreeView(
            data: getData(),
            config: Config(
                parentTextStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                rootId: "1",
                parentPaddingEdgeInsets:
                    EdgeInsets.only(left: 16, top: 0, bottom: 0)),
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
          ),
        ),
      ),
    );
  }
}

//TODO: sacar los datos de la base de datos

List<BaseData> getData() {
  return [
    Category(
      id: 1,
      name: 'Root',
      parentId: -1,
      extras: {'key': 'extradata1'},
    ),
    Category(
      id: 2,
      name: 'Gastos',
      parentId: 1,
      extras: {'key': 'extradata2'},
    ),
    Category(
      id: 3,
      name: 'Transporte',
      parentId: 2,
      extras: {'key': 'extradata3'},
    ),
    Category(
      id: 4,
      name: 'Comida',
      parentId: 2,
      extras: {'key': 'extradata4'},
    ),
    Category(
      id: 5,
      name: 'Ingresos',
      parentId: 1,
      extras: {'key': 'extradata5'},
    ),
    Category(
      id: 6,
      name: 'Sueldo',
      parentId: 5,
      extras: {'key': 'extradata6'},
    ),
    Category(
      id: 7,
      name: 'Loteria',
      parentId: 5,
      extras: {'key': 'extradata7'},
    ),
    Category(
      id: 8,
      name: 'Combustible',
      parentId: 3,
      extras: {'key': 'extradata8'},
    ),
    Category(
      id: 9,
      name: 'Creditrans',
      parentId: 3,
      extras: {'key': 'extradata9'},
    ),
    Category(
      id: 10,
      name: 'Autopista',
      parentId: 3,
      extras: {'key': 'extradata10'},
    ),
    Category(
      id: 11,
      name: 'Comidas Fuera',
      parentId: 4,
      extras: {'key': 'extradata11'},
    ),
    Category(
      id: 12,
      name: 'Supermercado',
      parentId: 4,
      extras: {'key': 'extradata12'},
    ),
    Category(
      id: 13,
      name: 'UPV',
      parentId: 6,
      extras: {'key': 'extradata13'},
    ),
    Category(
      id: 14,
      name: 'clases',
      parentId: 6,
      extras: {'key': 'extradata14'},
    ),
    Category(
      id: 15,
      name: 'Miravalles',
      parentId: 14,
      extras: {'key': 'extradata15'},
    ),
    Category(
      id: 16,
      name: 'Izaskun',
      parentId: 14,
      extras: {'key': 'extradata16'},
    ),
  ];
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
