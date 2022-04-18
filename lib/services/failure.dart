class Failure {
  // Use something like "int code;" if you want to translate error messages
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
class FailureService{
  late Failure _failure;
  Failure get failure => _failure;

  Future<void> setFailure(Failure failure)async {
    _failure = failure;
  }

}