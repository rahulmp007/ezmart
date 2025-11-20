import 'dart:developer';

import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/core/usecase/usecase.dart';
import 'package:ezmart/src/features/product/domain/usecases/get_product_by_id.dart';
import 'package:ezmart/src/features/product/domain/usecases/get_products.dart';
import 'package:ezmart/src/features/product/domain/usecases/params/update_stock_params.dart';
import 'package:ezmart/src/features/product/domain/usecases/update_stock.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_event.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUsecase getProducts;
  final GetProductByIdUseCase getProductById;
  final UpdateStockUseCase updateStock;

  ProductBloc({
    required this.getProducts,
    required this.getProductById,
    required this.updateStock,
  }) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<RefreshProductsEvent>(_onRefreshProducts);
    on<LoadProductById>(_onLoadProductById);
    on<UpdateStock>(_onUpdateStock);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    log('loading   fetching paroducts again....');
    final res = await getProducts(NoParams());
    res.fold(
      (l) => emit(ProductError(_mapFailureToMsg(l))),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _onRefreshProducts(
    RefreshProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    await _onLoadProducts(LoadProducts(), emit);
  }

  Future<void> _onLoadProductById(
    LoadProductById event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final res = await getProductById(event.id);
    res.fold(
      (l) => emit(ProductError(_mapFailureToMsg(l))),
      (product) => emit(ProductLoaded(product)),
    );
  }

  Future<void> _onUpdateStock(
    UpdateStock event,
    Emitter<ProductState> emit,
  ) async {
    // Make domain call
    final res = await updateStock(
      params: UpdateStockParams(
        productId: event.productId,
        quantity: event.newStock,
      ),
    );

    res.fold((l) => emit(ProductError(_mapFailureToMsg(l))), (_) {
      // Update stock locally
      if (state is ProductsLoaded) {
        final current = (state as ProductsLoaded).products;

        final updated = current.map((p) {
          if (p.id == event.productId) {
            return p.copyWith(stockRemaining: event.newStock);
          }
          return p;
        }).toList();

        emit(ProductsLoaded(updated));
      }

      if (state is ProductLoaded) {
        final current = (state as ProductLoaded).product;

        if (current.id == event.productId) {
          emit(ProductLoaded(current.copyWith(stockRemaining: event.newStock)));
        }
      }
    });
  }

  String _mapFailureToMsg(AppError failure) => failure.message;
}
