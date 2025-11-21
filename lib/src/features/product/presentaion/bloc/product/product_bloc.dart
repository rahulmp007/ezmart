import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/core/usecase/usecase.dart';
import 'package:ezmart/src/features/product/domain/entity/product.dart';
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

  List<Product> _allProducts = [];

  String _searchQuery = '';

  ProductBloc({
    required this.getProducts,
    required this.getProductById,
    required this.updateStock,
  }) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<RefreshProductsEvent>(_onRefreshProducts);
    on<LoadProductById>(_onLoadProductById);
    on<UpdateStock>(_onUpdateStock);

    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final res = await getProducts(NoParams());
    res.fold((l) => emit(ProductError(_mapFailureToMsg(l))), (products) {
      _allProducts = products;
      emit(ProductsLoaded(_applyFilters()));
    });
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
    final res = await updateStock(
      params: UpdateStockParams(
        productId: event.productId,
        quantity: event.newStock,
      ),
    );

    res.fold((l) => emit(ProductError(_mapFailureToMsg(l))), (_) {
      _allProducts = _allProducts.map((p) {
        if (p.id == event.productId) {
          return p.copyWith(stockRemaining: event.newStock);
        }
        return p;
      }).toList();

      if (state is ProductsLoaded) {
        emit(ProductsLoaded(_applyFilters()));
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

  void _onSearchProducts(SearchProducts event, Emitter<ProductState> emit) {
    _searchQuery = event.query;
    if (state is ProductsLoaded) {
      emit(ProductsLoaded(_applyFilters()));
    }
  }

  List<Product> _applyFilters() {
    List<Product> filtered = List.from(_allProducts);

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((p) {
        final q = _searchQuery.toLowerCase();
        return (p.title?.toLowerCase().contains(q) ?? false) ||
            (p.description?.toLowerCase().contains(q) ?? false) ||
            (p.id.toString().contains(q));
      }).toList();
    }

    return filtered;
  }
}
