import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/widgets/page_transition.dart';
import 'package:schmitt/src/features/auth/presentation/screens/forget_password/forgot_password_screen.dart';
import 'package:schmitt/src/features/auth/presentation/screens/forget_password/reset_password_screen.dart';
import 'package:schmitt/src/features/auth/presentation/screens/forget_password/verify_code_screen.dart';
import 'package:schmitt/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:schmitt/src/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:schmitt/src/features/auth/presentation/screens/started_login_screen.dart';
import 'package:schmitt/src/features/booking_details/presentation/screens/booking_date_screen.dart';
import 'package:schmitt/src/features/booking_details/presentation/screens/cleaning_items_screen.dart';
import 'package:schmitt/src/features/booking_details/presentation/screens/location_layout_screen.dart';
import 'package:schmitt/src/features/home/presentation/screens/service_type_screen.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';
import 'package:schmitt/src/features/services/presentation/screens/select_rooms_screen.dart';
import 'package:schmitt/src/features/services/presentation/screens/service_order_screen.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/screens/service_screen.dart';
import 'package:schmitt/src/features/home/presentation/screens/book_mark_screen.dart';
import 'package:schmitt/src/features/home/presentation/screens/home_screen.dart';
import 'package:schmitt/src/features/home/presentation/screens/notifications_screen.dart';
import 'package:schmitt/src/features/inbox/domain/entities/call.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:schmitt/src/features/inbox/presentation/screens/call_screen.dart';
import 'package:schmitt/src/features/inbox/presentation/screens/chat_screen.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/camera/camera_screen.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/camera/sending_image_view_page.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/camera/sending_video_view_page.dart';
import 'package:schmitt/src/features/onboarding/bloc/onboarding_cubit.dart';
import 'package:schmitt/src/features/onboarding/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:schmitt/src/features/profile/presentation/screens/notifications_screen.dart';
import 'package:schmitt/src/features/profile/presentation/screens/payment_screen.dart';
import 'package:schmitt/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:schmitt/src/features/profile/presentation/screens/security_screen.dart';
import 'package:schmitt/src/features/profile/presentation/screens/select_language_screen.dart';
import 'package:schmitt/src/features/services/presentation/screens/submit_order_screen.dart';
import 'package:schmitt/src/features/spalsh_screen.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/screens/home_layout.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/screens/home_screen.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/screens/order_service.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/screens/order_settings_screen.dart';

class Routes {
  static const String home = "home";
  static const String splash = "splash";
  static const String onboarding = "onboarding";
  static const String started = "started";
  static const String login = "login";
  static const String forgetPassword = "forgetPassword";
  static const String verifyCode = "verifyCode";
  static const String resetPassword = "resetPassword";
  static const String signup = "signup";
  static const String service = "service";
  static const String notifications = "notifications";
  static const String bookmarks = "bookmarks";
  static const String selectRooms = "selectRooms";
  static const String orderService = "orderService";
  static const String submitOrder = "submitOrder";
  static const String editProfile = "editProfile";
  static const String profile = "profile";
  static const String notificationSettings = "notificationSettings";
  static const String paymentScreen = "paymentScreen";
  static const String security = "security";
  static const String language = "langauge";
  static const String chat = "chat";
  static const String callRoute = "callRoute";
  static const String cameraRoute = "cameraRoute";
  static const String sendingImageViewRoute = "sendingImageViewRoute";
  static const String sendingVideoViewRoute = "sendingVideoViewRoute";
  static const String homeTech = "homeTech";
  static const String homeLayoutTech = "homeLayoutTech";
  static const String techOrderService = "techOrderService";
  static const String orderSetting = "OrderSetting";
  static const String location = "location";
  static const String allServices = "allServices";
  static const String cleaningItems = "cleaningItems";
  static const String bookingDate = "bookingDate";
  static const String serviceType = "serviceType";
}

class AppRouter {
  static Route routesGenerator(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return FadeRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.onboarding:
        return FadeRoute(
          builder: (context) => BlocProvider(
            create: (context) => OnboardingBloc(),
            child: const Onboarding(),
          ),
        );
      case Routes.started:
        return FadeRoute(
          builder: (context) => const StartedLogin(),
        );
      case Routes.login:
        return FadeRoute(
          builder: (context) => const SignInScreen(),
        );
      case Routes.forgetPassword:
        return FadeRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );
      case Routes.verifyCode:
        return FadeRoute(
          builder: (context) => const VerifyCodeScreen(),
        );
      case Routes.resetPassword:
        return FadeRoute(
          builder: (context) => const ResetPasswordScreen(),
        );
      case Routes.signup:
        return FadeRoute(
          builder: (context) => const SignUpScreen(),
        );
      case Routes.home:
        return FadeRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.notifications:
        return FadeRoute(
          builder: (context) => const NotificationsScreen(),
        );
      case Routes.serviceType:
        final arguments = settings.arguments as ServiceArguments;
        return FadeRoute(
          builder: (context) => ServicetypeScreen(
              services: arguments.services, serviceName: arguments.name),
        );
      case Routes.bookmarks:
        return FadeRoute(
          builder: (context) => const BookMarkScreen(),
        );
      case Routes.service:
        final arguments = settings.arguments as Service;
        return FadeRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<ServiceCubit>(),
            child: ServiceScreen(
              service: arguments,
            ),
          ),
        );
      case Routes.selectRooms:
        return FadeRoute(
          builder: (context) => BlocProvider.value(
            value: BlocProvider.of<ServiceCubit>(context),
            child: const SelectRoomsScreen(),
          ),
        );
      case Routes.submitOrder:
        return FadeRoute(
          builder: (context) => BlocProvider.value(
            value: BlocProvider.of<ServiceCubit>(context),
            child: const SubmitOrderScreen(),
          ),
        );
      case Routes.orderService:
        final arguments = settings.arguments as int;
        return FadeRoute(
          builder: (context) => BlocProvider.value(
            value: BlocProvider.of<ServiceCubit>(context),
            child: ServiceOrderScreen(arguments),
          ),
        );
      case Routes.chat:
        final arguments = settings.arguments as Map<String, dynamic>;
        final String name = arguments['name'];
        final String id = arguments['id'];
        return FadeRoute(
          builder: (context) => BlocProvider(
              create: (context) => sl<ChatCubit>(),
              child: ChatScreen(
                name: name,
                id: id,
              )),
        );
      case Routes.callRoute:
        final arguments = settings.arguments as Map<String, dynamic>;
        final Call call = arguments['call'];
        final String channelId = arguments['channelId'];
        return FadeRoute(
          builder: (context) => CallScreen(call: call, channelId: channelId),
        );
      case Routes.editProfile:
        return FadeRoute(
          builder: (context) => const EditProfileScreen(),
        );
      case Routes.profile:
        return FadeRoute(
          builder: (context) => const ProfileScreen(),
        );
      case Routes.notificationSettings:
        return FadeRoute(
          builder: (context) => const NotificationsScreenSettings(),
        );
      case Routes.paymentScreen:
        return FadeRoute(
          builder: (context) => const PaymentScreen(),
        );
      case Routes.security:
        return FadeRoute(
          builder: (context) => const SecurityScreen(),
        );
      case Routes.language:
        return FadeRoute(
          builder: (context) => const SelectLanguageScreen(),
        );
      /*  case Routes.allServices:
        return FadeRoute(
          builder: (context) => const AllServicesScreen(),
        );*/
      case Routes.bookingDate:
        return FadeRoute(
          builder: (context) => const BookingDate(),
        );
      case Routes.cleaningItems:
        return FadeRoute(
          builder: (context) => const CleaningItemsScreen(),
        );
      case Routes.location:
        return FadeRoute(
          builder: (context) => const LocationLayoutScreen(),
        );
      case Routes.cameraRoute:
        final arguments = settings.arguments as Map<String, dynamic>;
        final String uId = arguments['uId'];
        return FadeRoute(
          builder: (context) => BlocProvider(
              create: (context) => sl<ChatCubit>(),
              child: CameraScreen(receiverId: uId)),
        );
      case Routes.sendingImageViewRoute:
        final arguments = settings.arguments as Map<String, dynamic>;
        final String uId = arguments['uId'];
        final String path = arguments['path'];
        return FadeRoute(
          builder: (context) => BlocProvider(
              create: (context) => sl<ChatCubit>(),
              child: SendingImageViewPage(path: path, receiverId: uId)),
        );
      case Routes.sendingVideoViewRoute:
        final arguments = settings.arguments as Map<String, dynamic>;
        final String uId = arguments['uId'];
        final String path = arguments['path'];
        return FadeRoute(
          builder: (context) => BlocProvider(
              create: (context) => sl<ChatCubit>(),
              child: SendingVideoViewPage(path: path, receiverId: uId)),
        );
      case Routes.homeTech:
        return FadeRoute(
          builder: (context) => const HomeTechScreen(),
        );
      case Routes.homeLayoutTech:
        return FadeRoute(
          builder: (context) => const HomeTechLayoutScreen(),
        );
      case Routes.orderSetting:
        return FadeRoute(
          builder: (context) => const OrderSettingScreen(),
        );
      case Routes.techOrderService:
        return FadeRoute(
          builder: (context) => const OrderServiceScreen(),
        );
    }

    return FadeRoute(builder: (context) => const NoRouteFound());
  }
}

class NoRouteFound extends StatelessWidget {
  const NoRouteFound({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: Text(AppStrings.noRouteFound)),
      );
}

class ServiceArguments {
  final String services;
  final String name;

  ServiceArguments(this.services, this.name);
}
