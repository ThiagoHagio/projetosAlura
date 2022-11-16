import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Criando Transferência';
const _rotuloConta = 'Número da Conta';
const _rotuloValor = 'Valor';
const _dicaConta = '0000';
const _dicaValor = '100.00';
const _buttonText = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorNumConta = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
        //backgroundColor: Color.fromARGB(255, 1, 90, 4),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controlador: _controladorNumConta,
              rotulo: _rotuloConta,
              dica: _dicaConta,
            ),
            Editor(
              controlador: _controladorValor,
              rotulo: _rotuloValor,
              dica: _dicaValor,
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              onPressed: () => _criarTransferencia(context),
              child: Text(_buttonText),
            ),
          ],
        ),
      ),
    );
  }

  void _criarTransferencia(BuildContext context) {
    final int? numConta = int.tryParse(_controladorNumConta.text);
    final double? valor = double.tryParse(_controladorValor.text);
    if (numConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
