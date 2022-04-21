import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/navigation.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/welcome.vm.dart';
import 'package:fuodz/views/pages/vendor/widgets/banners.view.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/cards/custom.visibility.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/vendor_type.list_item.dart';
import 'package:fuodz/widgets/list_items/vendor_type.vertical_list_item.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:velocity_x/velocity_x.dart';

class EmptyWelcome extends StatelessWidget {
  const EmptyWelcome({this.vm, Key key}) : super(key: key);

  final WelcomeViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        VxBox(
          child: SafeArea(
            child: VStack(
              [
                ("Welcome".tr() +
                        (vm.isAuthenticated()
                            ? " ${AuthServices.currentUser?.name ?? ''}"
                            : ""))
                    .text
                    .white
                    .xl3
                    .semiBold
                    .make(),
                "How can I help you today?".tr().text.white.xl.medium.make(),
              ],
            ).py12(),
          ),
        ).color(AppColor.primaryColor).p20.make().wFull(context),
        //
        CustomVisibilty(
          visible: AppStrings.showBannerOnHomeScreen,
          child: Banners(null).py12(),
        ),
        //
        VStack(
          [
            HStack(
              [
                "I want to:".tr().text.xl.medium.make().expand(),
                Icon(
                  vm.showGrid ? FlutterIcons.grid_fea : FlutterIcons.list_fea,
                ).p2().onInkTap(() {
                  vm.showGrid = !vm.showGrid;
                  vm.notifyListeners();
                }),
              ],
              crossAlignment: CrossAxisAlignment.center,
            ).py4(),
            //list view
            !vm.showGrid
                ? CustomListView(
                    noScrollPhysics: true,
                    dataSet: vm.vendorTypes,
                    isLoading: vm.isBusy,
                    itemBuilder: (context, index) {
                      final vendorType = vm.vendorTypes[index];
                      return VendorTypeListItem(
                        vendorType,
                        onPressed: () {
                          NavigationService.pageSelected(vendorType,
                              context: context);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => UiSpacer.emptySpace(),
                  )
                : (vm.isBusy
                        ? BusyIndicator().centered()
                        : AnimationLimiter(
                            child: MasonryGrid(
                              column: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: List.generate(
                                vm.vendorTypes.length ?? 0,
                                (index) {
                                  final vendorType = vm.vendorTypes[index];
                                  return VendorTypeVerticalListItem(
                                    vendorType,
                                    onPressed: () {
                                      NavigationService.pageSelected(vendorType,
                                          context: context);
                                    },
                                  );
                                },
                              ),
                            ),
                          ))
                    .py4(),
          ],
        ).p20(),
      ],
    ).scrollVertical();
  }
}
