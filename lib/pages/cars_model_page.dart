import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/cars_bloc.dart';
import 'package:flutter_app/data/car_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarModelPage extends StatefulWidget {
  String model_id,company_name;

  CarModelPage({Key key, @required this.model_id,@required this.company_name}) : super(key: key);

  @override
  _CarModelPageState createState() => _CarModelPageState();
}

class _CarModelPageState extends State<CarModelPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final carsBloc = BlocProvider.of<CarsBloc>(context);
            carsBloc.add(CarsCompany());
            Navigator.pop(context);
        },child: Scaffold(
        appBar: AppBar(title: Text("Car Model for ${widget.company_name}")),

        body: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: BlocBuilder<CarsBloc, CarsState>(builder: (context, state) {
              print("state $state");
              if (state is CarsInitial) {
                return buildInitial();
              } else if (state is CarsLoading) {
                return buildLoading();
              } else if (state is CarsModelLoaded) {
                return buildModelLoaded(context, state.carModel);
              }
              else return  Container();
            }))));
  }

  Widget buildInitial() {
    return Container();
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildModelLoaded(BuildContext context, List<CarModel> carModel) {
    return ListView.builder(
        itemCount: carModel.length,
        itemBuilder: (context, index) {
          final item = carModel[index];
          return ListTile(
            title: Center(child:Text(item.name,style:TextStyle(fontSize: 24))),
          );
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<CarsBloc>(context)..add(CarsModel(widget.model_id));
  }

//  @override
//  void initState() {
//    super.initState();
//   final carBloc =  BlocProvider.of<CarsBloc>(context);
//   carBloc.add(CarsModel(widget.model_id));
//  }
}
