import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/car_company.dart';
import 'package:flutter_app/data/car_model.dart';
import 'package:flutter_app/data/cars_repository.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final CarsRepository carsRepository;
  CarsBloc(this.carsRepository) : super(CarsInitial());
  @override
  CarsState get initialState => CarsLoading();

  @override
  Stream<CarsState> mapEventToState(
    CarsEvent event,
  ) async* {
      yield CarsLoading();
    if (event is CarsCompany){
      final carCompany = await carsRepository.fetchCarCompany();
      yield CarsCompanyLoaded(carCompany);
    } else if (event is CarsModel) {
      final carModel = await carsRepository.fetchCarModel(event.model_id);
      yield CarsModelLoaded(carModel);
    }

    // TODO: implement mapEventToState
  }
}
