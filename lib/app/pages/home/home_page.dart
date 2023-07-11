import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery_app/app/pages/home/home_controller.dart';
import 'package:delivery_app/app/pages/home/widgets/delivery_product_tile.dart';
import 'package:delivery_app/app/pages/home/widgets/shopping_bag_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    controller.loadProducts();
    super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DeliveryAppbar(),
        // floatingActionButton: FloatingActionButton(onPressed: () async {
        // showLoader();
        // await Future.delayed(const Duration(seconds: 2));
        // hideLoader();
        // showError('Erro ao criar produtos');
        // }),
        body: BlocConsumer<HomeController, HomeState>(
          listener: (context, state) {
            if (state.status == HomeStateStatus.loading) {
              showLoader();
            } else if (state.status != HomeStateStatus.loading) {
              hideLoader();
            }

            if (state.status == HomeStateStatus.error) {
              showError(state.errorMessage ?? 'Erro não informado');
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      final orders = state.shoppingBag
                          .where((order) => order.product == product);

                      return DeliveryProductTile(
                        product: product,
                        orderProduct: orders.isNotEmpty ? orders.first : null,
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: state.shoppingBag.isNotEmpty,
                  child: ShoppingBagWidget(bag: state.shoppingBag),
                ),
              ],
            );
          },
        ));
  }
}
