/**
 * 
 */
var create = {
     ////////////////////////////////////////////////////////////////////////
     //                           sky                                      //  dark-s_nx.jpg
     ////////////////////////////////////////////////////////////////////////./images/dark-s_nx.jpg
      sky : function() {
    	 
     var texture = THREE.ImageUtils.loadTexture( "./images/sky.jpg" );
     /*var shader = THREE.shaderUtils.lib["cube"];
     var uniforms = THREE.UniformsUtils.clone( shader.uniforms );
     uniforms['tCube'].texture = texeure;
     var material = new THREE.MeshShaderMaterial({
    	 fragmentShader: shader.fragmentShader,
    	 vertexShader: shader.vertexShader,
    	 uniforms: uniforms
    	 
     });*/
     
     // divide texture
     /*var tex = new Array();
     var skygeometry = new THREE.BoxGeometry( 1000, 1000, 1000, 1, 1, 1, null, true );
     skygeometry.faceVertexUvs[0] = [];
     

     for ( var i = 0 ; i < 2 ; i++ ) {
      	 for ( var j = 0 ; j < 3 ; j++ ){
      		 
             tex[i*3+j] = [
                       new THREE.Vector2(((i)*0.5), ((j)*0.3333333)),
                       new THREE.Vector2(((1+i)*0.5), ((j)*0.3333333)),
                       new THREE.Vector2(((1+i)*0.5), ((1+j)*0.3333333)),
                       new THREE.Vector2(((i)*0.5), ((1+j)*0.3333333))
                       
                      ];
 
      	 } // for 
     } // for
     
     skygeometry.faceVertexUvs[0][0] = [ tex[0][0], tex[0][1], tex[0][3] ];
     skygeometry.faceVertexUvs[0][1] = [ tex[0][1], tex[0][2], tex[0][3] ];
	 
     skygeometry.faceVertexUvs[0][2] = [ tex[1][0], tex[1][1], tex[1][3] ];
     skygeometry.faceVertexUvs[0][3] = [ tex[1][1], tex[1][2], tex[1][3] ];
	 
     skygeometry.faceVertexUvs[0][4] = [ tex[2][0], tex[2][1], tex[2][3] ];
     skygeometry.faceVertexUvs[0][5] = [ tex[2][1], tex[2][2], tex[2][3] ];
	 
     skygeometry.faceVertexUvs[0][6] = [ tex[3][1], tex[3][2], tex[3][3] ];
     skygeometry.faceVertexUvs[0][7] = [ tex[3][1], tex[3][2], tex[3][3] ];
	 
     skygeometry.faceVertexUvs[0][8] = [ tex[4][0], tex[4][1], tex[4][3] ];
     skygeometry.faceVertexUvs[0][9] = [ tex[4][1], tex[4][2], tex[4][3] ];
	 
     skygeometry.faceVertexUvs[0][10] = [ tex[5][0], tex[5][1], tex[5][3] ];
     skygeometry.faceVertexUvs[0][11] = [ tex[5][1], tex[5][2], tex[5][3] ];*/
     texture.minFilter = THREE.NearestFilter; // or THREE.LinearFilter
     
     var skygeometry = new THREE.SphereGeometry( 2300, 500, 500 );
     //var skygeometry = new THREE.BoxGeometry( 3000, 1000, 3000 ) ;
    	 
     var material = new THREE.MeshBasicMaterial( { map:texture } );
     var skyboxMesh = new THREE.Mesh( skygeometry, material );
     skyboxMesh.material.side = THREE.BackSide;
     return skyboxMesh;
     //skyboxMesh.position.y = 1000 ;
     //scene.add( skyboxMesh );
     /*/////
     
     var imagePrefix = "images/dawnmountain-";
	 var directions  = ["xpos", "xneg", "ypos", "yneg", "zpos", "zneg"];
	 var imageSuffix = ".png";
	 var skyGeometry = new THREE.CubeGeometry( 5000, 5000, 5000 );	
	
	 var materialArray = [];
	 for (var i = 0; i < 6; i++)
		materialArray.push( new THREE.MeshBasicMaterial({
			map: THREE.ImageUtils.loadTexture( imagePrefix + directions[i] + imageSuffix ),
			side: THREE.BackSide
		}));
	 var skyMaterial = new THREE.MeshFaceMaterial( materialArray );
	 var skyBox = new THREE.Mesh( skyGeometry, skyMaterial );
     */
     },

     ////////////////////////////////////////////////////////////////////////
     //                           ground                                   //  
     ////////////////////////////////////////////////////////////////////////
     ground : function( ground_PixX, ground_PixZ, ground_NumX, ground_NumZ ){
    	
     // THREEX	 
     //var heightMap = THREEx.Terrain.allocateHeightMap( 100, 200 );	 -1000 1000
     //THREEx.Terrain.simplexHeightMap( heightMap );
     //var geometry = THREEx.Terrain.heightMapToPlaneGeometry( heightMap );
     //var geometry = THREEx.Terrain.heightMapToPlaneGeometry( heightMap );
     //THREEx.Terrain.heightMapToVertexColor( heightMap, geometry );    
    	 var NoiseGen = new SimplexNoise;
    	 var worldWidth = 128, worldDepth = 128;
    	 var geometry = new THREE.PlaneGeometry( ground_PixX, ground_PixZ, ground_NumX, ground_NumZ );
    	 geometry.mergeVertices();
    	 geometry.computeFaceNormals();
    	 geometry.computeVertexNormals();
    	 //geometry.computeMorphNormals();

    	 //geometry.applyMatrix( new THREE.Matrix4().makeRotationX( - Math.PI / 2 ) );
/*
			for ( var i = 0; i < geometry.vertices.length; i ++ ) {
                var vertex = geometry.vertices[i];
                vertex.z = NoiseGen.noise( vertex.x/10, vertex.y/10) * 2;
				//geometry.vertices[ i ].y = 35 * Math.sin( i/2 );

			}
			
			geometry.computeFaceNormals();
			geometry.computeVertexNormals();*/
			
     var textureURL = "./images/grass.jpg" ;
     var texture = [3];
     var maxAnisotropy = renderer.getMaxAnisotropy();
     
     texture[0] = THREE.ImageUtils.loadTexture( textureURL );
     texture[1] = THREE.ImageUtils.loadTexture( "./images/rock.jpg" );
     texture[2] = THREE.ImageUtils.loadTexture( "./images/dirt.jpg" );
     
     
     for ( var i = 0 ; i < texture.length; i++ ) {
         texture[i].wrapS =  texture[i].wrapT = THREE.RepeatWrapping;
         texture[i].repeat.set( 25, 25 );
         texture[i].anisotropy = maxAnisotropy/2;
     } // for
     
     
     
     
     // MeshFaceMaterial
     var materials = [];
     for ( var i = 0 ; i < texture.length; i++ ) {
         materials.push( 
    		 
        		    new THREE.MeshPhongMaterial( { 
        		        map: texture[i], 
        		        color: 0xffffff,
        		        wireframe: false,
        		        shading: THREE.SmoothShading,
        		        transparent: true
        		        //opacity: 0.1,
        		        //morphTargets: true
        		        //morphNormals: true
        		        
        		        //vertexColors: THREE.VertexColors
    	 
        		    } ) 
         );
     } // for
     
     
     
     var groundMaterial = 
     
     //for ( var i = 0 ; i < texture.length; i++ )
    //	 groundMaterials.push(
    			 
    			 Physijs.createMaterial(
    			    		new THREE.MeshFaceMaterial(materials), 
    			            .0, // high friction
    			            .4 // low restitution
    			     );
    	    	 
    	 //);
     
     
     //groundMaterial.map.wrapS = groundMaterial.map.wrapT = THREE.RepeatWrapping;
     //groundMaterial.map.repeat.set( 400, 400 ); 
     //groundMaterial.map.wrapS = groundMaterial.map.wrapT = THREE.ClampToEdgeWrapping;
     //groundMaterial.map.minFilter = THREE.LinearFilter; //THREE.NearestFilter;// or THREE.LinearFilter
    /* texture.wrapS = THREE.ClampToEdgeWrapping ;
     texture.wrapT = THREE.ClampToEdgeWrapping ;
     texture.minFilter = THREE.NearestFilter ;
     texture.repeat.x = 1 ;
     texture.repeat.y = 1 ;*/
     //texture.anisotropy = 100 ; 
     /*
     var l = geometry.faces.length / 2;
     //console.log(geometry.faces.length);
     for( var i = 0; i < l; i ++ ) {
         var j = 2 * i;
         geometry.faces[ j ].materialIndex = i % 3;
         geometry.faces[ j + 1 ].materialIndex = i % 3;
     }
     */
     
     var ground = new Physijs.HeightfieldMesh(
    	geometry,//new THREE.BoxGeometry( 2000, 1, 2000 ),
    	groundMaterial,
    	0 // mass

     );
         
     //mesh.lookAt( new THREE.Vector3( 0, 1, 0 ) );
     //mesh.position.z = 0 ;
     ground.rotation.x = Math.PI / -2;
     ground.receiveShadow = true;
     //objects.push( mesh );
     return ground;
     
     },
     
     
     ////////////////////////////////////////////////////////////////////////
     //                           cube                                     //  
     ////////////////////////////////////////////////////////////////////////
     
     cube : function( x, y, z){
     var texture = THREE.ImageUtils.loadTexture("./images/tx_9.jpg",null,function(t)
		     {
	    });	 
     
     var playerMaterial = Physijs.createMaterial(
    	 new THREE.MeshBasicMaterial( { map:texture } ),
    	 .0, // low friction
		 .0 // high restitution
		 
     );
     
     
     cube = new Physijs.SphereMesh(
    	new THREE.SphereGeometry( 10, 100, 100 ),
    	playerMaterial,
    	100//0
     );
     
     //console.log( new THREE.SphereGeometry( 10, 100, 100 ) );
     cube.position.x = x;
	 cube.position.y = y;
	 cube.position.z = z;
	 // objects.push( cube );

	 
	 return cube;
     },
	 /*
     var obMaterial = Physijs.createMaterial(
         new THREE.MeshBasicMaterial( { color: 0xeeeeee } ),		 
         .4,
         .6
     );
	 

     ob = new Physijs.BoxMesh( 
         new THREE.BoxGeometry( 20, 20, 20 ),
    	 obMaterial,
    	 100//50	 
     ) ;
     
     ob.position.x = -50;
	 ob.position.z = -100;
	 ob.position.y = 50;
	 
	 objects.push( ob );
	 scene.add(ob);*/

   
   ////////////////////////////////////////////////////////////////////////
   //                           car                                      //  
   ////////////////////////////////////////////////////////////////////////
   car : function() {
	   
	   
   
   var loader = new THREE.JSONLoader() ;
   loader.load( "./obj/car.js", function(geometry){
	   
	   // var material = new THREE.MeshPhongMaterial( { color: 0xffffff } );
	                     
	   var material = Physijs.createMaterial( 
			   
			   new THREE.MeshPhongMaterial( { color: 0xffffff } ),
			   .1,
			   .2
	   );
	   

	   
	   var mesh = new Physijs.ConvexMesh( geometry, material );
	   mesh.position.x = 200;
	   //mesh.position.y = 100;
	   mesh.position.z = 200;
	  

	  return mesh;
	   
   } );
   
   
   },
   ////////////////////////////////////////////////////////////////////////
   //                           soldier                                  //  
   ////////////////////////////////////////////////////////////////////////
   
   soldier : function(){ 
  
   var loader = new THREE.TGALoader();
   var texture = loader.load( "./obj/TriadSoldier/T_CH_MNPCtriadSoldier_cm.tga" );
   var material = new THREE.MeshPhongMaterial( { map: texture, side: THREE.DoubleSide } );
   
   THREE.Loader.Handlers.add( /\.dds$/i, new THREE.DDSLoader() );
   
   var loader = new THREE.OBJLoader();
   loader.load( "./obj/TriadSoldier/CtriadSoldier.obj", function( object ){
	  object.traverse( function( child ){
		  if ( child instanceof THREE.Mesh ) {
			  //child.material.map = texture;
		  }
		  
	  } ); 
	   
	  object.position.x = 200;
      object.position.z = 200;
	  scene.add( object );
   } );
   //
   
   
   var loader = new THREE.OBJMTLLoader();
   loader.load( "./obj/TriadSoldier/CtriadSoldier.obj", "./obj/TriadSoldier/CtriadSoldier.mtl",
		   function( object ){
	           object.position.x = 200;
	           object.position.z = 200;
	           
	           
	           scene.add( object );
	   
   });
   
  },
   ////////////////////////////////////////////////////////////////////////
   //                           castleWall  ERROR                        //  
   ////////////////////////////////////////////////////////////////////////
   castleWall : function(){
   
   var loader = new THREE.OBJMTLLoader();
   loader.load( "./obj/castledoor/castledoor.obj", "./obj/castledoor/castledoor.mtl",
		   function( object ){
	           //object.position.x = -500;
	           //object.position.z = -500;
	           //object.position.y = -30;
	           
	           

	           
	           /*object.traverse( function ( child ) {

	        	    if ( child instanceof THREE.Mesh ) {

	        	        //console.log( child.geometry );
                        var mesh = new Physijs.ConvexMesh( child.geometry, child.material, 0 );
                        mesh.position.x = mesh.position.z = -500;
                        scene.add(mesh);
	        	    }

	        	} );*/
	           
	           //scene.add( envir );
	           object.traverse( function ( child ) {
		           if ( child instanceof THREE.Mesh ) return object;
	           });
	   
	   
   });
  }
   /*
   var loader = new THREE.OBJLoader();

   loader.load( "./obj/castledoor/sirus city.obj", function( object ){
	  object.traverse( function( child ){
		  if ( child instanceof THREE.Mesh ) {
			  //child.material.map = texture;
		  }
		  
	  } ); 
	   
	  object.position.y = -35;
	  scene.add( object );
   } );
   */
  
  }