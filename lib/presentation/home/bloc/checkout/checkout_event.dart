part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = _Started;
  //add item
  const factory CheckoutEvent.addItem(Product product) = _AddItem;
  //remove item
  const factory CheckoutEvent.removeItem(Product product) = _RemoveItem;

  //add discount
  const factory CheckoutEvent.addDiscount(Discount discount) = _AddDiscount;
  //remove discount
  const factory CheckoutEvent.removeDiscount(String category) = _RemoveDiscount;  // Modified
  //add tax
  const factory CheckoutEvent.addTax(int tax) = _AddTax;
  //add service charge
  const factory CheckoutEvent.addServiceCharge(int serviceCharge) =
      _AddServiceCharge;
  //remove tax
  const factory CheckoutEvent.removeTax() = _RemoveTax;
  //remove service charge
  const factory CheckoutEvent.removeServiceCharge() = _RemoveServiceCharge;    

  //save draft order
  const factory CheckoutEvent.saveDraftOrder(
      int tableNumber, String draftName, int discountAmount) = _SaveDraftOrder;

  //load draft order
  const factory CheckoutEvent.loadDraftOrder(DraftOrderModel data) =
      _LoadDraftOrder;
}
