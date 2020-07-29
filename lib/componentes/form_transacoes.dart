import 'package:flutter/material.dart';

class FormularioTransacao extends StatefulWidget {
  final void Function(String, double) _adicionarTransacao;


  FormularioTransacao(this._adicionarTransacao);

  @override
  _FormularioTransacaoState createState() => _FormularioTransacaoState();
}

class _FormularioTransacaoState extends State<FormularioTransacao> {
  final controleTitulo = TextEditingController();

  final controleValor = TextEditingController();

  void _enviarFormulario() {
    final titulo = controleTitulo.text;
    final valor = double.tryParse(controleValor.text) ?? 0.0;
    
    if (titulo.isEmpty || valor<0.0)
      return;

    widget._adicionarTransacao(titulo, valor);

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
                  onSubmitted: (valor) => _enviarFormulario(),
                  decoration: InputDecoration(
                    labelText: 'Título',
                  ),
                ),
                TextField(
                  controller: controleValor,
                  keyboardType: TextInputType.numberWithOptions(decimal:true),
                  decoration: InputDecoration(
                    labelText: 'Valor',
                  ),
                  onSubmitted: (valor) => _enviarFormulario(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                        child: Text(
                          'Salvar',
                          style: TextStyle(color: Colors.purple),
                        ),
                        onPressed: _enviarFormulario)
                  ],
                ),
              ],
            )));
  }
}
