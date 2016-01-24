package noisetile;

import js.Browser;
import noisetile.SimplexNoise;

@:expose
class Tiles {

	public var tiles : Array<Dynamic> = new Array();
	//public static var TILES :Int = 80;
    //public static var HEIGHTMAPSIZE 	: Int = 16;  

    public function new(x : Int= 10,y : Int = 10, hw: Int = 16) {
        for ( i in 0...x ) {
            for (j in 0...y) {
            	 addTile(i,j,hw);
            }
    	}
    }

    public function getNoiseTiles() {
    	return tiles;
    }


	public function allocateHMap(width, depth){
		var heightMap : Array<Array<Array<Float>>>	= new Array();
		for(x in 0...width){
			heightMap[x] = new Array();
			for(z in 0...depth){
				heightMap[x][z] = new Array();
			}
		}
		return heightMap;
	}

	public  function SHMap(heightMap:Dynamic,xx,zz){
		var width	= heightMap.length;
		var depth	= heightMap[0].length;
		 
		var simplex	= new SimplexNoise();

		for(x  in xx...(width+xx)){
			for(z in zz...(depth+zz)){
				var height:Float	= 0;
				var level	= 8;
				height	+= (simplex.noise((x)/level, (z)/level)/2 + 0.5) * 0.25;
				level	*= 3;
				height	+= (simplex.noise((x)/level, (z)/level)/2 + 0.5) * 0.7;
				level	*= 2;
				height	+= (simplex.noise((x)/level, (z)/level)/2 + 0.5) * 1;
				level	*= 2;
				height	+= (simplex.noise((x)/level, (z)/level)/2 + 0.5) * 1.8;
				height	/= 1+0.5+0.25+0.125;
				height *=1.4;

				var xs = 0;
				var ys = 0;
				 
				xs = x - 500;
				xs = xs * xs;
				 
				ys = z - 500;
				ys = ys * ys;
				 
				var d= Math.sqrt( xs + ys );
				  
				height-=(d/100)*d/2000 - 4*(10000 - xs+10000 - ys)/500000;

				heightMap[x-xx][z-zz]	= height*20+50;
			}
		}
		return heightMap;
	}

    public function addTile(x, y,hw) {

		var heightMap = allocateHMap(hw, hw);
        heightMap = SHMap(heightMap, (hw - 1) * x, (hw - 1) * y);

        tiles.push(heightMap);

        /*var canvas : Dynamic= HMapToCanvas(heightMap);
        canvas.style.position='absolute';
        canvas.style.top=(y*16)+'px';
        canvas.style.left=(x*16)+'px';
        canvas.style.border='1px solid white';
        Browser.document.body.appendChild(canvas);*/
     }


	public function HMapToCanvas(heightMap:Dynamic){
		var width	= heightMap.length;
		var depth	= heightMap[0].length;
		var canvas : Dynamic = Browser.document.createElement('canvas');
		canvas.width	= width;
		canvas.height	= depth;
		canvas.style.position	= 'absolute';
		var context	= canvas.getContext("2d");
		for(x in 0...canvas.width){
			for(y in 0...canvas.height){
				var height	= Math.round(heightMap[x][y]*5+50);
				context.fillStyle	= "rgb("+(height)+","+(height)+","+(height)+")";
				context.fillRect(x, y, 1, 1);
			}
		}
		return canvas;
	}
}

