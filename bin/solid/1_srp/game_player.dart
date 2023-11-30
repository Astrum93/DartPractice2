// Property 분리
import 'player_game_property.dart';
import 'player_profile.dart';

class GamePlayer {
  GamePlayer(this.playerProfile,{required this.playerGameProperty});

  PlayerProfile playerProfile;
  PlayerGameProperty playerGameProperty;
}


