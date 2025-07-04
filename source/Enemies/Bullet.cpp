#include "Bullet.hpp"
#include "../Sprites/Particle.hpp"
#include "../GameFeatures/World.hpp"

Bullet::Bullet()
{
	setGravityEnabled(false);
	setTileCollisionsEnabled(false);
	setKickable(false);
	setStompable(true);
	setAnimation("bullet");
	setBounceOffEnemiesEnabled(false);
	setHeight(BULLET_HEIGHT);
	setFireproof(true);
}
