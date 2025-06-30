#include "TestLevelGenerator.hpp"

Level* TestLevelGenerator::generateLevel( int seed ) const
{
	Random random;
	random.seed(seed);

	// Level Length
	Level* level = new Level( 224, 32 );

	// Ground tiles
	level->addTile( 0, 0, TYPE_GROUND, 224, 1 );

	level->setTileData( level->addTile( 15, 4, TYPE_QUESTION_BLOCK ), "contents", "mushroom" );
	level->setTileData( level->addTile( 16, 4, TYPE_QUESTION_BLOCK ), "contents", "flower" );
	level->setTileData( level->addTile( 17, 4, TYPE_QUESTION_BLOCK ), "contents", "leaf" );
	level->setTileData( level->addTile( 18, 4, TYPE_QUESTION_BLOCK ), "contents", "star" );
	level->setTileData( level->addTile( 19, 4, TYPE_QUESTION_BLOCK ), "contents", "mushroom_1up" );
	level->setTileData( level->addTile( 20, 4, TYPE_QUESTION_BLOCK ), "coins", 1 );
	level->addTile( 21, 4, TYPE_BRICK );
	level->setTileData( level->addTile( 22, 4, TYPE_BRICK ), "coins", 5 );
	//level->addTile( 23, 4, TYPE_CEMENT_BLOCK );

	level->addTile( 27, 1, TYPE_PIPE_UP, 2, 2 );
	level->addTile( 29, 1, TYPE_PIPE_DOWN, 2, 2 );
	level->addTile( 31, 1, TYPE_PIPE_LEFT, 2, 2 );
	level->addTile( 33, 1, TYPE_PIPE_RIGHT, 2, 2 );

	level->addTile( 35, 1, TYPE_WATER, 3, 6 );

	level->addTile( 40, 1, TYPE_SLOPE_UP, 1, 1 );
	level->addTile( 41, 1, TYPE_SLOPE_DOWN, 1, 1 );

	level->addTile( 43, 1, TYPE_SLOPE_UP, 2, 1 );
	level->addTile( 45, 1, TYPE_SLOPE_DOWN, 2, 1 );

	level->addTile( 50, 1, TYPE_GROUND, 3, 3 );

	level->addSprite( 16, 1, TYPE_KOOPA );

	level->addSprite( 198, 1, TYPE_LEVEL_END );

	return level;
}