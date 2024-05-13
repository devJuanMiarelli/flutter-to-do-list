import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício - Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaTarefasHomePage(),
    );
  }
}

class ListaTarefasHomePage extends StatefulWidget {
  @override
  _ListaTarefasHomePageState createState() => _ListaTarefasHomePageState();
}

class _ListaTarefasHomePageState extends State<ListaTarefasHomePage> {
  List<String> _tarefas = [];

  void _adicionarTarefa(String nomeTarefa) {
    setState(() {
      _tarefas.add(nomeTarefa);
    });
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  void _exibirFormulario() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _tarefa = TextEditingController();
        return AlertDialog(
          title: Text('Crie uma Tarefa'),
          content: TextField(
            controller: _tarefa,
            decoration: InputDecoration(labelText: 'Nome'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _adicionarTarefa(_tarefa.text);
                Navigator.of(context).pop();
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste suas tarefas'),
      ),
      body: ListView.builder(
        itemCount: _tarefas.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_tarefas[index]),
            onDismissed: (direction) {
              _removerTarefa(index);
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20.0),
            ),
            child: ListTile(
              title: Text(_tarefas[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _exibirFormulario,
        tooltip: 'Crie uma tarefa',
        child: Icon(Icons.add),
      ),
    );
  }
}
