import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_to_do_list/app/components/item_widget.dart';
import 'package:mobx_to_do_list/app/models/item.dart';
import 'package:mobx_to_do_list/app/screens/home/controller.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = HomeController();

  _dialog() {
    var item = Item();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Adicionar Item'),
          content: TextField(
            onChanged: item.setTitle,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Novo Item'),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                controller.addItem(item);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: controller.setFilter,
          decoration: InputDecoration(hintText: "Pesquisa..."),
        ),
        actions: <Widget>[
          IconButton(
            icon: Observer(builder: (_) {
               return Text("${controller.totalChecked}");
            },
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Observer(builder: (_) {
        return ListView.builder(
          itemCount: controller.listFiltered.length,
          itemBuilder: (_, index) {
            var item = controller.listFiltered[index];
            return ItemWidget(item: item, removeClicked: () {
              controller.removeItem(item);
            });
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _dialog();
        },
      ),
    );
  }
}
