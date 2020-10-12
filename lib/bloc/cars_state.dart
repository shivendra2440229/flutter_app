part of 'cars_bloc.dart';

abstract class CarsState extends Equatable {
  const CarsState();
}

class CarsInitial extends CarsState {
  @override
  List<Object> get props => [];
}
class CarsLoading extends CarsState{
  @override
  List<Object> get props =>null;
}
class CarsModelLoaded extends CarsState{
  final List<CarModel> carModel;
  const CarsModelLoaded(this.carModel);
  @override
  List<Object> get props =>[carModel];
}
class CarsCompanyLoaded extends CarsState{
  final List<CarCompany> carCompany;
  const CarsCompanyLoaded(this.carCompany);
  @override
  List<Object> get props =>[CarCompany];
}
