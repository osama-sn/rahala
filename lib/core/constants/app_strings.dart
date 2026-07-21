import 'package:easy_localization/easy_localization.dart';

class AppStrings {
  AppStrings._();

  // Buttons
  static String get login => 'buttons.login'.tr();
  static String get register => 'buttons.register'.tr();
  static String get save => 'buttons.save'.tr();
  static String get cancel => 'buttons.cancel'.tr();
  static String get submit => 'buttons.submit'.tr();
  static String get forgotPassword => 'buttons.forgotPassword'.tr();
  static String get loginGoogle => 'buttons.loginGoogle'.tr();
  static String get loginFacebook => 'buttons.loginFacebook'.tr();
  static String get bookNow => 'buttons.bookNow'.tr();
  static String get viewAll => 'buttons.viewAll'.tr();

  // Errors
  static String get errorUnknown => 'errors.unknown'.tr();
  static String get errorNetwork => 'errors.network'.tr();
  static String get errorServer => 'errors.server'.tr();
  static String get errorUnauthorized => 'errors.unauthorized'.tr();

  // Validation
  static String get requiredField => 'validation.required'.tr();
  static String get invalidEmail => 'validation.invalidEmail'.tr();
  static String get passwordLength => 'validation.passwordLength'.tr();
  static String get passwordMatch => 'validation.passwordMatch'.tr();

  // Messages
  static String get welcome => 'messages.welcome'.tr();
  static String get success => 'messages.success'.tr();
  static String get loginSubtitle => 'messages.loginSubtitle'.tr();
  static String get or => 'messages.or'.tr();
  static String get dontHaveAccount => 'messages.dontHaveAccount'.tr();
  static String get alreadyHaveAccount => 'messages.alreadyHaveAccount'.tr();
  static String get createAccountTitle => 'messages.createAccountTitle'.tr();
  static String get createAccountSubtitle =>
      'messages.createAccountSubtitle'.tr();
  static String get profilePhotoOptional =>
      'messages.profilePhotoOptional'.tr();

  // Labels
  static String get emailLabel => 'labels.email'.tr();
  static String get passwordLabel => 'labels.password'.tr();
  static String get phoneLabel => 'labels.phone'.tr();
  static String get nameLabel => 'labels.name'.tr();
  static String get confirmPasswordLabel => 'labels.confirmPassword'.tr();

  // Hints
  static String get emailHint => 'hints.email'.tr();
  static String get passwordHint => 'hints.password'.tr();
  static String get searchHint => 'hints.search'.tr();
  static String get confirmPasswordHint => 'hints.confirmPassword'.tr();
  static String get phoneHint => 'hints.phone'.tr();
  static String get nameHint => 'hints.name'.tr();

  // Splash
  static String get splashTitle => 'splash.title'.tr();
  static String get splashTagline => 'splash.tagline'.tr();
  static String get splashLoading => 'splash.loading'.tr();
  static String get splashVerifyingLogin => 'splash.verifyingLogin'.tr();

  // Home
  static String get homeTitle => 'home.title'.tr();
  static String get homeFeaturedTrip => 'home.featuredTrip'.tr();
  static String get homeCategories => 'home.categories'.tr();
  static String get homePopularDestinations => 'home.popularDestinations'.tr();
  static String get homeDiscountBanner => 'home.discountBanner'.tr();
  static String get homeDiscountSubtitle => 'home.discountSubtitle'.tr();
  static String get homeBeachTrips => 'home.beachTrips'.tr();
  static String get homeHistoricalTrips => 'home.historicalTrips'.tr();
  static String get homeMountainTrips => 'home.mountainTrips'.tr();
  static String get homeSafariTrips => 'home.safariTrips'.tr();
  static String get homeFamilyTrips => 'home.familyTrips'.tr();
  static String get homeCampingTrips => 'home.campingTrips'.tr();
  static String get navHome => 'home.navHome'.tr();
  static String get navNotifications => 'home.navNotifications'.tr();
  static String get navBookings => 'home.navBookings'.tr();
  static String get homeNavFavorites => 'home.navFavorites'.tr();
  static String get homeNavMore => 'home.navMore'.tr();

  // Bookings
  static String get bookingsTitle => 'bookings.title'.tr();
  static String get bookingsFilterAll => 'bookings.filterAll'.tr();
  static String get bookingsFilterAccepted => 'bookings.filterAccepted'.tr();
  static String get bookingsFilterPending => 'bookings.filterPending'.tr();
  static String get bookingsFilterCancelled => 'bookings.filterCancelled'.tr();
  static String get bookingsTotal => 'bookings.total'.tr();
  static String get bookingsDetails => 'bookings.details'.tr();

  // Trip Details
  static String get tripDetailsReviews => 'tripDetails.reviews'.tr();
  static String get tripDetailsGallery => 'tripDetails.gallery'.tr();
  static String get tripDetailsExcluded => 'tripDetails.excluded'.tr();
  static String get tripDetailsIncluded => 'tripDetails.included'.tr();
  static String get tripDetailsOverview => 'tripDetails.overview'.tr();
  static String get tripDetailsItinerary => 'tripDetails.itinerary'.tr();
  static String get tripDetailsDay => 'tripDetails.day'.tr();
  static String get tripDetailsPerPerson => 'tripDetails.perPerson'.tr();
  static String get tripDetailsAvailableSeats =>
      'tripDetails.availableSeats'.tr();
  static String get tripDetailsDays => 'tripDetails.days'.tr();
  static String get tripDetailsTransportIncluded => 'tripDetails.transport Included'.tr();
  static String get tripDetailsSaveForLater => 'tripDetails.saveForLater'.tr();

  // Booking Confirmation
  static String get bookingConfirmationTitle => 'bookingConfirmation.title'.tr();
  static String get bookingConfirmationNumberOfIndividuals => 'bookingConfirmation.numberOfIndividuals'.tr();
  static String get bookingConfirmationPerPerson => 'bookingConfirmation.perPerson'.tr();
  static String get bookingConfirmationSpecialNotes => 'bookingConfirmation.specialNotes'.tr();
  static String get bookingConfirmationSpecialNotesHint => 'bookingConfirmation.specialNotesHint'.tr();
  static String get bookingConfirmationPriceSummary => 'bookingConfirmation.priceSummary'.tr();
  static String get bookingConfirmationTripCost => 'bookingConfirmation.tripCost'.tr();
  static String get bookingConfirmationDiscount => 'bookingConfirmation.discount'.tr();
  static String get bookingConfirmationServiceFee => 'bookingConfirmation.serviceFee'.tr();
  static String get bookingConfirmationFinalPrice => 'bookingConfirmation.finalPrice'.tr();
  static String get bookingConfirmationConfirmBooking => 'bookingConfirmation.confirmBooking'.tr();
  static String get bookingConfirmationBookingPolicyAgree => 'bookingConfirmation.bookingPolicyAgree'.tr();
  static String get bookingConfirmationBookingPolicy => 'bookingConfirmation.bookingPolicy'.tr();

  // Booking Details
  static String get bookingDetailsTitle => 'bookingDetails.title'.tr();
  static String get bookingDetailsBookingData => 'bookingDetails.bookingData'.tr();
  static String get bookingDetailsBookingNumber => 'bookingDetails.bookingNumber'.tr();
  static String get bookingDetailsBookingDate => 'bookingDetails.bookingDate'.tr();
  static String get bookingDetailsStatus => 'bookingDetails.status'.tr();
  static String get bookingDetailsConfirmed => 'bookingDetails.confirmed'.tr();
  static String get bookingDetailsIndividuals => 'bookingDetails.individuals'.tr();
  static String get bookingDetailsAdults => 'bookingDetails.adults'.tr();
  static String get bookingDetailsPaymentMethod => 'bookingDetails.paymentMethod'.tr();
  static String get bookingDetailsBankCard => 'bookingDetails.bankCard'.tr();
  static String get bookingDetailsTotalPrice => 'bookingDetails.totalPrice'.tr();
  static String get bookingDetailsTripData => 'bookingDetails.tripData'.tr();
  static String get bookingDetailsDestination => 'bookingDetails.destination'.tr();
  static String get bookingDetailsTripDates => 'bookingDetails.tripDates'.tr();
  static String get bookingDetailsDuration => 'bookingDetails.duration'.tr();
  static String get bookingDetailsMeetingPoint => 'bookingDetails.meetingPoint'.tr();
  static String get bookingDetailsMeetingTime => 'bookingDetails.meetingTime'.tr();
  static String get bookingDetailsCancelBooking => 'bookingDetails.cancelBooking'.tr();
  static String get bookingDetailsContactUs => 'bookingDetails.contactUs'.tr();

  // Notifications Tab
  static String get notificationsTitle => 'notifications.title'.tr();
  static String get notificationsEmpty => 'notifications.empty'.tr();
  static String get notificationsJustNow => 'notifications.justNow'.tr();
  static String get notificationsHoursAgo => 'notifications.hoursAgo'.tr();
  static String get notificationsBookingConfirmed => 'notifications.bookingConfirmed'.tr();
  static String get notificationsBookingConfirmedDesc => 'notifications.bookingConfirmedDesc'.tr();
  static String get notificationsNewOffer => 'notifications.newOffer'.tr();
  static String get notificationsNewOfferDesc => 'notifications.newOfferDesc'.tr();

  // Favorites Tab
  static String get favoritesTitle => 'favorites.title'.tr();
  static String get favoritesEmpty => 'favorites.empty'.tr();

  // Profile Tab
  static String get profileTitle => 'profile.title'.tr();
  static String get profilePersonalData => 'profile.personalData'.tr();
  static String get profileEditAccount => 'profile.editAccount'.tr();
  static String get profileChangePassword => 'profile.changePassword'.tr();
  static String get profileHelpSupport => 'profile.helpSupport'.tr();
  static String get profileAboutApp => 'profile.aboutApp'.tr();
  static String get profileLogout => 'profile.logout'.tr();
  static String get loginAdmin => 'buttons.loginAdmin'.tr();

  // Admin
  static String get adminDashboardTitle => 'admin.dashboardTitle'.tr();
  static String get adminWelcomeMessage => 'admin.welcomeMessage'.tr();
  static String get adminOverview => 'admin.overview'.tr();
  static String get adminTotalTrips => 'admin.totalTrips'.tr();
  static String get adminTotalBookings => 'admin.totalBookings'.tr();
  static String get adminActiveUsers => 'admin.activeUsers'.tr();
  static String get adminRevenue => 'admin.revenue'.tr();
  static String get adminManageTrips => 'admin.manageTrips'.tr();
  static String get adminManageBookings => 'admin.manageBookings'.tr();
  static String get adminManageUsers => 'admin.manageUsers'.tr();
  static String get adminAnalytics => 'admin.analytics'.tr();
  static String get adminQuickActions => 'admin.quickActions'.tr();
  static String get adminAddTrip => 'admin.addTrip'.tr();
  static String get adminSwitchUserMode => 'admin.switchUserMode'.tr();
  static String get adminTripsTitle => 'admin.tripsTitle'.tr();
  static String get adminFilterPublished => 'admin.filterPublished'.tr();
  static String get adminFilterUnpublished => 'admin.filterUnpublished'.tr();
  static String get adminFilterDraft => 'admin.filterDraft'.tr();
  static String get adminEditTrip => 'admin.editTrip'.tr();
  static String get adminDeleteTrip => 'admin.deleteTrip'.tr();
  static String get adminRepublishTrip => 'admin.republishTrip'.tr();
  static String get adminViewTrip => 'admin.viewTrip'.tr();
  static String get adminAddTripTitle => 'admin.addTripTitle'.tr();
  static String get adminStepBasicInfo => 'admin.stepBasicInfo'.tr();
  static String get adminStepPriceAndDates => 'admin.stepPriceAndDates'.tr();
  static String get adminStepMediaAndServices => 'admin.stepMediaAndServices'.tr();
  static String get adminStepItinerary => 'admin.stepItinerary'.tr();
  static String get adminTripTitleLabel => 'admin.tripTitleLabel'.tr();
  static String get adminTripTitleHint => 'admin.tripTitleHint'.tr();
  static String get adminTripDescLabel => 'admin.tripDescLabel'.tr();
  static String get adminTripDescHint => 'admin.tripDescHint'.tr();
  static String get adminOriginLabel => 'admin.originLabel'.tr();
  static String get adminOriginHint => 'admin.originHint'.tr();
  static String get adminDestinationLabel => 'admin.destinationLabel'.tr();
  static String get adminDestinationHint => 'admin.destinationHint'.tr();
  static String get adminPriceLabel => 'admin.priceLabel'.tr();
  static String get adminPriceHint => 'admin.priceHint'.tr();
  static String get adminCapacityLabel => 'admin.capacityLabel'.tr();
  static String get adminCapacityHint => 'admin.capacityHint'.tr();
  static String get adminStartDateLabel => 'admin.startDateLabel'.tr();
  static String get adminEndDateLabel => 'admin.endDateLabel'.tr();
  static String get adminCoverImageLabel => 'admin.coverImageLabel'.tr();
  static String get adminCoverImageHint => 'admin.coverImageHint'.tr();
  static String get adminGalleryLabel => 'admin.galleryLabel'.tr();
  static String get adminGalleryHint => 'admin.galleryHint'.tr();
  static String get adminIncludedLabel => 'admin.includedLabel'.tr();
  static String get adminIncludedHint => 'admin.includedHint'.tr();
  static String get adminExcludedLabel => 'admin.excludedLabel'.tr();
  static String get adminExcludedHint => 'admin.excludedHint'.tr();
  static String get adminCancelPolicyLabel => 'admin.cancelPolicyLabel'.tr();
  static String get adminCancelPolicyHint => 'admin.cancelPolicyHint'.tr();
  static String get adminAddDayButton => 'admin.addDayButton'.tr();
  static String get adminAddActivityButton => 'admin.addActivityButton'.tr();
  static String get adminActivityTitleLabel => 'admin.activityTitleLabel'.tr();
  static String get adminActivityTimeLabel => 'admin.activityTimeLabel'.tr();
  static String get adminActivityLocationLabel => 'admin.activityLocationLabel'.tr();
  static String get adminNextStep => 'admin.nextStep'.tr();
  static String get adminPreviousStep => 'admin.previousStep'.tr();
  static String get adminPublishTrip => 'admin.publishTrip'.tr();
  static String get adminSaveDraft => 'admin.saveDraft'.tr();
  static String get adminPickCoverImage => 'admin.pickCoverImage'.tr();
  static String get adminPickGalleryImages => 'admin.pickGalleryImages'.tr();
  static String get adminPickActivityImageOptional => 'admin.pickActivityImageOptional'.tr();
  static String get adminAddCustomService => 'admin.addCustomService'.tr();
  static String get adminPresetIncludedServices => 'admin.presetIncludedServices'.tr();
  static String get adminPresetExcludedServices => 'admin.presetExcludedServices'.tr();
  static String get adminBookingRequestsTitle => 'admin.bookingRequestsTitle'.tr();
  static String get adminFilterPending => 'admin.filterPending'.tr();
  static String get adminFilterAccepted => 'admin.filterAccepted'.tr();
  static String get adminFilterRejected => 'admin.filterRejected'.tr();
  static String get adminAcceptRequest => 'admin.acceptRequest'.tr();
  static String get adminRejectRequest => 'admin.rejectRequest'.tr();
  static String get adminAcceptedBanner => 'admin.acceptedBanner'.tr();
  static String get adminRejectedBanner => 'admin.rejectedBanner'.tr();
  static String get adminPassengersCountLabel => 'admin.passengersCountLabel'.tr();
  static String get adminTotalAmountLabel => 'admin.totalAmountLabel'.tr();
  static String get adminBookingDetailsTitle => 'admin.bookingDetailsTitle'.tr();
  static String get adminCustomerDataSection => 'admin.customerDataSection'.tr();
  static String get adminTripDataSection => 'admin.tripDataSection'.tr();
  static String get adminBookingDetailsSection => 'admin.bookingDetailsSection'.tr();
  static String get adminCustomerNotesSection => 'admin.customerNotesSection'.tr();
  static String get adminBookingNumberLabel => 'admin.bookingNumberLabel'.tr();
  static String get adminRequestDateLabel => 'admin.requestDateLabel'.tr();
  static String get adminPaymentMethodLabel => 'admin.paymentMethodLabel'.tr();
  static String get adminCancelBooking => 'admin.cancelBooking'.tr();
  static String get adminContactCustomer => 'admin.contactCustomer'.tr();
  static String get adminBookingAcceptedTitle => 'admin.bookingAcceptedTitle'.tr();
  static String get adminBookingAcceptedDesc => 'admin.bookingAcceptedDesc'.tr();
  static String get adminBookingRejectedTitle => 'admin.bookingRejectedTitle'.tr();
  static String get adminBookingRejectedDesc => 'admin.bookingRejectedDesc'.tr();
  static String get adminBookingPendingTitle => 'admin.bookingPendingTitle'.tr();
  static String get adminBookingPendingDesc => 'admin.bookingPendingDesc'.tr();

  // General & Missing
  static String get currencyEGP => 'ج.م';
  static String get tripDetailsPriceFrom => 'السعر يبدأ من';
  static String get settingsTitle => 'الإعدادات';
  static String get adminFilterAllTrips => 'جميع الرحلات';
  static String get adminPendingBookings => 'الحجوزات المعلقة';
  static String get adminTotalRevenue => 'إجمالي الإيرادات';
  static String get bookingsViewDetails => 'عرض التفاصيل';
}
