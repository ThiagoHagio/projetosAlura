class Transferencia {
  final double valor;
  final int numConta;

  Transferencia(this.valor, this.numConta);

  @override
  String toString() {
    return 'Transcerência: {Valor: $valor, numConta: $numConta}';
  }
}
