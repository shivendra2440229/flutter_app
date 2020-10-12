part of 'cars_bloc.dart';

abstract class CarsEvent extends Equatable {
  const CarsEvent();
}
class CarsCompany extends CarsEvent{
  @override
  List<Object> get props =>null;
}
class CarsModel extends CarsEvent{
  final String model_id;

  const CarsModel(this.model_id);

  @override
  List<Object> get props => [model_id];
}
