/**
 * 
 */

function setEnvirment( scene, theTree ){
	var rangeFrom = new THREE.Vector3( -1200, 0, -1200 );
	var rangeTo = new THREE.Vector3( 1200, 0, 1200 );
	var numOfAdd = 100;
	var position = [] ;
	for ( var i = 0; i < 4; i++ ) position.push(0);
	
	for ( var i = -1500; i <= 1500; i+=300 ) {	
		/*for ( var j = 900; j <= 1100; j+= 200 ) { // x
			var tree = theTree.clone();
			var x = i + ( -300 + Math.random() * 300), y = 0, z = -200 + j*(-1) - ( -100 + Math.random() * 100);
			tree.position.set(x, y, z);
			scene.add( tree );
			var tree2 = theTree.clone();
			x = i + ( -300 + Math.random() * 300), y = 0, z = j + ( -100 + Math.random() * 100);
			tree2.position.set(x, y, z);
			scene.add( tree2 );
		} // for*/
		
		//if (  -1200 <= i|| i <= 1200  )
		
		for ( var j = 900; j <= 3000; j+= 160 ) { // z
			var tree = theTree.clone();
			var x = j*(-1) + ( -100 + Math.random() * 100) , y = 0, z = i + ( -600 + Math.random() * 600);
			tree.position.set(x, y, z);
			scene.add( tree );
			var tree2 = theTree.clone();
			x = j + ( -100 + Math.random() * 100) , y = 0, z = i + ( -600 + Math.random() * 600);
			tree2.position.set(x, y, z);
			scene.add( tree2 );
		} // for
		
	}
	
	console.log( "add" );
}