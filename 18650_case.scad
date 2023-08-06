////////////////////////////////////////////////////////////////////////////////
//                           18650 BATTERY CASE                               //
//                               Version 1.0                                  //
//                           BY JULIEN COPPOLANI                              //
//                        julien.coppolani@gmail.com                          //
////////////////////////////////////////////////////////////////////////////////

// This version has been edited to work with thingiverse customizer

// ALL VALUES ARE IN MILLIMETERS

// NUMBER OF CELLS IN A ROW
NB_ROWS=8; // [1:20]

// NUMBER OF CELLS IN A COLUMN
NB_COLUMNS=5; // [1:20]

// DISTANCE BETWEEN 18650 CELLS
DISTANCE=22; // [20:30]

// ALIGNMENT BETWEEN CELLS
ALIGNMENT="square"; // ["optimize", "square"]

// THICKNESS OF THE BOTTOM
BOTTOM_THICKNESS=2; // [1:5]

// WIDTH OF A CELL HOLE. DEFAULT = 18.6
HOLE_WIDTH=18.6; // [18.5:0.1:19]

// BATTERY COMPARTMENT HOLE DEPTH
COMPARTMENT_HOLE_DEPTH=25; // [5:60]

// BORDER
BORDER=5; // [1:20]

// CORNER RADIUS
CORNER_RADIUS=10; // [1:20]

/* [hidden] */
$fn=48;
HEIGHT = BOTTOM_THICKNESS + COMPARTMENT_HOLE_DEPTH;
START = BORDER + HOLE_WIDTH/2;

if (DISTANCE <= HOLE_WIDTH)
{
	echo("\n\nWARNING : DISTANCE BETWEEN EACH CELL MUST BE GREATER THAN THE DIAMETER OF A CELL !\n\n");
}
else if (ALIGNMENT=="square" || NB_ROWS==1 || NB_COLUMNS==1)
{
	LENGTH = (NB_ROWS-1) * DISTANCE + HOLE_WIDTH + BORDER * 2;
	WIDTH  = (NB_COLUMNS-1) * DISTANCE + HOLE_WIDTH + BORDER * 2;
	echo("\n\nLENGTH (MM) = ", LENGTH);
	echo("WIDTH (MM) = ",  WIDTH);
	echo("SURFACE IN SQUARE CENTIMETERS = ", LENGTH*WIDTH/100, "\n\n");
	difference()
	{
		hull()
		{   translate([CORNER_RADIUS, CORNER_RADIUS,0])
				cylinder(HEIGHT, d=CORNER_RADIUS*2);
			translate([LENGTH-CORNER_RADIUS, CORNER_RADIUS, 0])
				cylinder(HEIGHT, d=CORNER_RADIUS*2);
			translate([LENGTH-CORNER_RADIUS, WIDTH-CORNER_RADIUS,0])
				cylinder(HEIGHT, d=CORNER_RADIUS*2);
			translate([CORNER_RADIUS, WIDTH-CORNER_RADIUS,0])
				cylinder(HEIGHT, d=CORNER_RADIUS*2);
		}
		for(i=[0:1:NB_ROWS-1])
		{
			for (j=[0:1:NB_COLUMNS-1])
			{
				translate([START + i*DISTANCE, START + j*DISTANCE, BOTTOM_THICKNESS])
					cylinder(HEIGHT, d=HOLE_WIDTH);
			}
		}
	}
}
else if (ALIGNMENT == "optimize")
{
	LENGTH = (NB_ROWS-0.5) * DISTANCE + HOLE_WIDTH + BORDER * 2;
	WIDTH  = (NB_COLUMNS-1) * DISTANCE * sqrt(3)/2 + HOLE_WIDTH + BORDER * 2;
	echo("\n\nLENGTH (MM) = ", LENGTH);
	echo("WIDTH (MM) = ",  WIDTH);
	echo("SURFACE IN SQUARE CENTIMETERS = ", LENGTH*WIDTH/100, "\n\n");
	difference()
	{
		hull()
		{   translate([CORNER_RADIUS, CORNER_RADIUS,0])
				cylinder(HEIGHT, d=CORNER_RADIUS*2);
			translate([LENGTH-CORNER_RADIUS, CORNER_RADIUS, 0])
				cylinder(HEIGHT, d=CORNER_RADIUS*2);
			translate([LENGTH-CORNER_RADIUS, WIDTH-CORNER_RADIUS,0])
				cylinder(HEIGHT, d=CORNER_RADIUS*2);
			translate([CORNER_RADIUS, WIDTH-CORNER_RADIUS,0])
				cylinder(HEIGHT, d=CORNER_RADIUS*2);
		}		
		for(i=[0:1:NB_ROWS-1])
		{
			for (j=[0:1:NB_COLUMNS-1])
			{
				if (j%2==0) {
					translate([START + i*DISTANCE, START + j*DISTANCE*sqrt(3)/2, BOTTOM_THICKNESS])
						cylinder(HEIGHT, d=HOLE_WIDTH);
				}
				else
				{
					translate([START + i*DISTANCE + DISTANCE/2, START + j*DISTANCE*sqrt(3)/2, BOTTOM_THICKNESS])
						cylinder(HEIGHT, d=HOLE_WIDTH);
				}
			}
		}
	}
}
else
{
	echo("ALIGNMENT UNKNOWN. MUST BE \"SQUARE\" OR \"OPTIMIZE\"");
}