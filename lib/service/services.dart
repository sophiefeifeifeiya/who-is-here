import 'package:whoshere/model/chat_message.dart';
import 'package:whoshere/model/user.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

abstract class IUserService {
  /// Attempt to login with the given email and password and
  /// get the user profile.
  ///
  /// Stores access token and refresh token to a persistent storage.
  /// Throws ApiBrokerException if login failed.
  Future<User> login(String email, String password);

  /// Register a new account.
  ///
  /// Throws ApiBrokerException if failed.
  Future register(String email, String username, String password);

  /// Load previously logged in user from persistent storage.
  ///
  /// Returns null if cannot read access token and refresh token
  /// from persistent storage.
  Future<User?> loadLoggedInUser();

  UserTokenPair? get accessToken;
  UserTokenPair? get refreshToken;
}

abstract class IUserLocationService {
  /// The current location.
  ///
  /// You must first call startLocationUpdate() to update the location,
  /// otherwise the location is the default value and will not be updated.
  LatLng get currentLocation;

  Stream<LatLng> get onLocationUpdate;

  /// Start updating location from GPS
  void startLocationUpdate();

  void stopLocationUpdate();

  void dispose();

  Future<List<User>> getNearbyUsers();
}

abstract class IUserChatService {
  Stream<ChatNotification> get onMessageReceived;

  void connect();

  Future sendMessage(String receiverId, ChatMessage chatMessage);

  /// Load the chat history from local database
  ///
  /// chatPeerId: the userId of the user you chat with
  Future<Iterable<ChatMessage>> loadChatHistory(String chatPeerId);

  /// Save the chat message to local database
  Future saveMessage(String chatPeerId, ChatMessage chatMessage);
}

class ChatRequestException implements Exception {
  final int statusCode;
  final String? errorMessage;

  ChatRequestException({required this.statusCode, this.errorMessage});
}
