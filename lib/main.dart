import 'package:despesas/componentes/form_transacoes.dart';
import 'package:despesas/componentes/grafico.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'componentes/lista_transacoes.dart';
import 'modelos/transacao.dart';

main() => runApp(AppDespesas());

class AppDespesas extends StatelessWidget {
  Widget build(BuildContext contexto) {
    return MaterialApp(
        home: Home(),
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.yellow,
          fontFamily: 'IconsolataExpanded',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'DancingScript',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.red))),
        ));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Transacao> _transacoes = [
    Transacao(
        id: '1',
        titulo: 'Conta 1',
        valor: 50.50,
        data: DateTime.now().subtract(Duration(days: 3))),
    Transacao(
        id: '2',
        titulo: 'Conta 2',
        valor: 100,
        data: DateTime.now().subtract(Duration(days: 5))),
    Transacao(
        id: '2',
        titulo: 'Conta 3',
        valor: 200,
        data: DateTime.now().subtract(Duration(days: 10))),
  ];

  List<Transacao> get _transacoesRecentes {
    return _transacoes.where((elemento) {
      return elemento.data.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _abrirModalTransacao(BuildContext contexto) {
    showModalBottomSheet(
        context: contexto,
        builder: (_) {
          return FormularioTransacao(_adicionarTransacao);
        });
  }

  void _adicionarTransacao(String titulo, double valor) {
    Transacao novaTransacao = new Transacao(
        id: _transacoes.length.toString(),
        titulo: titulo,
        valor: valor,
        data: DateTime.now());

    setState(() {
      _transacoes.add(novaTransacao);
    });

    Navigator.of(context).pop();
  }

  Widget build(BuildContext contexto) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'Despesas Pessoais',
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _abrirModalTransacao(contexto),
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Grafico(_transacoesRecentes),
            Column(
              children: <Widget>[ListaTransacoes(_transacoes)],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _abrirModalTransacao(contexto),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
