/**
 * 
 */

 function Animation( kind ){
	 this.kind = kind;
	 this.obj;
	 this.speed;
	 this.start;
	 this.dirz;
	
	 //this.end;
	 ///// example
	 var privateVariable; // private member only available within the constructor fn
	 this.privilegedMethod = function () { // it can access private members
	    //..
	 };
 }

 Animation.prototype.getMorph = function( geometry, speed, duration, start, fudgeColor ) {
	 		this.start = start;
	 		//this.end = start.negate();
	 		this.speed = speed;
	 		if ( start.x > 0 ) this.dirz = -1;
			else this.dirz = 1;
	 		
			var material = new THREE.MeshLambertMaterial( { color: 0xffaa55, morphTargets: true, vertexColors: THREE.FaceColors } );

			if ( fudgeColor ) {

				material.color.offsetHSL( 0, Math.random() * 0.5 - 0.25, Math.random() * 0.5 - 0.25 );

			}

			var mesh = new THREE.Mesh( geometry, material );
			mesh.speed = speed;

			var mixer = new THREE.AnimationMixer( mesh );
			mixer.addAction( new THREE.AnimationAction( geometry.animations[0] ).warpToDuration( duration ) );
			mixer.update( 600 * Math.random() );
			mesh.mixer = mixer;

			mesh.position.set( start.x, start.y, start.z );
			mesh.rotation.y = Math.PI/2;

			mesh.castShadow = true;
			mesh.receiveShadow = true;
			this.obj = mesh;
			
	
 };
 
 Animation.prototype.animate = function(delta){
	 	var ran;
		this.obj.mixer.update( delta );
		//if ( this.kind == "bird" ) 
		//moveTo(  this, delta );	 //new THREE.Vector3( -1 + Math.random()*2, 0, -1 + Math.random()*2 )
		moveCircle( this.obj, delta, this.dirz);
		if ( this.obj.rotation.y >= Math.PI ) this.obj.rotation.y = Math.PI/2;
		if ( this.obj.position.x  > 2000 || this.obj.position.x < -2000 )  {
			if ( -1 + Math.random()*2 < 0 ) this.obj.position.x = -1200;
			else this.obj.position.x = 1200;
			if ( this.kind == "bird" ) {
				this.obj.position.z = -1500 + Math.random()*3000 ;
			}
			else 
				do{
					ran = -1500 + Math.random()*3000;
					this.obj.position.z = ran;
				}while( -800 <= ran && ran <= 800 );
			
			this.obj.rotation.y = -1 * Math.PI/2;
			console.log();
			if ( this.obj.position.x > 0 ) this.dirz = -1;
			else {
				this.dirz = 1;
				this.obj.rotation.y = Math.PI;
			} // else
			//mesh.rotation.y = Math.PI/2;
		} 
		
		
};

/*function moveTo( morph, delta ){
	var dir = this.end.sub( this.start );
	var totalDir = Math.sqrt( Math.pow(dir.x, 2)+ Math.pow(dir.y) + Math.pow(dir.z) );
	var speedX = dir.x * totalDir;//morph.speed * ( dir.x / totalDir); 
	var speedY = dir.y * totalDir;//morph.speed * ( dir.y / totalDir); 
	var speedZ = dir.z * totalDir;//morph.speed * ( dir.z / totalDir); 
	console.log( speedX + " " + speedY  );
	morph.obj.lookAt( dir );
	//morph.obj.rotation.y += 0.00001;
	morph.obj.position.x += speedX * delta;
	morph.obj.position.y += speedY * delta;
	morph.obj.position.z += speedZ * delta;
}*/

function moveCircle(morph, delta, dirz ){
	
	
	morph.position.x += morph.speed * delta * dirz;
	//morph.rotation.y += 0.00001* dirz;
	//morph.position.z -= morph.speed * delta * morph.rotation.y/morph.rotation.y/1000* dirz;
	//this.oldPo.x = morph.position.x, this.oldPo.y = morph.position.y, this.oldPo.z = morph.position.z;
}


/*
var Animation = {

getMorph : function( geometry, speed, duration, x, y, z, fudgeColor ) {

		var material = new THREE.MeshLambertMaterial( { color: 0xffaa55, morphTargets: true, vertexColors: THREE.FaceColors } );

		if ( fudgeColor ) {

			material.color.offsetHSL( 0, Math.random() * 0.5 - 0.25, Math.random() * 0.5 - 0.25 );

		}

		var mesh = new THREE.Mesh( geometry, material );
		mesh.speed = speed;

		var mixer = new THREE.AnimationMixer( mesh );
		mixer.addAction( new THREE.AnimationAction( geometry.animations[0] ).warpToDuration( duration ) );
		mixer.update( 600 * Math.random() );
		mesh.mixer = mixer;

		mesh.position.set( x, y, z );
		mesh.rotation.y = Math.PI/2;

		mesh.castShadow = true;
		mesh.receiveShadow = true;
		return mesh;
		
},

animate : function(delta){
	for ( var i = 0; i < morphs.length; i ++ ) {

		morph = morphs[ i ];

		morph.mixer.update( delta );

		moveCircle(morph, delta);

	}
	
},
}*/


