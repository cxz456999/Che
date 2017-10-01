         
function Effect( rowColumn ) {
	//this.obj = this.particleSystem;
	this.particleSystem;
	this.particles;
	this.particleCount;

	this.row = rowColumn.x;
	this.column = rowColumn.z;
	this.height = rowColumn.y;
}



Effect.prototype.create = function(){
	var texloader = new THREE.TextureLoader();   
	var particleCount = 5000,
    particles = new THREE.Geometry();
	var pMaterial;
     // create the particle variables
	texloader.load( "images/effect/spark1.png", function(texture) {
		pMaterial = new THREE.PointsMaterial({
			color: 0xFFFFFF,
			size: 20,
			map: texture,
			blending: THREE.AdditiveBlending,
			transparent: true
		});
	});	  	    
    
   // now create the individual particles
   for (var p = 0; p < particleCount; p++) {

       // create a particle with random
       // position values, -250 -> 250
       var pX = Math.random() * 100 - 50,
           pY = Math.random() * 20 - 1,
           pZ = Math.random() * 100 - 50;
       while( (pX * pX + pY * pY + pZ * pZ) > 2500 ){
    	   pX = Math.random() * 100 - 50;
           pY = Math.random() * 20 - 1;
           pZ = Math.random() * 100 - 50;
       }
       
       
       var particle = new THREE.Vector3(pX, pY, pZ);
       /*
   	   particle.velocity = new THREE.Vector3(
			  0,              // x
			  -Math.random(), // y: random vel
			  0);
   	   */
       // add it to the geometry

       particles.vertices.push( particle );
    }
    
  
    // create the particle system
    var particleSystem = new THREE.Points(
    particles,
    pMaterial);
    
    particleSystem.sortParticles = true;
    
    particleSystem.position.set( -450 + this.row * 100, 1, -450 + this.column * 100 );
    // add it to the scene
    this.particleCount = particleCount;
    this.particles = particles;
    this.particleSystem = particleSystem;
	return particleSystem ;
}; // create()

Effect.prototype.update = function(){
	
	this.particleSystem.rotation.y += 0.1;
	//this.particleSystem.rotation.x += 0.01;
	//this.particleSystem.rotation.z += 0.01;
	this.particleSystem.position.y += 6;
	if ( this.particleSystem.position.y > 150 ){
	    //scene.remove( this.particleSystem );	
	    return false;
	} // if
	
	var pCount = this.particleCount;
	
	while (pCount--) {

	    // get the particle
	    
	      
	     
	    // check if we need to reset
	    /*if (particle.y < -200) {
	      particle.y = 200;
	      particle.y = 0;
	    }*/

	    // update the velocity with
	    // a splat of randomniz
	    //particle.y -= Math.random() * 0.1;

	    // and the position
	   // particle.addSelf(
	   //   particle);
	  }

	  // flag to the particle system
	  // that we've changed its vertices.
	  this.particleSystem.
	    geometry.
	    __dirtyVertices = true;
	  return true;
}; // update()


