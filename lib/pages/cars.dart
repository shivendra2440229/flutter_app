import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/cars_bloc.dart';
import 'package:flutter_app/data/car_model.dart';
import 'package:flutter_app/data/cars_repository.dart';
import 'package:flutter_app/data/car_company.dart';
import 'package:flutter_app/pages/cars_model_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../drawer.dart';
class Cars extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
            title: Text("Car Companies")
        ),
        body: CarsPage(),

    );
  }
}
class CarsPage extends StatefulWidget {
  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {

  @override
  Widget build(BuildContext context) {
    final carsBloc = BlocProvider.of<CarsBloc>(context);
    carsBloc.add(CarsCompany());
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: BlocBuilder<CarsBloc,CarsState>(
        builder: (context,state){
          if(state is CarsInitial){
            return buildLoading();

          } else if(state is CarsLoading){
            return buildLoading();
          }else if(state is CarsCompanyLoaded){
            return buildCompanyLoaded(context , state.carCompany);
          }
//          else if(state is CarsModelLoaded){
//            final carsBloc = BlocProvider.of<CarsBloc>(context);
//            carsBloc.add(CarsCompany());
//            return Container();
//          }
          else {
            return Container();
          };
        },
      ),
    );
  }

  Widget buildInitial(){
    return Container();
  }
  Widget buildLoading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final carsBloc = BlocProvider.of<CarsBloc>(context);
    carsBloc.add(CarsCompany());

//    BlocProvider.of<CarsBloc>(context)..add(CarsModel(widget.model_id));
  }

  Widget buildCompanyLoaded(BuildContext context,List<CarCompany> carCompany){
      return ListView.builder(
        itemCount: carCompany.length,

        itemBuilder: (context,index){
          final item = carCompany[index];
          return

            ListTile(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  maintainState: true,
                  builder:(_) => BlocProvider.value(
                    value: BlocProvider.of<CarsBloc>(context),
                    child: CarModelPage(model_id : item.id,company_name: item.company,),
                ),),
              );
//              final carsBloc = BlocProvider.of<CarsBloc>(context);
//              carsBloc.add(CarsModel(item.id));
            },
            title: Center(child:Text(item.company,style:TextStyle(fontSize: 24))),
          );
        });
  }

  @override
  void initState() {
  }
}



