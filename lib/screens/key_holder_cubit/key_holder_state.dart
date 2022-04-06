part of 'key_holder_cubit.dart';

@immutable
class KeyHolderState extends Equatable {
  final GlobalKey mainScrollKey;

  final GlobalKey firstImageWindowKey;
  final GlobalKey firstImageWindowBottomKey;

  final GlobalKey secondImageWindowKey;
  final GlobalKey secondImageWindowBottomKey;

  final GlobalKey thirdImageWindowKey;
  final GlobalKey thirdImageWindowBottomKey;

  final GlobalKey fourthImageWindowKey;

  final GlobalKey aboutKey;
  final GlobalKey pricingKey;
  final GlobalKey integrationKey;
  final GlobalKey faqsKey;

  final GlobalKey paymentImageKey;
  final GlobalKey businessImageKey;
  final GlobalKey notificationImageKey;
  final GlobalKey receiptImageKey;

  final GlobalKey pricingTitleKey;
  final GlobalKey pricingInfoKey;

  final GlobalKey brainKey;
  final GlobalKey registerKey;
  final GlobalKey invoiceKey;
  final GlobalKey piggyBankKey;
  final GlobalKey freeKey;
  final GlobalKey coinsKey;

  final GlobalKey dashboardLaptopImageKey;
  final GlobalKey dashboardEmployeeImageKey;
  final GlobalKey dashboardSalesImageKey;
  final GlobalKey dashboardComplementImageKey;

  final GlobalKey faqsIntegrationImageKey;
  final GlobalKey faqsOperationImageKey;
  final GlobalKey faqsResultsImageKey;

  const KeyHolderState({
    required this.mainScrollKey,
    required this.firstImageWindowKey,
    required this.firstImageWindowBottomKey,
    required this.secondImageWindowKey,
    required this.secondImageWindowBottomKey,
    required this.thirdImageWindowKey,
    required this.thirdImageWindowBottomKey,
    required this.fourthImageWindowKey,
    required this.aboutKey,
    required this.pricingKey,
    required this.integrationKey,
    required this.faqsKey,
    required this.paymentImageKey,
    required this.businessImageKey,
    required this.notificationImageKey,
    required this.receiptImageKey,
    required this.pricingTitleKey,
    required this.pricingInfoKey,
    required this.brainKey,
    required this.registerKey,
    required this.invoiceKey,
    required this.piggyBankKey,
    required this.freeKey,
    required this.coinsKey,
    required this.dashboardLaptopImageKey,
    required this.dashboardEmployeeImageKey,
    required this.dashboardSalesImageKey,
    required this.dashboardComplementImageKey,
    required this.faqsIntegrationImageKey,
    required this.faqsOperationImageKey,
    required this.faqsResultsImageKey
  });

  factory KeyHolderState.initial() {
    return KeyHolderState(
      mainScrollKey: GlobalKey(),
      firstImageWindowKey: GlobalKey(),
      firstImageWindowBottomKey: GlobalKey(),
      secondImageWindowKey: GlobalKey(),
      secondImageWindowBottomKey: GlobalKey(),
      thirdImageWindowKey: GlobalKey(),
      thirdImageWindowBottomKey: GlobalKey(),
      fourthImageWindowKey: GlobalKey(),
      aboutKey: GlobalKey(),
      pricingKey: GlobalKey(),
      integrationKey: GlobalKey(),
      faqsKey: GlobalKey(),
      paymentImageKey: GlobalKey(),
      businessImageKey: GlobalKey(),
      notificationImageKey: GlobalKey(),
      receiptImageKey: GlobalKey(),
      pricingTitleKey: GlobalKey(),
      pricingInfoKey: GlobalKey(),
      brainKey: GlobalKey(),
      registerKey: GlobalKey(),
      invoiceKey: GlobalKey(),
      piggyBankKey: GlobalKey(),
      freeKey: GlobalKey(),
      coinsKey: GlobalKey(),
      dashboardLaptopImageKey: GlobalKey(),
      dashboardEmployeeImageKey: GlobalKey(),
      dashboardSalesImageKey: GlobalKey(),
      dashboardComplementImageKey: GlobalKey(),
      faqsIntegrationImageKey: GlobalKey(),
      faqsOperationImageKey: GlobalKey(),
      faqsResultsImageKey: GlobalKey()
    );
  }

  @override
  List<Object> get props => [
    mainScrollKey
  ];
}
