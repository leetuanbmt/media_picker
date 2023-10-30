part of '../media_picker.dart';

const List<AssetPickerTextDelegate> assetPickerTextDelegates =
    <AssetPickerTextDelegate>[
  AssetPickerTextDelegate(),
  EnglishAssetPickerTextDelegate(),
  JapaneseAssetPickerTextDelegate(),
];

AssetPickerTextDelegate assetPickerTextDelegateFromLocale(Locale? locale) {
  if (locale == null) {
    return const AssetPickerTextDelegate();
  }
  final String languageCode = locale.languageCode.toLowerCase();
  for (final AssetPickerTextDelegate delegate in assetPickerTextDelegates) {
    if (delegate.languageCode == languageCode) {
      return delegate;
    }
  }
  return const AssetPickerTextDelegate();
}

class AssetPickerTextDelegate {
  const AssetPickerTextDelegate();

  String get languageCode => 'vi';

  String get confirm => 'Xác nhận';

  String get cancel => 'Hủy';

  String get edit => 'Chỉnh sửa';

  String get gifIndicator => 'GIF';

  String get loadFailed => 'Tải thất bại';

  String get original => 'Gốc';

  String get preview => 'Xem trước';

  String get select => 'Chọn';

  String get emptyList => 'Danh sách trống';

  String get unSupportedAssetType => 'Loại tệp không được hỗ trợ';

  String get unableToAccessAll =>
      'Không thể truy cập vào các tệp trên thiết bị của bạn';

  String get viewingLimitedAssetsTip => 'Đang xem các tệp và thư mục hạn chế';

  String get changeAccessibleLimitedAssets =>
      'Thay đổi quyền truy cập tệp hạn chế';

  String get accessAllTip => 'Ứng dụng chỉ có thể truy cập một số tệp. '
      'Hãy vào cài đặt hệ thống và cho phép ứng dụng truy cập tất cả các tệp trên thiết bị';

  String get goToSystemSettings => 'Đi đến cài đặt hệ thống';

  String get accessLimitedAssets => 'Tiếp tục với quyền truy cập hạn chế';

  String get accessiblePathName => 'Tệp truy cập';

  String get sTypeAudioLabel => 'Âm thanh';

  String get sTypeImageLabel => 'Hình ảnh';

  String get sTypeVideoLabel => 'Video';

  String get sTypeOtherLabel => 'Khác';

  String get sActionPlayHint => 'phát';

  String get sActionPreviewHint => 'xem trước';

  String get sActionSelectHint => 'chọn';

  String get sActionSwitchPathLabel => 'chuyển đổi đường dẫn';

  String get sActionUseCameraHint => 'Sử dụng máy ảnh';

  String get sNameDurationLabel => 'thời lượng';

  String get sUnitAssetCountLabel => 'số lượng';

  String durationIndicatorBuilder(Duration duration) {
    const String separator = ':';
    final String minute = duration.inMinutes.toString().padLeft(2, '0');
    final String second = (duration - Duration(minutes: duration.inMinutes))
        .inSeconds
        .toString()
        .padLeft(2, '0');
    return '$minute$separator$second';
  }

  String semanticTypeLabel(AssetType type) {
    return switch (type) {
      AssetType.audio => sTypeAudioLabel,
      AssetType.image => sTypeImageLabel,
      AssetType.video => sTypeVideoLabel,
      AssetType.other => sTypeOtherLabel,
    };
  }

  AssetPickerTextDelegate get semanticsTextDelegate => this;
}

class EnglishAssetPickerTextDelegate extends AssetPickerTextDelegate {
  const EnglishAssetPickerTextDelegate();

  @override
  String get languageCode => 'en';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get edit => 'Edit';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get loadFailed => 'Load failed';

  @override
  String get original => 'Origin';

  @override
  String get preview => 'Preview';

  @override
  String get select => 'Select';

  @override
  String get emptyList => 'Empty list';

  @override
  String get unSupportedAssetType => 'Unsupported HEIC asset type.';

  @override
  String get unableToAccessAll => 'Unable to access all assets on the device';

  @override
  String get viewingLimitedAssetsTip =>
      'Only view assets and albums accessible to app.';

  @override
  String get changeAccessibleLimitedAssets =>
      'Click to update accessible assets';

  @override
  String get accessAllTip => 'App can only access some assets on the device. '
      'Go to system settings and allow app to access all assets on the device.';

  @override
  String get goToSystemSettings => 'Go to system settings';

  @override
  String get accessLimitedAssets => 'Continue with limited access';

  @override
  String get accessiblePathName => 'Accessible assets';

  @override
  String get sTypeAudioLabel => 'Audio';

  @override
  String get sTypeImageLabel => 'Image';

  @override
  String get sTypeVideoLabel => 'Video';

  @override
  String get sTypeOtherLabel => 'Other asset';

  @override
  String get sActionPlayHint => 'play';

  @override
  String get sActionPreviewHint => 'preview';

  @override
  String get sActionSelectHint => 'select';

  @override
  String get sActionSwitchPathLabel => 'switch path';

  @override
  String get sActionUseCameraHint => 'use camera';

  @override
  String get sNameDurationLabel => 'duration';

  @override
  String get sUnitAssetCountLabel => 'count';
}

class JapaneseAssetPickerTextDelegate extends AssetPickerTextDelegate {
  const JapaneseAssetPickerTextDelegate();

  @override
  String get languageCode => 'ja';

  @override
  String get confirm => '確認';

  @override
  String get cancel => 'キャンセル';

  @override
  String get edit => '編集';

  @override
  String get gifIndicator => 'GIF画像';

  @override
  String get loadFailed => '読み込みに失敗しました';

  @override
  String get original => '元の画像';

  @override
  String get preview => 'プレビュー';

  @override
  String get select => '選択';

  @override
  String get emptyList => 'リストが空です';

  @override
  String get unSupportedAssetType => '未対応のフォーマット';

  @override
  String get unableToAccessAll => 'すべてのリソースへのアクセスができない';

  @override
  String get viewingLimitedAssetsTip => 'アプリは一部のリソースと'
      '写真にしかアクセスできない';

  @override
  String get changeAccessibleLimitedAssets => 'アクセスできるリソースを設定する';

  @override
  String get accessAllTip => 'アプリがデバイスのリソースの一部にのみ'
      'アクセスするように設定されています。'
      '「すべてのリソース」へのアクセスを許可することを推奨します';

  @override
  String get goToSystemSettings => '「システム設定」に移動';

  @override
  String get accessLimitedAssets => 'リソースの一部へのアクセスを続行';

  @override
  String get accessiblePathName => 'アクセスできるリソース';

  @override
  String get sTypeAudioLabel => 'オーディオ';

  @override
  String get sTypeImageLabel => '画像';

  @override
  String get sTypeVideoLabel => '動画';

  @override
  String get sTypeOtherLabel => 'その他のリソース';

  @override
  String get sActionPlayHint => '再生';

  @override
  String get sActionPreviewHint => 'プレビュー';

  @override
  String get sActionSelectHint => '選択';

  @override
  String get sActionSwitchPathLabel => 'パス切り替え';

  @override
  String get sActionUseCameraHint => 'カメラを使う';

  @override
  String get sNameDurationLabel => '動画の時間';

  @override
  String get sUnitAssetCountLabel => '数';
}
