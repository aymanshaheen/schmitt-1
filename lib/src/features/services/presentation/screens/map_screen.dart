import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:schmitt/src/core/usecase/address_params.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_login_button.dart';
import 'package:schmitt/src/features/booking_details/data/models/place_direction_model.dart';
import 'package:schmitt/src/features/booking_details/data/models/place_model.dart';
import 'package:schmitt/src/features/booking_details/data/models/place_suggestion_model.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/custom_text_field.dart';
import 'package:schmitt/src/features/services/presentation/cubit/maps/maps_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_state.dart';
import 'package:schmitt/src/features/services/presentation/widgets/location_helper.dart';
import 'package:schmitt/src/features/booking_details/presentation/widgets/distance_and_time.dart';
import 'package:schmitt/src/features/booking_details/presentation/widgets/place_item.dart';
import 'package:uuid/uuid.dart';

class MapScreen extends StatefulWidget {
  final bool isEdit;

  const MapScreen({Key? key, required this.isEdit}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<PlaceSuggestion> places = [];
  static Position? position;
  late TextEditingController nameController;
  late TextEditingController addressController;
  final _formKey = GlobalKey<FormState>();

  final Completer<GoogleMapController> _mapController = Completer();

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 20,
  );

  Set<Marker> markers = {};
  late PlaceSuggestion placeSuggestion;
  late Place selectedPlace;
  late Marker searchedPlaceMarker;
  late Marker currentLocationMarker;

  void _handleTap(LatLng point) {
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          infoWindow: const InfoWindow(
            title: 'Selected Location',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  PlaceDirections? placeDirections;
  var progressIndicator = false;
  late List<LatLng> polylinePoints;
  var isSearchedPlaceMarkerClicked = false;
  var isTimeAndDistanceVisible = false;
  late String time;
  late String distance;

  @override
  initState() {
    super.initState();
    nameController = widget.isEdit
        ? TextEditingController(text: AppConstants.currentAddress!.name)
        : TextEditingController();
    addressController = widget.isEdit
        ? TextEditingController(text: AppConstants.currentAddress!.address)
        : TextEditingController();
    getMyCurrentLocation();
  }

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      markers: markers,
      initialCameraPosition: widget.isEdit
          ? CameraPosition(
              target: LatLng(AppConstants.currentAddress!.locationLatitude!,
                  AppConstants.currentAddress!.locationLongitude!),
              zoom: 12,
            )
          : _myCurrentLocationCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
      onTap: (LatLng point) {
        _handleTap(point);
      },
      polylines: placeDirections != null
          ? {
              Polyline(
                polylineId: const PolylineId('my_polyline'),
                color: Colors.black,
                width: 2,
                points: polylinePoints,
              ),
            }
          : {},
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  Widget buildDiretionsBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is DirectionsLoaded) {
          placeDirections = (state).placeDirections;

          getPolylinePoints();
        }
      },
      child: Container(),
    );
  }

  void getPolylinePoints() {
    polylinePoints = placeDirections!.polylinePoints
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
  }

  Widget buildSelectedPlaceLocationBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is PlaceLocationLoaded) {
          selectedPlace = (state).place;

          getDirections();
        }
      },
      child: Container(),
    );
  }

  void getDirections() {
    BlocProvider.of<MapsCubit>(context).emitPlaceDirections(
      LatLng(position!.latitude, position!.longitude),
      LatLng(selectedPlace.result.geometry.location.lat,
          selectedPlace.result.geometry.location.lng),
    );
  }

  void buildCurrentLocationMarker() {
    currentLocationMarker = Marker(
      position: LatLng(position!.latitude, position!.longitude),
      markerId: const MarkerId('2'),
      onTap: () {},
      infoWindow: const InfoWindow(title: "Your current Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    addMarkerToMarkersAndUpdateUI(currentLocationMarker);
  }

  void addMarkerToMarkersAndUpdateUI(Marker marker) {
    setState(() {
      markers.add(marker);
    });
  }

  void getPlacesSuggestions(String query) {
    final sessionToken = const Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceSuggestions(query, sessionToken);
  }

  Widget buildSuggestionsBloc() {
    return BlocBuilder<MapsCubit, MapsState>(
      builder: (context, state) {
        if (state is PlacesLoaded) {
          places = (state).places;
          if (places.isNotEmpty) {
            return buildPlacesList();
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildPlacesList() {
    return ListView.builder(
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () async {
              placeSuggestion = places[index];
              getSelectedPlaceLocation();
              polylinePoints.clear();
              removeAllMarkersAndUpdateUI();
            },
            child: PlaceItem(
              suggestion: places[index],
            ),
          );
        },
        itemCount: places.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics());
  }

  void removeAllMarkersAndUpdateUI() {
    setState(() {
      markers.clear();
    });
  }

  void getSelectedPlaceLocation() {
    final sessionToken = const Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceLocation(placeSuggestion.placeId, sessionToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:
          BlocConsumer<ServiceCubit, ServiceStates>(listener: (context, state) {
        if (state is CreateAddressLoaded || state is CreateCarLoaded) {
          ServiceCubit.get(context).getAdresses(1);
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            position != null
                ? buildMap()
                : Center(
                    child: CircularIndicator(
                      color: AppColors.darkBlue,
                    ),
                  ),
            // buildFloatingSearchBar(),
            isSearchedPlaceMarkerClicked
                ? DistanceAndTime(
                    isTimeAndDistanceVisible: isTimeAndDistanceVisible,
                    placeDirections: placeDirections,
                  )
                : Container(),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return AnimatedPadding(
                            padding: MediaQuery.of(context).viewInsets,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.decelerate,
                            child: Padding(
                              padding: EdgeInsets.all(R.sW(context, 20)),
                              child: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      BottomTextFeild(
                                        controller: nameController,
                                        labelText: 'name'.tr(),
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'fill_this_field'.tr();
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: R.sH(context, 10),
                                      ),
                                      BottomTextFeild(
                                        controller: addressController,
                                        labelText: 'description'.tr(),
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'fill_this_field'.tr();
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: R.sH(context, 20),
                                      ),
                                      BlocBuilder<ServiceCubit, ServiceStates>(
                                          builder: (context, state) {
                                        return CustomLoginButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              widget.isEdit
                                                  ? ServiceCubit.get(context).updateAddress(
                                                      AddressParams(
                                                          address:
                                                              addressController
                                                                  .text,
                                                          name: nameController
                                                              .text,
                                                          locationLatitude:
                                                              position!.latitude
                                                                  .toString(),
                                                          locatiogLongitude:
                                                              position!.longitude
                                                                  .toString()),
                                                      AppConstants
                                                          .currentAddress!.id)
                                                  : ServiceCubit.get(context).createAddress(AddressParams(
                                                      address: addressController
                                                          .text,
                                                      name: nameController.text,
                                                      locationLatitude:
                                                          position!.latitude
                                                              .toString(),
                                                      locatiogLongitude:
                                                          position!.longitude
                                                              .toString()));
                                            }
                                          },
                                          text: widget.isEdit
                                              ? "update".tr()
                                              : "add".tr(),
                                          isLoading:
                                              state is CreateAddressLoading ||
                                                  state is CreateCarLoading,
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    });
                  },
                  child: FullRounderContainer(
                      title: widget.isEdit
                          ? "update".tr()
                          : 'add_new_address'.tr(),
                      containerColor: AppColors.darkBlue,
                      textColor: AppColors.white,
                      circular: 10)),
            ),
          ],
        );
      }),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 8, 80),
        child: FloatingActionButton(
          backgroundColor: AppColors.darkBlue,
          onPressed: _goToMyCurrentLocation,
          child: Icon(Icons.place, color: AppColors.white),
        ),
      ),
    );
  }
}
