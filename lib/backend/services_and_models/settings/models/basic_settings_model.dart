import '../../../../widgets/dropdown/custom_dropdown_widget.dart';

class BasicSettingModel {
  final Data data;

  BasicSettingModel({
    required this.data,
  });

  factory BasicSettingModel.fromJson(Map<String, dynamic> json) =>
      BasicSettingModel(
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final BasicSettings basicSettings;
  final WebLinks webLinks;
  final SplashScreen splashScreen;
  final List<OnboardScreen> onboardScreens;
  final List<Country> countries;
  final ImagePaths imagePaths;
  final AppImagePaths appImagePaths;

  Data({
    required this.basicSettings,
    required this.webLinks,
    required this.splashScreen,
    required this.onboardScreens,
    required this.countries,
    required this.imagePaths,
    required this.appImagePaths,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        basicSettings: BasicSettings.fromJson(json["basic_settings"]),
        webLinks: WebLinks.fromJson(json["web_links"]),
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
        splashScreen: SplashScreen.fromJson(json["splash_screen"]),
        onboardScreens: List<OnboardScreen>.from(
            json["onboard_screens"].map((x) => OnboardScreen.fromJson(x))),
        imagePaths: ImagePaths.fromJson(json["image_paths"]),
        appImagePaths: AppImagePaths.fromJson(json["app_image_paths"]),
      );
}

class Country extends DropdownModel{
  final int id;
  final String name;
  final String mobileCode;
  final String currencyName;
  final String currencyCode;
  final String currencySymbol;

  Country({
    required this.id,
    required this.name,
    required this.mobileCode,
    required this.currencyName,
    required this.currencyCode,
    required this.currencySymbol,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        mobileCode: json["mobile_code"],
        currencyName: json["currency_name"],
        currencyCode: json["currency_code"],
        currencySymbol: json["currency_symbol"],
      );

  @override
  // TODO: implement img
  String get img => throw UnimplementedError();

  @override
  // TODO: implement title
  String get title => name;
}

class AppImagePaths {
  final String baseUrl;
  final String pathLocation;
  final String defaultImage;

  AppImagePaths({
    required this.baseUrl,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory AppImagePaths.fromJson(Map<String, dynamic> json) => AppImagePaths(
        baseUrl: json["base_url"],
        pathLocation: json["path_location"],
        defaultImage: json["default_image"],
      );
}

class BasicSettings {
  final String siteName;
  final String siteTitle;
  final String siteLogo;
  final String siteLogoDark;
  final String siteFav;
  final String siteFavDark;
  final String baseColor;
  final String secondaryColor;
  final bool userKycStatus;

  BasicSettings({
    required this.siteName,
    required this.siteTitle,
    required this.siteLogo,
    required this.siteLogoDark,
    required this.siteFav,
    required this.baseColor,
    required this.secondaryColor,
    required this.siteFavDark,
    required this.userKycStatus,
  });

  factory BasicSettings.fromJson(Map<String, dynamic> json) => BasicSettings(
        siteName: json["site_name"],
        siteTitle: json["site_title"],
        siteLogo: json["site_logo"],
        siteLogoDark: json["site_logo_dark"],
        siteFav: json["site_fav"],
        siteFavDark: json["site_fav_dark"],
        baseColor: json["base_color"],
        secondaryColor: json["secondary_color"],
        userKycStatus: json["user_kyc_status"],
      );
}

class ImagePaths {
  final String basePath;
  final String pathLocation;
  final String defaultImage;

  ImagePaths({
    required this.basePath,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory ImagePaths.fromJson(Map<String, dynamic> json) => ImagePaths(
        basePath: json["base_path"],
        pathLocation: json["path_location"],
        defaultImage: json["default_image"],
      );
}

class OnboardScreen {
  final String title;
  final String subTitle;
  final String image;
  final int status;

  OnboardScreen({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.status,
  });

  factory OnboardScreen.fromJson(Map<String, dynamic> json) => OnboardScreen(
        title: json["title"],
        subTitle: json["sub_title"],
        image: json["image"],
        status: json["status"],
      );
}

class SplashScreen {
  final String image;
  final String version;

  SplashScreen({
    required this.image,
    required this.version,
  });

  factory SplashScreen.fromJson(Map<String, dynamic> json) => SplashScreen(
        image: json["image"],
        version: json["version"],
      );
}

class WebLinks {
  final String privacyPolicy;
  final String aboutUs;
  final String contactUs;

  WebLinks({
    required this.privacyPolicy,
    required this.aboutUs,
    required this.contactUs,
  });

  factory WebLinks.fromJson(Map<String, dynamic> json) => WebLinks(
        privacyPolicy: json["privacy-policy"],
        aboutUs: json["about-us"],
        contactUs: json["contact-us"] ?? "",
      );
}
