<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Chess Lord</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/three.js"></script>


<script src="<%=request.getContextPath()%>/controls/OrbitControls.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/MTLLoader.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/OBJLoader.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/OBJMTLLoader.js"></script>

<script src="<%=request.getContextPath()%>/js/Envirment.js"></script>
<script src="<%=request.getContextPath()%>/js/Effect.js"></script>
<script src="<%=request.getContextPath()%>/js/Animation.js"></script>

<!--<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-ui.js"></script>
   <link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery-ui.css">-->

<style>

  html, body {
	width: 100em;
	height: 100em;
	overflow:hidden;
    margin:0;
    padding:0;
  }
  
  #container, #pre{
    margin:0;
    padding:0;
    overflow:hidden;
    width:100%;
    height:80%;
    position: absolute;
    //display:none;
   
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
    
  }

 
  #infoTable{
    margin:0;
    padding:0;
    overflow:hidden;
    width:100%;
    height:20%;
    position: absolute;
    top:80%;
    background:gray;
    /*
    background:url("<%=request.getContextPath()%>/images/infoTable.jpg") no-repeat center center fixed;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
    */
  }

  #movingMons{
    cursor:pointer;
  }
  
  .role{
    height: 20%;
    width:auto;
    cursor:pointer;
  }
  
</style>
<script>

</script>
     
<script>
/* Time */
var maxTime = 10, tCounter, stopTimer = false;
function timeCounter( time ){
    
	if ( stopTimer ) return false;

	if ( preLoad( numOfReady / totalReady * 100 ) ) {// if ( time < 0 ) {
		// $( "#movingMons" ).val( "Start Moving" );
		//console.log( "Moving ");
		//setTimeImage( -1 );
		//$( "#movingMons" ).click();
		//time = maxTime;
		
		stopTimeCounter();
		return false;
	} // if
	
	//preLoad( time );
	//setTimeImage( time-- );// $( "#movingMons" ).val( time-- );
	tCounter = setTimeout( "timeCounter(" + --time + ")", 1000 );
	return true;
}

function stopTimeCounter(){
	stopTimer = true;
	clearTimeout( tCounter );
}

function resetTimer( time ){
	stopTimer = false;
	clearTimeout( tCounter );
	maxTime = time;
	timeCounter( time );
} // resetTimer()

function setTimeImage( time ){
	
	var imgSrcHead = "<%=request.getContextPath()%>/images/time/";
	var imgFormat = ".png";
	var content = "";
  
	if ( time >= 0 ) {
	    var first = time / 10, second = time%10;	
	    var imgSrc1 = imgSrcHead + first + imgFormat, imgSrc2 = imgSrcHead + second + imgFormat;
		if ( first >= 1 ) content = "<td><img src = " + imgSrc1 + " /></td>";
	    content += "<td><img src = " + imgSrc2 + " /></td>";
	} // if
	else{
		console.log( "mov" );
		var imgSrc = imgSrcHead + "Moving" + imgFormat;
		content = "<td><img src = " + imgSrc + " /></td>";
	} // else
	
	$( "#time" ).html( content );
	
} // setTimeImage()

function preLoad( time ){
	if ( time < 100 ){ // if ( time > 0 )
		$("#pre").html( "<h1>Loading... <br>" + Math.floor(time) + " %</h1>" );
		return false;
	} // if
	//else {
		show3D();
		console.log( "pre" );
		return true;
	//} // else
}
</script>
<script>
/* Money Image */
function setMoneyImage( money ){
	
	var imgSrcHead = "<%=request.getContextPath()%>/images/time/";
	var imgFormat = ".png";
	var content = "";
    var value = 0;
	for ( var i = 0; Math.round(money) > 0; i++ ) {
	    value = money % 10;
	    var imgSrc = imgSrcHead + Math.round(value) + imgFormat;
	    
		content = "<td><img src = " + imgSrc + " /></td>" + content;
		money /= 10;
	} // for
	
	$( "#money" ).html( content );
	
} // setTimeImage()

</script>
<script>
/* Role Option */

function changeCurrentRole( role ){
	
	//console.log( role.index );
	//if ( $( "#cd" + role.index ) )
	//if ( totalRole[role.index].cd > 0  ) currentRole = null;
	for ( var i = 0; i < totalRole.length; i++ ) {
		$( totalRole[i].id + "Role" ).css( "opacity", "0.2" );
	} // for
	
	currentRole = totalRole[role.index];
	$( currentRole.id + "Role" ).css( "opacity", "1" );
	choosedRole = null; /// 沒等於null就無法放怪物
} // changeCurrentRole()

var currentID = "";
var src = "<%=request.getContextPath()%>/images/roleINTRO/";
function showRoleMessage( rowColumn ) {
	
	for ( var i = 0; i < monsterList.length; i++ )
  	  if ( monsterList[i].row === rowColumn.x && monsterList[i].column === rowColumn.z ){
  		  var id = monsterList[i].id;
  		  //if ( currentID == id ) return false;
  		  $( "#showRoleInfo" ).html( "" );
  		  currentID = id;
  		  var td = document.createElement( "td" );
  		  var img = document.createElement( "img" );
  		  img.src = src + id.substr(1, id.length ) + "INTRO.jpg";
  		  img.className = "role";
  		  td.appendChild( img );
  		  
  		  var mon = monsterList[i];
  		  var tdd = document.createElement( "td" );
  		  
  		  var attackCD = "可攻擊";
  		  if ( !mon.canAttack ) attackCD = "冷卻中"
  		  tdd.innerHTML = "attack: " + mon.attack + "<br>" + "health: " + mon.health + "<br>" + "攻擊狀態: " + attackCD;
  		  $( "#showRoleInfo" ).append( td );
  		  $( "#showRoleInfo" ).append( tdd );
  		  
  		  //showRoleCanMove( monsterList[i] );
  		  return true;
  	  } // if
  		  
  	  return false;
}
/*
function showRoleCanMove( mon ) {
	mon.
	if ( !checkPositionIsNull(rowColumn) ) return false;
	var newRolColumn = checkCanMove( choosedRole, rowColumn );
	if ( newRolColumn  == null ) return false;
	
}*/
</script>

</head>

<body>
    
    <div id = "pre" onclick = "" style = "text-align:center;text-valign:center;background:black;color:blue;cursor:pointer;"><h1></h1></div>
    <div id = "container" style = "display:none;"></div>
    
    <div id = "infoTable">
    <table style = "width:100%;">
      <tr>
      <td>
      <table>
        <tr>
          <td id = "monster1Role">
              <img class = "role" src = "<%=request.getContextPath()%>/obj/Succubus/monsterINTRO.jpg" onclick = "changeCurrentRole( monster1 )"/>
          </td>
          <td>
              <h2 id = "monster1CD"></h2>
          </td>
          <td id = "girlRole">
              <img class = "role" src = "<%=request.getContextPath()%>/obj/girl/girlINTRO.jpg" onclick = "changeCurrentRole( girl )"/>
          </td>
          <td>
              <h2 id = "girlCD"></h2>
          </td>
        </tr>
      </table>
      </td>
      <td style = "width:90%;">
      <table align= "center">
        <tr id = "showRoleInfo">
 
        </tr>
      </table>
      <!--
      <table align= "center" id = "movingMons" >
        <tr id = "time">
          <td><img src = "<%=request.getContextPath()%>/images/time/1.png" /></td>
          <td><img src = "<%=request.getContextPath()%>/images/time/0.png" /></td>
        </tr>
      </table>
      -->
      </td>
      <td id = "money"></td>
      </tr>
      
    </table>
    <!-- <input type = "button" value = "Start" id = "movingMons"></input> -->
    </div>
    
<script>
/* struct */

 function Role( position, obj, mov, health, attack, buyMoney ){
	 this.index = totalRole.length; 
	 this.obj = obj;
	 this.mov = mov;
	 this.health = health;
	 this.attack = attack;
	 this.column = position.z;
	 this.row = position.x;
	 this.height = position.y;
	 this.buyMoney = buyMoney;
	 this.getMoney = buyMoney  / 2;
	 this.getMoney
	 this.cd;
	 this.id;
	 this.group;
	 this.canAttack = true;
	 ///// example
	 

	 var privateVariable; // private member only available within the constructor fn
     
	 this.privilegedMethod = function () { // it can access private members
	    //..
	 };
 }

 //Role.staticMethod = function(){};
 Role.prototype.clone = function( group, rowColumn ){
		 var newRole = new Role( rowColumn, this.obj.clone(), this.mov, this.health, this.attack, this.buyMoney, this.getMoney );
		 newRole.index = this.index;
		 newRole.id = this.id;
		 newRole.cd = this.cd;
		 newRole.group = group;
		 return newRole;
};

 
 Role.prototype.setCD = function(cd){ this.cd = cd;};
</script>

<script>
/* html */
function show3D(){
	$("#container").css("display","block");
	$("#pre").css("display","none");
	startGame();
	setTimeout(function(){MYTURN = true;}, 1500);
	//MYTURN = true;
}

</script>
<script>
   var container;
   
   var scene, camera, renderer, controls, sky;
   var ground = null, ground_geometry, ground_material, ground_Num = 8, ground_Pix = 800;
   var theTree;
   var raycaster, intersects, threshold = 0.5, selectedBlock, canMoveBlock, blockList = [];
   var STARTMOVE = false, MYTURN = false;
   var monsterList = [], enemyList = [], currentRole = null, choosedRole = null, totalRole = [];
   var monster1, girl, skeleton, manmax;
   var coverList = [];
   var mouse = new THREE.Vector2();
   var createEffectList = [];
   var currentMoney = 6000;
   var FLOOR = -250;
   var texloader = new THREE.TextureLoader();
   var morphs = [];
   var clock = new THREE.Clock();
   var numOfReady = 0, totalReady = 13; // total: 13
   
   timeCounter( 5 );
   init();
   
   
   function init(){
   ////////////////////////////////////////////////////////////////////////
   //                           scene                                    //  
   //////////////////////////////////////////////////////////////////////// 	 
   
     container = document.getElementById( 'container' );
     scene = new THREE.Scene();
     scene.fog = new THREE.FogExp2( 0xffffff, 0.000305);//Fog(0xffffff, 100, 3000);
     ////////////////////////////////////////////////////////////////////////
     //                           render                                   //  dark-s_nx.jpg
     //////////////////////////////////////////////////////////////////////// 

     renderer = new THREE.WebGLRenderer( { antialias: true } );
     renderer.setPixelRatio( window.devicePixelRatio );
     renderer.setSize( window.innerWidth, window.innerHeight );
     container.appendChild( renderer.domElement );
     
     ////////////////////////////////////////////////////////////////////////
     //                           camera                                   //  
     ////////////////////////////////////////////////////////////////////////    
     
     camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 1, 10000 );
     //scene.add( camera );
     camera.position.set(0,430,690);//(73.25752921522309, 546.1230080306011, 534.9045144895354);
     var vec = new THREE.Vector3( scene.position );
     vec.y - 150;
     camera.lookAt( vec );
     
     controls = new THREE.OrbitControls( camera, renderer.domElement );
     controls.minDistance = 0;
     controls.maxDistance = 900;
     controls.minPolarAngle = 0; // radians
     controls.maxPolarAngle = Math.PI; // radians
     controls.maxPolarAngle = Math.PI/2; 
	
     //controls.enabled = false;
	 scene.add(camera);
     ////////////////////////////////////////////////////////////////////////
     //                           light                                    //  
     ////////////////////////////////////////////////////////////////////////
     
     light = new THREE.PointLight( 0xffffff, 1 );
     light.position.set( 200, 100, 200 );
     scene.add( light );
   
     light2 = new THREE.PointLight( 0xffffff, 1 );
     light2.position.set( 400, 100, 400 );
     scene.add( light2 );
	 
     var light = new THREE.PointLight( 0xffffff, 1 );
     light.position.set( 600, 100, 600 );
     scene.add( light );
   
     var light2 = new THREE.PointLight( 0xffffff, 1 );
     light2.position.set( 800, 100, 800 );
     scene.add( light2 );    
     
     var light1 = new THREE.DirectionalLight( 0xffffff, 1 );
		light1.position.set( 0, 100, 0 );
	 scene.add( light1 );
	 
	 
     ////////////////////////////////////////////////////////////////////////
     //                           skybox                                   //  
     ////////////////////////////////////////////////////////////////////////
     /*
     var texture = THREE.ImageUtils.loadTexture( "./images/sky.jpg" );
     texture.minFilter = THREE.NearestFilter;
     
	 var skygeometry = new THREE.SphereGeometry( 2300, 500, 500 );
     var material = new THREE.MeshBasicMaterial( { map:texture } );
     var skyboxMesh = new THREE.Mesh( skygeometry, material );
     
     skyboxMesh.material.side = THREE.BackSide;
     scene.add( skyboxMesh );
     */
     var imagePrefix = "./images/sky/dawnmountain-";
 	 var directions  = ["xpos", "xneg", "ypos", "yneg", "zpos", "zneg"];
 	 var imageSuffix = ".png";
 	 var skyGeometry = new THREE.BoxGeometry( 8000, 2500, 8000 );	
 	
 	 var materialArray = [];
 	 //for (var i = 0; i < 6; i++)
 		texloader.load(imagePrefix + directions[0] + imageSuffix, function(tex0) {
 			materialArray.push( new THREE.MeshBasicMaterial({
 				map: tex0,
 				side: THREE.BackSide
 			}));
 			
 			texloader.load(imagePrefix + directions[1] + imageSuffix, function(tex1) {
 	 			materialArray.push( new THREE.MeshBasicMaterial({
 	 				map: tex1,
 	 				side: THREE.BackSide
 	 		}));
 	 			texloader.load(imagePrefix + directions[2] + imageSuffix, function(tex2) {
 	 	 			materialArray.push( new THREE.MeshBasicMaterial({
 	 	 				map: tex2,
 	 	 				side: THREE.BackSide
 	 	 		}));
 	 	 			texloader.load(imagePrefix + directions[3] + imageSuffix, function(tex3) {
 	 	 	 			materialArray.push( new THREE.MeshBasicMaterial({
 	 	 	 				map: tex3,
 	 	 	 				side: THREE.BackSide
 	 	 	 		}));
 	 	 	 			texloader.load(imagePrefix + directions[4] + imageSuffix, function(tex4) {
 	 	 	 				materialArray.push( new THREE.MeshBasicMaterial({
 	 	 	 					map: tex4,
 	 	 	 					side: THREE.BackSide
 	 	 	 			}));
 	 	 	 				texloader.load(imagePrefix + directions[5] + imageSuffix, function(tex5) {
 	 	 	 	 				materialArray.push( new THREE.MeshBasicMaterial({
 	 	 	 	 					map: tex5,
 	 	 	 	 					side: THREE.BackSide
 	 	 	 	 			}));				
 	 	 	  	 				var skyMaterial = new THREE.MeshFaceMaterial( materialArray );
 	 	 	  	 		 		 var skyBox = new THREE.Mesh( skyGeometry, skyMaterial );
 	 	 	  	 		 		 skyBox.position.set( 0, 1245, 0 );
 	 	 	  	 		 		 scene.add( skyBox ); 	 
 	 	 	  	 		 		 numOfReady++;
 	 	 	  	 		 		 console.log( "skyBox" );
 	 	 	 				});	 	 			 	 			
 	 	 				}); 	 	 				 			
 	 	 			});
 	 			});		
 			});			
 		});
 		
 	 /*
 	 materialArray.push( new THREE.MeshBasicMaterial({
 				map: tex,
 				side: THREE.BackSide
 			}));
 	 */
 	 
     ////////////////////////////////////////////////////////////////////////
     //                           chessboard                               //  
     ////////////////////////////////////////////////////////////////////////

     texloader.load( "./images/Chess.png", function(texture) {
    	 texture.wrapS = texture.wrapT = THREE.RepeatWrapping;
         texture.repeat.set( 2, 2 ) ;
         
         
         ground_geometry = new THREE.PlaneBufferGeometry( ground_Pix, ground_Pix, ground_Num, ground_Num );
         ground_material = new THREE.MeshBasicMaterial( { map: texture, side: THREE.DoubleSide, transparent: true, opacity: 0.3 } );
         //ground_material.opacity = 0.5;
         ground = new THREE.Mesh( ground_geometry, ground_material );
         ground.position.y = -0.5;
         ground.rotation.x = Math.PI / 2;
         scene.add(ground);
         numOfReady++;
         console.log( "chess" );
     });

     
	 ////////////////////////////////////////////////////////////////////////
     //                           trees                                    //  
     ////////////////////////////////////////////////////////////////////////
     
     var loader = new THREE.OBJMTLLoader();
     
         loader.load( "./obj/tree/tree.obj", "./obj/tree/tree.mtl",
		   function( object ){
        	 
	          object.position.x = 0;
	          object.position.z = 0;
	          object.scale.set( 10,15,10 );
	          object.rotation.y = Math.PI;
	     	  theTree = object;
	     	  setEnvirment( scene, object );
	          //scene.add( object );
	     	 numOfReady++;
	     	console.log( "tree" );
	   
     });
     
     ////////////////////////////////////////////////////////////////////////
     //                           ground                                   //  
     ////////////////////////////////////////////////////////////////////////
     
     ////////////////////////////////////////////////////////////////////////
     //                           monster                                  //  
     ////////////////////////////////////////////////////////////////////////
     var loader = new THREE.OBJMTLLoader();
     
         loader.load( "./obj/Succubus/succubus.obj", "./obj/Succubus/succubus.mtl",
		   function( object ){
        	 
	          //object.position.x = 0;
	          //object.position.z = 0;
	          object.scale.set( 2,2,2 );
	          object.rotation.y = Math.PI;
	       // (                              position,           obj,              mov,                health, attack, buyMoney )
	          monster1 = new Role( new THREE.Vector3( 0, 0, 0 ), object, new THREE.Vector3( 100, 0, 100 ), 100, 100, 500 );
	          monster1.setCD( 7 );
	          monster1.id = "#monster1";
	          //monster1.money = 500;
	          totalRole.push( monster1 );
	          //currentRole = monster1;
	      	  //changeCurrentRole( currentRole );
	          //scene.add( object );
	          numOfReady++;
	          console.log( "monster" );
	   
     });
     
     var loader = new THREE.OBJMTLLoader();
         
         loader.load( "./obj/girl/girl.obj", "./obj/girl/girl.mtl",
		   function( object ){
        	 
	          //object.position.x = 0;
	          //object.position.z = 0;
	          object.scale.set( 100,100,100 );
	          object.rotation.y = Math.PI;
	          // (                       position,           obj,              mov,               health, attack, buyMoney )
	          girl = new Role( new THREE.Vector3( 0, 0, 0 ), object, new THREE.Vector3( 100, 0, 100 ), 500, 50, 1000);
	          girl.setCD( 12 );
	          girl.id = "#girl";
	          //girl.money = 1000;
	          totalRole.push( girl );
	          
	          //scene.add( object );
	          numOfReady++;
	          console.log( "girl" );
     });
         
     var loader = new THREE.OBJMTLLoader();
         
         loader.load( "./obj/skeleton/skeleton.obj", "./obj/skeleton/skeleton.mtl",
		   function( object ){
        	 
	          //object.position.x = 0;
	          //object.position.z = 0;
	          object.scale.set( 5.5, 5.5, 5.5 );
	          //object.rotation.y = Math.PI;
	          // (                       position,           obj,              mov,               health, attack, buyMoney)
	          skeleton = new Role( new THREE.Vector3( 0, 0, 0 ), object, new THREE.Vector3( 100, 0, 100 ), 500, 50, 1000 );
	          skeleton.setCD( 7 );
	          skeleton.id = "#skeleton";
	          //girl.money = 1000;
	          totalRole.push( skeleton );
	          
	          //scene.add( object );
	          numOfReady++;
	          console.log( "skeleton" );
     });
         
     var loader = new THREE.OBJMTLLoader();
         
         loader.load( "./obj/manmax/manmax.obj", "./obj/manmax/manmax.mtl",
		   function( object ){
        	 
	          //object.position.x = 0;
	          //object.position.z = 0;
	          
	          object.scale.set( 1.2, 1.2, 1.2 );
	          //object.rotation.y = Math.PI;
	          // (                       position,           obj,              mov,                     health, attack, money )
	          manmax = new Role( new THREE.Vector3( 0, 0, 0 ), object, new THREE.Vector3( 100, 0, 100 ), 999999, 50, 1000 );
	          manmax.setCD( 12 );
	          manmax.id = "#manmax";
	          //girl.money = 1000;
	          totalRole.push( manmax );
	          
	          //scene.add( object );
	          numOfReady++;
	          console.log( "manmax" );
     });
         
	var loader = new THREE.OBJMTLLoader();
         
         loader.load( "./obj/castle/castle.obj", "./obj/castle/castle.mtl",
		   function( object ){
        	 
	          object.position.x = 00;
	          object.position.z = -3000;
	          object.position.y = 200;
	          object.rotation.x = 0.2;
	          object.scale.set( 320, 320, 320 );	       
	          scene.add( object );
	          numOfReady++;
	          console.log( "castle" );
	          /*object.traverse( function ( child ) {

	        	    if ( child.geometry !== undefined ) {
	        	    	var mesh = Animation.getMorph( child.geometry, 0, 1, 0, 0, 0 );
	        	    	 scene.add( mesh );
	        	 		 morphs.push( mesh );
	        	        

	        	    }

	          } );*/
	   
     });
	var loader = new THREE.OBJMTLLoader();
         
         loader.load( "./obj/castle3/castle.obj", "./obj/castle3/castle.mtl",
		   function( object ){
        	 
	          object.position.x = 00;
	          object.position.z = 2900;
	          object.position.y = -130;
	          object.rotation.y = Math.PI;
	          object.scale.set( 40, 40, 40 );	       
	          scene.add( object );
	          numOfReady++;
	          console.log( "castle2" );
	          /*object.traverse( function ( child ) {

	        	    if ( child.geometry !== undefined ) {
	        	    	var mesh = Animation.getMorph( child.geometry, 0, 1, 0, 0, 0 );
	        	    	 scene.add( mesh );
	        	 		 morphs.push( mesh );
	        	        

	        	    }

	          } );*/
	   
     });
         
     var loaderl = new THREE.JSONLoader();
     loaderl.load( "./obj/morphs/flamingo.js", function( geometry ) {

    	 var mesh = new Animation( "bird" );
    	 mesh.getMorph( geometry, 500, 1, new THREE.Vector3(-1200 + Math.random() * 2000, 650, 40) );
    	 scene.add( mesh.obj );
 		 morphs.push( mesh );
 		numOfReady++;
 		
 		mesh = new Animation( "bird" );
   	 mesh.getMorph( geometry, 500, 1, new THREE.Vector3(-1200 + Math.random() * 2000, 650, 40) );
   	 scene.add( mesh.obj );
		 morphs.push( mesh );
 		console.log( "flamingo" );
		} );
     
     var loaderl = new THREE.JSONLoader();
     loaderl.load( "./obj/morphs/parrot.js", function( geometry ) {

    	 var mesh = new Animation( "bird" );
    	 mesh.getMorph( geometry, 450, 0.5, new THREE.Vector3(-1200 + Math.random() * 2000, 650, 700 ));
    	 scene.add( mesh.obj );
 		 morphs.push( mesh );
 		numOfReady++;
 		
 		mesh = new Animation( "bird" );
   	 mesh.getMorph( geometry, 450, 0.5, new THREE.Vector3(-1200 + Math.random() * 2000, 650, 700 ));
   	 scene.add( mesh.obj );
		 morphs.push( mesh );
 		console.log( "parrot" );
		} );
     
     var loaderl = new THREE.JSONLoader();
     loaderl.load( "./obj/morphs/stork.js", function( geometry ) {

    	 var mesh = new Animation( "bird" );
    	 mesh.getMorph( geometry, 350, 1, new THREE.Vector3(-1200 + Math.random() * 2000, 650, 340) );
    	 scene.add( mesh.obj );
 		 morphs.push( mesh );
 		numOfReady++;
 		
 		mesh = new Animation( "bird" );
   	 mesh.getMorph( geometry, 350, 1, new THREE.Vector3(-1200 + Math.random() * 2000, 650, 340) );
   	 scene.add( mesh.obj );
		 morphs.push( mesh );
		console.log( "stork" );
		} );
     
     var loaderl = new THREE.JSONLoader();
     loaderl.load( "./obj/morphs/horse.js", function( geometry ) {
		
    	 var mesh = new Animation( "horse" );
    	 mesh.getMorph( geometry, 1000, 1, new THREE.Vector3(100 - Math.random() * 1000, 0, 300), true );
    	 scene.add( mesh.obj );
 		 morphs.push( mesh );
 		 mesh = new Animation( "horse" );
 		 mesh.getMorph( geometry, 1000, 1, new THREE.Vector3(100 - Math.random() * 1000, 0, 300), true );
   	 	 scene.add( mesh.obj );
		 morphs.push( mesh );
		 mesh = new Animation( "horse" );
		 mesh.getMorph( geometry, 1000, 1, new THREE.Vector3(100 - Math.random() * 1000, 0, 300), true );
    	 scene.add( mesh.obj );
 		 morphs.push( mesh );
		 numOfReady++;
		 console.log( "horse" );
		} );
     // for ( var i = 0; i < 10; i++ ) createMonster();
     ////////////////////////////////////////////////////////////////////////
     //                           cube                                     //  
     //////////////////////////////////////////////////////////////////////// 

     cubeGeo = new THREE.BoxGeometry( 100, 1, 100 );
     cubeMaterial = new THREE.MeshBasicMaterial( {color:0x0000ff, transparent: true, opacity: 0.2 } );
     selectedBlock = new THREE.Mesh( cubeGeo, cubeMaterial );
     selectedBlock.position.set( 50, 0, 50 );
     scene.add( selectedBlock );
     
     var cGeo = new THREE.BoxGeometry( 100, 1, 100 );
     cMaterial = new THREE.MeshBasicMaterial( {color:0x00ff00, transparent: true, opacity: 0.2 } );
     canMoveBlock = new THREE.Mesh( cGeo, cMaterial );
     
     ////////////////////////////////////////////////////////////////////////
     //                           Effect                                   //  
     /*///////////////////////////////////////////////////////////////////////
     effect = new Effect( new THREE.Vector3( 8, 0, 8) );
     effect.create();
     
     scene.add( effect.particleSystem );
     
     /*///////////////////////////////////////////////////////////////////////
     //                           add listener                             //  
     //////////////////////////////////////////////////////////////////////// 	 

 	 
     window.addEventListener( 'resize', onWindowResize, false );
     $( "body" ).mousemove(function(e) {  onMouseMove(e); });
 	 $( "body" ).mousedown(function(e) {  onMouseDown(e); }); // e.button 0 -> left 1-> middle right -> 2
 	 $( "body" ).mouseup(function(e) {  onMouseUp(e); });
	 setMoneyImage( currentMoney );
	 
 	 //$( "#movingMons" ).click( function(){ if( STARTMOVE ) return false; setTimeImage( -1 ); startMoveMons(); });
 	 //timeCounter( 10 );
 	 //startGame();
     } // init()
     


	 /*function limitControl(){
		 console.log( "camera position: (" + camera.position.x + ", " +  camera.position.y + ", " + camera.position.z + ")" );
    	 if ( camera.position.y > 900 ) camera.position.y = 900;
    	 else if ( camera.position.y < 10 ) camera.position.y = 10;
    	 if ( camera.position.x > 600 ) camera.position.x = 600;
    	 else if ( camera.position.x < -600 ) camera.position.x = -600;
    	 if ( camera.position.z > 600 ) camera.position.z = 600;
    	 else if ( camera.position.z < -600 ) camera.position.z = -600;
     } // limitControl()*/
     
	 ////////////////////////////////////////////////////////////////////////
     //                                                                    //  
     //////////////////////////////////////////////////////////////////////// 
     
     function animate() {
    	 var delta = clock.getDelta();
        for ( var i = 0; i < createEffectList.length; i++ ) {
    	    if ( createEffectList[i] != null && !createEffectList[i].update() ) {
    	    	scene.remove( createEffectList[i].particleSystem );
    	    	createEffectList.splice( i, 1);
    	    } // if
    	     
        } // for
        
        for ( var i = 0; i < morphs.length; i ++ ) morphs[i].animate(delta);
        requestAnimationFrame( animate );
        renderer.clear();
        renderer.render( scene, camera );
        //limitControl();
        //controls.update();
        //console.log( "camera position: (" + camera.position.x + ", " +  camera.position.y + ", " + camera.position.z + ")" );
    }
     
    function startGame(){
    	var po = new THREE.Vector3();
    	po.y = 0, po.z = 350;
    	for ( var i = -350; i <= 350; i+=100 ) {
    	  po.x = i;
    	  if ( i === -50 || i === 50 )
    	    putObject( "A", girl, po);
    	  else putObject( "A", monster1, po );
    	} // for
    	
    	// initialize CD
    	for ( var i = 0; i < totalRole.length; i++ ){
    		var cd = totalRole[i].cd;
    		$( totalRole[i].id + "CD" ).html( cd );
    	} // for
    	
    	/////////// enemy
    	po.z = -350;
        for ( var i = -350; i <= 350; i+=100 ) {
    	  po.x = i;
    	  if ( i === -50 || i === 50 )
    	    putObject( "B", manmax, po);
    	  else putObject( "B", skeleton, po );
    	} // for
    	
        animate();
    } // startGame()
    
    ////////////////////////////////////////////////////////////////////////
    //                           Turn                                     //  
    //////////////////////////////////////////////////////////////////////// 
    
    function countRoleCD( role, num ){
    	//if ( !MYTURN ) return false;
    	//if ( $( "#cd1" ).html() == "0" ) $( "#cd1" ).html( "5" );
    	//if ( $( "#cd1" ).html() > "0" ) $( "#cd1" ).html( $( "#cd1" ).html() - 1 );
    	//if ( $( "#cd2" ).html() == "0" ) $( "#cd2" ).html( "10" );
    	//if ( $( "#cd2" ).html() > "0" ) $( "#cd2" ).html( $( "#cd2" ).html() - 1 );
    	if ( role !== null ) { // 單CD修改
    		var cd = parseInt( $( role.id + "CD" ).html() );
    	    console.log( "cd" );
 		    if ( cd > 0 || num < 0 ) $( role.id + "CD" ).html( cd - num );
    	}
    	else {
    	    for ( var i = 0; i < totalRole.length; i++ ){
    		    var cd = parseInt( $( totalRole[i].id + "CD" ).html() );
    		    if ( cd > 0 ) $( totalRole[i].id + "CD" ).html( cd - num );
    	    } // for
    	} // else
    }
    
    function countMoney( money ){
    	//var currentMoney = parseInt($( "#money" ).val());
    	console.log(currentMoney);
    	//$( "#money" ).val( (currentMoney + money) );
    	currentMoney += money;
    	setMoneyImage( currentMoney );
    	//$( "#money" ).html( (currentMoney + money) );
    }
    
    function endMyTurn(){
    	MYTURN = false; // 結束自己的回合
    	countRoleCD( null, 1 ); // 修改全部CD
        countMoney( 100 );
        for ( var i = 0; i < monsterList.length; i++ )
        	if ( monsterList[i].group == "A" ) monsterList[i].canAttack = true;
    } // endMyTurn
    ////////////////////////////////////////////////////////////////////////
    //                           Mouse                                    //  
    ////////////////////////////////////////////////////////////////////////     
    var MOUSEDOWN = false, CONTROL = false;
	 
     
 	function onWindowResize() {

 		camera.aspect = window.innerWidth / window.innerHeight;
 		camera.updateProjectionMatrix();

 		renderer.setSize( window.innerWidth, window.innerHeight );

 	} //  onWindowResize() 

	function onMouseMove( event ) {

		event.preventDefault();

		mouse.x = ( event.clientX / window.innerWidth ) * 2 - 1;
		mouse.y = - ( event.clientY / window.innerHeight ) * 2 + 1;
		
		if ( MOUSEDOWN ) {
			//console.log( "down" );
			onMouseDown(event);
		}
		
	     var vec = new THREE.Vector3(mouse.x, mouse.y, 0);//只有 x y 坐标有意义
	     var raycaster = new THREE.Raycaster();
	     raycaster.setFromCamera( mouse, camera );
	      
	     var intersects = raycaster.intersectObject(ground); //计算射线和 平面的所有交点 0 或者 1个
	     if(intersects.length > 0) {
	    	 var position = getCorrectPosition( intersects[0].point );
	    	 selectedBlock.position.set( position.x, 0, position.z );
	    	 
	     	 var rowColumn = convertPositionToRowCol( position );
	     	 if ( !showRoleMessage( rowColumn ) ) // 此格子上沒腳色
	     	     $( "#showRoleInfo" ).html( "" );
	     }
	     
	} // onMouseMove( event )
	
    
    function onMouseUp( event ){
       
        MOUSEDOWN = false;

    } // onMouseUp()
    
    /*function beenClick( obj ){
    	 var intersects = raycaster.intersectObject(obj); //计算射线和 平面的所有交点 0 或者 1个
    	 if(intersects.length > 0) return intersects[0].point;
    	 return null;
    }*/
    
    function onMouseDown( event ){
    	
      if ( STARTMOVE || !MYTURN ) return false;  
      
      var mode = "left";
      if ( event.button === 2 ) mode = "right"; // right press
      
      MOUSEDOWN = true;
      
      var vec = new THREE.Vector3(mouse.x, mouse.y, 0);//只有 x y 坐标有意义
      var raycaster = new THREE.Raycaster();
      raycaster.setFromCamera( mouse, camera );
      
      var intersects = raycaster.intersectObject(ground); //计算射线和 平面的所有交点 0 或者 1个
      if(intersects.length > 0) {
           //存在交点
          if ( mode == "left" ) {
        	  // console.log("click");
        	  beenClick( intersects[0].point );
        	  //putObject( intersects[0].point ); 
          } // if
      }
      
     /* for ( var i = 0; i < monsterList.length; i++ ) {
          var intersects = raycaster.intersectObject(monsterList[i]); //计算射线和 平面的所有交点 0 或者 1个
          if(intersects.length > 0) console.log( "click "+ i );
      } // for*/
    } // onMouseDown()

    function beenClick( point ){
    	
    	var position = getCorrectPosition( point );
    	var rowColumn = convertPositionToRowCol( position );
    	if ( !checkPositionIsNull(rowColumn) || choosedRole != null ) {
            var index;
    		if ( !checkPositionIsNull(rowColumn) && (index = chooseRole( rowColumn )) > 0 && choosedRole != null ) // 有怪物但不能選->代表是敵方怪物
    			attackEnemy( index - 1, rowColumn );
    		else moveChoosedRole( rowColumn );
    	} // if
    	else if ( currentRole != null && !isStillHasCD() && !moneyNotEnough( currentRole.money ) ) {
    		putObject( "A", currentRole, position );
    		countRoleCD( currentRole, currentRole.cd * (-1) ); // 恢復CD
    	} // else if
    	
    } // beenClick()
    
    ////////////////////////////////////////////////////////////////////////
    //                           Check                                    //  
    ////////////////////////////////////////////////////////////////////////
    
    function isStillHasCD(){
    	var cd = parseInt( $( currentRole.id + "CD" ).html() );
    	if ( cd > 0 ) return true;
    	return false;
    } // isStillHasCD()
    
    function moneyNotEnough( money ){
    	if ( currentMoney < money ) return true;
    	return false;
    } // moneyNotEnough()
    
    ////////////////////////////////////////////////////////////////////////
    //                           Position                                 //  
    //////////////////////////////////////////////////////////////////////// 
    
    function getCorrectPosition( point ){
    	var po = new THREE.Vector3();
    	po.y = 0;
    	for ( var i = -400; i <= 300; i+= 100 ) {
    	    if ( i <= point.x && point.x < i + 100 ) po.x = i + 50;
    	    if ( i <= point.z && point.z < i + 100 ) po.z = i + 50;
    	} // for
    	
    	return po;
    } // getCorrectPosition()
    
    function convertPositionToRowCol( po ){
    	var x = (po.x + 350) / 100 + 1;
    	var z = (po.z + 350) / 100 + 1;
    	return new THREE.Vector3( x, 0, z );
    } // convertPositionToRowCol()

    function moveChoosedRole( rowColumn ){
    	if ( !checkPositionIsNull(rowColumn) ) return false;
    	var newRolColumn = checkCanMove( choosedRole, rowColumn );
    	if ( newRolColumn  == null ) return false;
    	//console.log( newRolColumn.x + ", " + newRolColumn.y + ", " + newRolColumn.z);
    	if ( startMoveMons( choosedRole, newRolColumn ) ) {
    		console.log( "move choosed Rold");
    		choosedRole = null;
    	} // if
    	
    	return true;
    } //  moveChoosedRole()
    
    function checkPositionIsNull(rowColumn){
    	for ( var i = 0; i < monsterList.length; i++ )
    	  if ( monsterList[i].row === rowColumn.x && monsterList[i].column === rowColumn.z ) return false;
    	return true;
    } // checkPositionIsNull()
    
    function modifyRoleRowColumn( mon, rowColumn ){
    	/*mon.row -= (mon.mov.x/100);
    	mon.column -= mon.mov.z/100;
    	mon.height -= mon.mov.y/100;*/
    	console.log( "bef--->" + mon.row + ", " + mon.column + ", " + mon.height);
    	mon.row += rowColumn.x;
    	mon.column += rowColumn.z;
    	mon.height += rowColumn.y;
    	console.log( "aft--->" + mon.row + ", " + mon.column + ", " + mon.height);
    } // modifyRoleRowColumn()
    
    
    ////////////////////////////////////////////////////////////////////////
    //                           role                                     //  
    ////////////////////////////////////////////////////////////////////////
    
    function attackEnemy( index, rowColumn ){
    	var mon = monsterList[index];
    	if ( !choosedRole.canAttack ) return false;
        choosedRole.canAttack = false;
    	monsterList[index].health -= choosedRole.attack;
    	//console.log( choosedRole.attack + " attack " + monsterList[index].health );
    	if ( monsterList[index].health <= 0 ) {
    		scene.remove( monsterList[index].obj );
			monsterList.splice( index, 1);
			countMoney( monsterList[index].getMoney ); // 殺敵人得到錢
    	} // if
    	
    	return true;
    } // attackRole()
    
    function chooseRole( rowColumn ){
        //console.log( rowColumn.x + ", " + rowColumn.z );
    	for ( var i = 0; i < monsterList.length; i++ ){
    		//console.log( "--->" + monsterList[i].row + ", " + monsterList[i].column );
    		if ( monsterList[i].row == rowColumn.x && monsterList[i].column == rowColumn.z ) {
    			if ( monsterList[i].group == "B" ) return i+1; // +1防止index = 0 被選到
    			choosedRole = monsterList[i];
    			console.log("find it");
    			return 0;
    		} // if
    	} // for
    } // moveRole()
    

    
    function putObject( group, role, newMon_position ){
    	/*
    	var col = Math.round(point.x * (ground_Num / ground_Pix) );
        var row = Math.round(point.z * (ground_Num / ground_Pix) );
        var x = ((ground_Num / 2) + col), z = ((ground_Num / 2) + row);
    	console.log( point.x + ", " + point.z );
    	*/
    	// console.log( point.x + ", " + point.z );
    	
    	// var newMon = new THREE.Mesh( cubeGeo, cubeMaterial );
    	//if ( index_Mon1 == monster1.length ) index_Mon1 = 0;
    	//var newMon = monster1[index_Mon1++];	  	
    	
    	
    	var newMon;
    	/*
    	var cover = new THREE.Mesh( cubeGeo, cubeMaterial );
      	cover.position.set( newMon_position.x, 0, newMon_position.z );
      	coverList.push( cover );
      	scene.add( cover );
    	createMonster( newMon_position );
    	*/
    	var rowColumn = convertPositionToRowCol( newMon_position );
    	if ( !checkPositionIsNull(rowColumn) ) return false; // 此格已有怪物
    	
    	//console.log( rowColumn.x + ", " + rowColumn.y + ", " + rowColumn.z );
    	newMon = role.clone( group, rowColumn );
    	newMon.obj.position.copy( newMon_position );
        //newMon.group = "A";
        scene.add( newMon.obj ); 
        monsterList.push( newMon ); 
        if ( newMon.group == "A" ) {
    	    	   	  
    	    //var rowColumn = new THREE.Vector3( 0, 0, 1 ); 
    	    //console.log( "bef--->" + newMon.row + ", " + newMon.column );
    	    //startMoveMons( newMon, rowColumn );
    	    
    	    countMoney( newMon.buyMoney * (-1) ); // 花費
        } // if
        else {
        	
        	//enemyList.push( newMon );
        } // else
        	
        	
        // show Effect
        var effect = new Effect( rowColumn );
        effect.create();
        scene.add( effect.particleSystem );
        createEffectList.push( effect );
    	return true;
    } // putObject()
    
    ////////////////////////////////////////////////////////////////////////
    //                           Move                                     //  
    ////////////////////////////////////////////////////////////////////////
    
    function slowMoving( obj, dis, distance, time ){
    	
		var mov = false;
    	var t;
    	var k = time /100;
    	t = setTimeout( function(){
    	    choosedRole = null; // 防止
    	   
    	    //console.log( distance );
    	    
            obj.translateZ( distance.z / k );
            obj.translateX( distance.x / k );
            obj.translateY( distance.y / k );
            
            //console.log("slowMoving");
            //obj.position.set( obj.position.x + distance.x / k, obj.position.y + distance.y / k, obj.position.z + distance.z / k );
            //console.log( "100 / time: " + 100 / time + " time/100 = " + time/100 );
	        if ( ((distance.x >= 0 && dis.x < distance.x) || (distance.x < 0 && dis.x > distance.x)) ) dis.x += distance.x / k;
	        if ( ((distance.y >= 0 && dis.y < distance.y) || (distance.y < 0 && dis.y > distance.y)) ) dis.y += distance.y / k;
	        if ( ((distance.z >= 0 && dis.z < distance.z) || (distance.z < 0 && dis.z > distance.z)) ) dis.z += distance.z / k;
	        
	        if ( ((distance.z >= 0 && dis.z >= distance.z) || (distance.z < 0 && dis.z <= distance.z)) &&
	        	 ((distance.x >= 0 && dis.x >= distance.x) || (distance.x < 0 && dis.x <= distance.x)) &&	
	        	 ((distance.y >= 0 && dis.y >= distance.y) || (distance.y < 0 && dis.y <= distance.y)) ) {
	    	    clearTimeout( t );
	    	    MYTURN = true; // 輪到自己的回合
	    	    return true;
	        } // if
	    	
	        slowMoving( obj, dis, distance, time )
    	}, time / k );
    
        return true;
    } // slowMoving()
    

    
    function checkCanMove( mon, rowColumn ){
    	var off = new THREE.Vector3();
    	off.x = rowColumn.x - mon.row;
    	off.y = rowColumn.y - mon.height;
    	off.z = rowColumn.z - mon.column;
    	var ignoreNegtive = new THREE.Vector3( off.x*100, off.y*100, off.z*100 );
    	if ( ignoreNegtive.x < 0 ) ignoreNegtive.x *= -1;
    	if ( ignoreNegtive.y < 0 ) ignoreNegtive.y *= -1;
    	if ( ignoreNegtive.z < 0 ) ignoreNegtive.z *= -1;
    	console.log( ignoreNegtive.x + ", " + ignoreNegtive.y + ", " + ignoreNegtive.z );
    	if ( ignoreNegtive.x > mon.mov.x || ignoreNegtive.z > mon.mov.z || ignoreNegtive.y > mon.mov.y ) return null;
    	return off;
    } // checkCanMove()
   

    
    function startMoveMons( Mon, rowColumn ){
    	endMyTurn();
    	modifyRoleRowColumn( Mon, rowColumn );
		slowMoving( Mon.obj, new THREE.Vector3(0,0,0), new THREE.Vector3( rowColumn.x * (-100), rowColumn.y * (-100), rowColumn.z * (-100) ), 2000 );
		return true;
    } // startMovieMons()
    
    function cancelStartMove(){    	
    	STARTMOVE = false; // 當最後一個移動結束才能再放棋子
    	resetTimer( 10 ); // 開始回合計時
    } // cancelStartMove()
 
   
//////////////////////////////////////////// not use //////////////////////////////////////////////////////////
    /*
    function createMonster( newMon_position ){
    	
    	var loader = new THREE.OBJMTLLoader();
        
        loader.load( "./obj/Succubus/succubus.obj", "./obj/Succubus/succubus.mtl",
		   function( object ){
        
        	    	object.scale.set( 2,2,2 );
      	            monster1.push( object );
      	            object.position.copy( newMon_position );
      	            monsterList.push( object );
      	            scene.add( object );
      	      	
      
        });
        
    } // function createMonster()
    */
  </script>

</body>
</html>