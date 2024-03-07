import 'package:schmitt/src/core/models/order_model.dart';


abstract class PackageRemoteDataSource {
  Future<PackageModel> getPackages();

}
