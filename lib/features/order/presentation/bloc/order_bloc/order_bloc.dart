import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/cart/domain/usecases/delete_cart_usecase.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/order/domain/usecases/create_order_usecase.dart';
import 'package:thuongmaidientu/features/order/domain/usecases/get_count_order.dart';
import 'package:thuongmaidientu/features/order/domain/usecases/get_list_order_usecase.dart';
import 'package:thuongmaidientu/features/order/domain/usecases/update_order_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetListOrderUseCase getListOrderUseCase;
  final CreateOrderUsecase createOrderUsecase;
  final UpdateOrderUsecase updateOrderUsecase;
  final DeleteCartUsecase deleteCartUsecase;
  final GetCountOrderUseCase getCountOrderUseCase;

  OrderBloc(
      this.createOrderUsecase,
      this.getListOrderUseCase,
      this.updateOrderUsecase,
      this.deleteCartUsecase,
      this.getCountOrderUseCase)
      : super(OrderState.empty()) {
    on<GetListOrder>(_getListOrder);
    on<CreateOrder>(_createOrder);
    on<UpdateOrder>(_updateOrder);
    on<GetCountOrder>(_getCountOrder);
  }

  void _getListOrder(GetListOrder event, Emitter<OrderState> emit) async {
    final userId = event.id ?? "";
    final status = event.orderStatus;

    try {
      // Bắt đầu loading cho đúng danh sách theo status
      emit(_setLoadingState(status, isLoading: true));

      final result =
          await getListOrderUseCase.call(userId, orderStatusToString(status));

      // Cập nhật danh sách sau khi lấy xong
      emit(_setListOrderByStatus(status, result));
    } catch (e) {
      emit(_setLoadingState(status, isLoading: false));

      final message = ParseError.fromJson(e).message;
      Helper.showToastBottom(message: message);
      log(message);
    }
  }

  OrderState _setLoadingState(OrderStatus status, {required bool isLoading}) {
    switch (status) {
      case OrderStatus.pending:
        return state.copyWith(
          listOrderPending:
              state.listOrderPending.copyWith(isLoading: isLoading),
        );
      case OrderStatus.awaiting:
        return state.copyWith(
          listOrderWaiting:
              state.listOrderWaiting.copyWith(isLoading: isLoading),
        );
      case OrderStatus.delivering:
        return state.copyWith(
          listOrderDelivering:
              state.listOrderDelivering.copyWith(isLoading: isLoading),
        );
      case OrderStatus.delivered:
        return state.copyWith(
          listOrderDelivered:
              state.listOrderDelivered.copyWith(isLoading: isLoading),
        );
      case OrderStatus.cancelled:
        return state.copyWith(
          listOrderCancelled:
              state.listOrderCancelled.copyWith(isLoading: isLoading),
        );
      case OrderStatus.reviewed:
        return state.copyWith(
          listOrderReviewed:
              state.listOrderReviewed.copyWith(isLoading: isLoading),
        );
    }
  }

  OrderState _setListOrderByStatus(
      OrderStatus status, ListModel<OrderItem>? data) {
    switch (status) {
      case OrderStatus.pending:
        return state.copyWith(listOrderPending: data);
      case OrderStatus.awaiting:
        return state.copyWith(listOrderWaiting: data);
      case OrderStatus.delivering:
        return state.copyWith(listOrderDelivering: data);
      case OrderStatus.delivered:
        return state.copyWith(listOrderDelivered: data);
      case OrderStatus.cancelled:
        return state.copyWith(listOrderCancelled: data);
      case OrderStatus.reviewed:
        return state.copyWith(listOrderReviewed: data);
    }
  }

  void _createOrder(CreateOrder event, Emitter<OrderState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      for (var item in event.orders) {
        await createOrderUsecase.call(event.userId, item);
        if (event.isDeleteCart) {
          for (var product in item.productItem) {
            await deleteCartUsecase.call(item.id, event.userId, product.id);
          }
        }
      }
      emit(state.copyWith(isLoading: false));

      Helper.showToastBottom(message: "key_create_order_success".tr());
      event.onSuccess?.call();
      add(GetListOrder(orderStatus: OrderStatus.pending, id: event.userId));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      log("hihi${ParseError.fromJson(e).message}");
    }
  }

  void _updateOrder(UpdateOrder event, Emitter<OrderState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await updateOrderUsecase.call(event.userId ?? "", event.productItem);
      emit(state.copyWith(
        isLoading: false,
      ));
      add(GetListOrder(id: event.userId));

      // Helper.showToastBottom(
      //     message: "key_update_cart_success".tr(), type: ToastType.success);
    } catch (e) {
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _getCountOrder(GetCountOrder event, Emitter<OrderState> emit) async {
    try {
      final count = await getCountOrderUseCase.call(event.userId ?? "");
      emit(state.copyWith(count: count));
    } catch (e) {
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }
}
