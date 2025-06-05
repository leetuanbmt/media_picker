// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:picker_library/picker_library.dart';

import '../constants/config.dart';
import '../constants/constants.dart';
import '../provider/asset_picker_provider.dart';
import '../widget/asset_picker.dart';
import '../widget/asset_picker_page_route.dart';
import 'asset_picker_builder_delegate.dart';

class AssetPickerDelegate {
  const AssetPickerDelegate();

  Future<PermissionState> permissionCheck({
    PermissionRequestOption requestOption = const PermissionRequestOption(),
  }) async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend(
      requestOption: requestOption,
    );
    if (ps != PermissionState.authorized && ps != PermissionState.limited) {
      throw StateError('Permission state error with $ps.');
    }
    return ps;
  }

  Future<List<AssetEntity>?> pickAssets(
    BuildContext context, {
    Key? key,
    AssetPickerConfig pickerConfig = const AssetPickerConfig(),
    PermissionRequestOption? permissionRequestOption,
    bool useRootNavigator = true,
    AssetPickerPageRouteBuilder<List<AssetEntity>>? pageRouteBuilder,
  }) async {
    permissionRequestOption ??= PermissionRequestOption(
      androidPermission: AndroidPermission(
        type: pickerConfig.requestType,
        mediaLocation: false,
      ),
    );
    final PermissionState ps = await permissionCheck(
      requestOption: permissionRequestOption,
    );
    final AssetPickerPageRoute<List<AssetEntity>> route =
        pageRouteBuilder?.call(const SizedBox.shrink()) ??
        AssetPickerPageRoute<List<AssetEntity>>(
          builder: (_) => const SizedBox.shrink(),
        );
    final DefaultAssetPickerProvider provider = DefaultAssetPickerProvider(
      maxAssets: pickerConfig.maxAssets,
      pageSize: pickerConfig.pageSize,
      pathThumbnailSize: pickerConfig.pathThumbnailSize,
      selectedAssets: pickerConfig.selectedAssets,
      requestType: pickerConfig.requestType,
      sortPathDelegate: pickerConfig.sortPathDelegate,
      filterOptions: pickerConfig.filterOptions,
      initializeDelayDuration: route.transitionDuration,
    );
    final Widget picker = AssetPicker<AssetEntity, AssetPathEntity>(
      key: key,
      permissionRequestOption: permissionRequestOption,
      builder: DefaultAssetPickerBuilderDelegate(
        provider: provider,
        initialPermission: ps,
        gridCount: pickerConfig.gridCount,
        pickerTheme: pickerConfig.pickerTheme,
        gridThumbnailSize: pickerConfig.gridThumbnailSize,
        previewThumbnailSize: pickerConfig.previewThumbnailSize,
        specialPickerType: pickerConfig.specialPickerType,
        specialItemPosition: pickerConfig.specialItemPosition,
        specialItemBuilder: pickerConfig.specialItemBuilder,
        loadingIndicatorBuilder: pickerConfig.loadingIndicatorBuilder,
        selectPredicate: pickerConfig.selectPredicate,
        shouldRevertGrid: pickerConfig.shouldRevertGrid,
        limitedPermissionOverlayPredicate:
            pickerConfig.limitedPermissionOverlayPredicate,
        pathNameBuilder: pickerConfig.pathNameBuilder,
        assetsChangeCallback: pickerConfig.assetsChangeCallback,
        assetsChangeRefreshPredicate: pickerConfig.assetsChangeRefreshPredicate,
        textDelegate: pickerConfig.textDelegate,
        themeColor: pickerConfig.themeColor,
        locale: Localizations.maybeLocaleOf(context),
        shouldAutoplayPreview: pickerConfig.shouldAutoplayPreview,
        dragToSelect: pickerConfig.dragToSelect,
      ),
    );
    final List<AssetEntity>? result =
        await Navigator.maybeOf(
          context,
          rootNavigator: useRootNavigator,
        )?.push<List<AssetEntity>>(
          pageRouteBuilder?.call(picker) ??
              AssetPickerPageRoute<List<AssetEntity>>(builder: (_) => picker),
        );
    return result;
  }

  Future<List<Asset>?> pickAssetsWithDelegate<
    Asset,
    Path,
    PickerProvider extends AssetPickerProvider<Asset, Path>
  >(
    BuildContext context, {
    required AssetPickerBuilderDelegate<Asset, Path> delegate,
    PermissionRequestOption permissionRequestOption =
        const PermissionRequestOption(),
    Key? key,
    bool useRootNavigator = true,
    AssetPickerPageRouteBuilder<List<Asset>>? pageRouteBuilder,
  }) async {
    await permissionCheck(requestOption: permissionRequestOption);
    final Widget picker = AssetPicker<Asset, Path>(
      key: key,
      permissionRequestOption: permissionRequestOption,
      builder: delegate,
    );
    final List<Asset>? result =
        await Navigator.maybeOf(
          context,
          rootNavigator: useRootNavigator,
        )?.push<List<Asset>>(
          pageRouteBuilder?.call(picker) ??
              AssetPickerPageRoute<List<Asset>>(builder: (_) => picker),
        );
    return result;
  }

  void registerObserve([ValueChanged<MethodCall>? callback]) {
    if (callback == null) {
      return;
    }
    try {
      PhotoManager.addChangeCallback(callback);
      PhotoManager.startChangeNotify();
    } catch (e, s) {
      FlutterError.presentError(
        FlutterErrorDetails(
          exception: e,
          stack: s,
          library: packageName,
          silent: true,
        ),
      );
    }
  }

  void unregisterObserve([ValueChanged<MethodCall>? callback]) {
    if (callback == null) {
      return;
    }
    try {
      PhotoManager.removeChangeCallback(callback);
      PhotoManager.stopChangeNotify();
    } catch (e, s) {
      FlutterError.presentError(
        FlutterErrorDetails(
          exception: e,
          stack: s,
          library: packageName,
          silent: true,
        ),
      );
    }
  }

  ThemeData themeData(Color? themeColor, {bool light = false}) {
    themeColor ??= defaultThemeColorWeChat;
    if (light) {
      return ThemeData.light().copyWith(
        primaryColor: Colors.grey[50],
        primaryColorLight: Colors.grey[50],
        primaryColorDark: Colors.grey[50],
        canvasColor: Colors.grey[100],
        scaffoldBackgroundColor: Colors.grey[50],
        cardColor: Colors.grey[50],
        highlightColor: Colors.transparent,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: themeColor,
          selectionColor: themeColor.withAlpha(100),
          selectionHandleColor: themeColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[100],
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
          iconTheme: IconThemeData(color: Colors.grey[900]),
          elevation: 0,
        ),
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey[100]),
        buttonTheme: ButtonThemeData(buttonColor: themeColor),
        iconTheme: IconThemeData(color: Colors.grey[900]),
        checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStateProperty.all(Colors.black),
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return themeColor;
            }
            return null;
          }),
          side: const BorderSide(color: Colors.black),
        ),
        colorScheme: ColorScheme(
          primary: Colors.grey[50]!,
          secondary: themeColor,
          surface: Colors.grey[50]!,
          brightness: Brightness.light,
          error: const Color(0xffcf6679),
          onPrimary: Colors.white,
          onSecondary: Colors.grey[100]!,
          onSurface: Colors.black,
          onError: Colors.white,
        ),
      );
    }
    return ThemeData.dark().copyWith(
      primaryColor: Colors.grey[900],
      primaryColorLight: Colors.grey[900],
      primaryColorDark: Colors.grey[900],
      canvasColor: Colors.grey[850],
      scaffoldBackgroundColor: Colors.grey[900],
      cardColor: Colors.grey[900],
      highlightColor: Colors.transparent,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: themeColor,
        selectionColor: themeColor.withAlpha(100),
        selectionHandleColor: themeColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[850],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey[850]),
      buttonTheme: ButtonThemeData(buttonColor: themeColor),
      iconTheme: const IconThemeData(color: Colors.white),
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.all(Colors.white),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return themeColor;
          }
          return null;
        }),
        side: const BorderSide(color: Colors.white),
      ),
      colorScheme: ColorScheme(
        primary: Colors.grey[900]!,
        secondary: themeColor,
        surface: Colors.grey[900]!,
        brightness: Brightness.dark,
        error: const Color(0xffcf6679),
        onPrimary: Colors.black,
        onSecondary: Colors.grey[850]!,
        onSurface: Colors.white,
        onError: Colors.black,
      ),
    );
  }
}
