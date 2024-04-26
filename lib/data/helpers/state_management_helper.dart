
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providerList = [
BlocProvider(create: (context) => AuthBloc(),)


];