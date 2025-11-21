import 'package:ezmart/src/core/network/api_client.dart';
import 'package:ezmart/src/core/network/api_constants.dart';
import 'package:ezmart/src/core/network/error_handler.dart';
import 'package:ezmart/src/features/product/data/model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
  Future<ProductModel> fetchProductById(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await apiClient.get(
        url: '${ApiConstants.baseUrl}/${ApiConstants.products}',
      );
      final data = response as List;
      return data
          .map(
            (e) => ProductModel.fromJson(
              e as Map<String, dynamic>,
            ).copyWith(stockRemaining: 50),
          )
          .toList();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<ProductModel> fetchProductById(int id) async {
    throw UnimplementedError();
  }
}
