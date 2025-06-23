#ifndef PIPE_HPP
#define PIPE_HPP

#include "../Engine/Enums.hpp"
#include "../GameFeatures/WorldMap/Location.hpp"
#include "../Engine/Tile.hpp"

/**
 * A warp pipe.
 */
class Pipe : public Tile
{
public:
	/**
	 * Create a pipe without a warp.
	 */
	Pipe( Direction orientation );

	/**
	 * Create a warp pipe.
	 */
	Pipe( Direction orientation, Location warpLocation );

	/**
	 * Get the orientation of the pipe.
	 *
	 * @return the direction that the opening of the pipe faces.
	 */
	Direction getOrientation() const;

	/**
	 * Get the location that the pipe warps to.
	 */
	const Location& getWarpLocation() const;

private:
	Direction orientation;
	Location warpLocation;
};

#endif // PIPE_HPP
