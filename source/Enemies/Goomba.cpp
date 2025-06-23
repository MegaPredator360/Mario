#include "../Utils/Globals.hpp"
#include "Goomba.hpp"
#include "../Sprites/Particle.hpp"
#include "../GameFeatures/World.hpp"

Goomba::Goomba()
{
	setDefaultXVelocity(-1.0 * MOVEMENT_SPEED);
	setWidth(WIDTH);
	setHeight(HEIGHT);

	setAnimation("goomba");
}

void Goomba::onStomp()
{
	getWorld().addSprite(getX(), getY() + 0.1, new Particle(getAnimation("goomba_dead"), DEAD_PARTICLE_DURATION));
	kill();
}
