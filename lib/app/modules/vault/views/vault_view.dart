import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/colors.dart';
import 'package:posteriya/app/core/typography.dart';

import '../../../core/local_string.dart';
import '../../../reusable/generated_scaffold.dart';
import '../../../reusable/global_widget.dart';
import '../../aiEffectTab/views/ai_effect_tab_view.dart';
import '../../freetab/views/freetab_view.dart';
import '../controllers/vault_controller.dart';

class VaultView extends GetView<VaultController> {
  const VaultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return appScaffold(
      body: DefaultTabController(
        length: 2,
        child: SizedBox(
          height: Get.height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          surfaceVariant: Colors.transparent,
                        ),
                  ),
                  child: TabBar(
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        // Use the default focused overlay color
                        return states.contains(MaterialState.focused)
                            ? null
                            : Colors.transparent;
                      }),
                      unselectedLabelColor: AppColors.black,
                      unselectedLabelStyle: ubuntu.get13.w700,
                      labelStyle: ubuntu.get13.w700,
                      labelColor: AppColors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: AppColors.trans,
                      indicatorPadding: EdgeInsets.symmetric(
                          horizontal: 3.w, vertical: 0.2.h),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.appColor, // Start color of the gradient
                            AppColors.white, // End color of the gradient
                          ],
                          // begin: Alignment.topLeft,
                          // end: Alignment.topRight,
                        ),
                      ),
                      onTap: (index) {},
                      tabs: [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: AppText(LocalString.free),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: AppText(LocalString.aieffect),
                          ),
                        ),
                      ]),
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [FreeTabView(), AiEffectTabView()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
