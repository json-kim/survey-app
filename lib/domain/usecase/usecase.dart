abstract class UseCase<DataType, ParamType> {
  Future<DataType> call(ParamType param);
}
