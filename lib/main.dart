import 'dart:math';

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
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                  button: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ))),
        ));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Transacao> _transacoes = [];

  List<Transacao> get _transacoesRecentes {
    return _transacoes.where((elemento) {
      return (_transacoes.length == 0)
          ? List
          : elemento.data.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _abrirModalTransacao(BuildContext contexto) {
    showModalBottomSheet(
        context: contexto,
        builder: (_) {
          return FormularioTransacao(_adicionarTransacao);
        });
  }

  void _deletarTransacao(String id) {
    setState(() {
      _transacoes.removeWhere((element) => id == element.id);
    });
  }

  void _adicionarTransacao(String titulo, double valor, DateTime data) {
    Transacao novaTransacao = new Transacao(
        id: Random().nextDouble().toString(),
        titulo: titulo,
        valor: valor,
        data: data);

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
              children: <Widget>[ListaTransacoes(_transacoes, _deletarTransacao)],
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
