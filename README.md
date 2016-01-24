# primitives

Create noise tiles for use in your Kha project. Can be used directly as Kha library included in khafile.js.  

## Getting started
- Clone into 'your_kha_project/Libraries'
- Add 'project.addLibrary('noisetile');' into khafile.js
``` hx

// in your project init

public function new() {
	//..	
		//var nt = new NoiseTile(/* tilesx, tilesy, tileimgwidth*/);
		var nt = new NoiseTile(10,10,16);
		var tiles = nt.getNoiseTiles()
	//...
	//...
}
//...
//...
```