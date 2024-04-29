part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}
class GetProducts extends ProductsEvent{
  final String query;

  GetProducts({required this.query});
}