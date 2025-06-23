#include "../GameFeatures/Episode.hpp"
#include "GameSession.hpp"
#include "../GameFeatures/Level/Player.hpp"
#include "../GameFeatures/World.hpp"

GameSession::~GameSession()
{
	delete episode;
	delete player;
	delete world;
}
