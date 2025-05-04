class Failures{
  String? ErrorMessage;
  Failures({required this.ErrorMessage});
}
class errorServer  extends Failures{
  errorServer({required super.ErrorMessage});

}
class errorNetwork  extends Failures{
  errorNetwork({required super.ErrorMessage});

}