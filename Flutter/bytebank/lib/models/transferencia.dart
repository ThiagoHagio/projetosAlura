class Transferencia {
  final double valor;
  final int numConta;

  Transferencia(this.valor, this.numConta);

  @override
  String toString() {
    return 'TranscerĂȘncia: {Valor: $valor, numConta: $numConta}';
  }
}
