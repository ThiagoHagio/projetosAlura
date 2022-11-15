import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorNumConta = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
        backgroundColor: Color.fromARGB(255, 1, 90, 4),
      ),
      body: Column(
        children: [
          Editor(
            controlador: _controladorNumConta,
            rotulo: 'Número da Conta',
            dica: '0000',
          ),
          Editor(
            controlador: _controladorValor,
            dica: '100.00',
            icone: Icons.monetization_on,
            rotulo: 'Valor',
          ),
          ElevatedButton(
            onPressed: () => _criarTransferencia(context),
            child: Text('Confirmar'),
          ),
        ],
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

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;

  const Editor(
      {required this.controlador,
      required this.rotulo,
      required this.dica,
      this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
            labelText: rotulo,
            hintText: dica,
            icon: icone != null ? Icon(icone) : null),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatefulWidget {
  // ignore: deprecated_member_use
  final List<Transferencia?> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferencias'),
        backgroundColor: Color.fromARGB(255, 1, 90, 4),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return IntemTransferencia(transferencia!);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia?> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            if (transferenciaRecebida != null) {
              setState(() {
                widget._transferencias.add(transferenciaRecebida);
              });
            }
            ;
          });
        },
      ),
    );
  }
}

class IntemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  IntemTransferencia(this._transferencia);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text('Valor da Transferência: ' + _transferencia.valor.toString()),
      subtitle: Text('Número da Conta: ' + _transferencia.numConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numConta;

  Transferencia(this.valor, this.numConta);

  @override
  String toString() {
    return 'Transcerência: {Valor: $valor, numConta: $numConta}';
  }
}
