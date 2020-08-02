import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormularioTransacao extends StatefulWidget {
  final void Function(String, double, DateTime) _adicionarTransacao;

  FormularioTransacao(this._adicionarTransacao);

  @override
  _FormularioTransacaoState createState() => _FormularioTransacaoState();
}

class _FormularioTransacaoState extends State<FormularioTransacao> {
  final controleTitulo = TextEditingController();

  final controleValor = TextEditingController();
  DateTime _data_selecionada;
  void _enviarFormulario() {
    final titulo = controleTitulo.text;
    final valor = double.tryParse(controleValor.text) ?? 0.0;
    if (titulo.isEmpty || valor < 0.0) return;

    widget._adicionarTransacao(titulo, valor,
        (_data_selecionada == null) ? DateTime.now() : _data_selecionada);
  }

  _mostrarDatas() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((_data_pega) {
      setState(() {
        _data_selecionada = _data_pega;
      });
    });
  }

  Widget build(BuildContext contexto) {
    return Card(
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: controleTitulo,
                  decoration: InputDecoration(
                    labelText: 'Título',
                  ),
                ),
                TextField(
                  controller: controleValor,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Valor',
                  ),
                  onSubmitted: (valor) => _enviarFormulario(),
                ),
                Container(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('Data selecionada: '),
                    FlatButton(
                      child: Text(
                        (_data_selecionada == null ||
                                _data_selecionada.day == DateTime.now().day)
                            ? 'Hoje'
                            : DateFormat('d/M/y').format(_data_selecionada),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: _mostrarDatas,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Salvar',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: _enviarFormulario)
                  ],
                ),
              ],
            )));
  }
}
