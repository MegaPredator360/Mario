#ifndef LEVELEND_HPP
#define LEVELEND_HPP

#include "../GameFeatures/Sprite.hpp"

/**
 * A sprite that causes a level to end when the player collides with it.
 */
class LevelEnd : public Sprite
{
public:
	LevelEnd();

private:
	void onPreUpdate();
};

#endif // LEVELEND_HPP
