	

#include "colors.inc"
#include "shapes.inc"

#include "woods.inc"
#include "metals.inc"
#include "stones.inc"
#include "textures.inc"



//      sky_sphere{
//
//            pigment{
//
//              wrinkles
//			color Black
//              color_map{
//            //[ 0.5 color rgb<0.18, 0.11, 0.05>]
//		 //[ 0.3 color rgb<0.3,0.4,1.2>]
//		 [0.3 color rgb<1, 0.5, 0.3>]
//                [ 1.2 White ]
//
//              }
//
//              scale <1, 0.2, 0.2>
//
//            }
//
//          }


          sky_sphere{

            pigment{

              wrinkles

              color_map{

//                [ 0.3 color rgb<0.3,0.4,1.2>]
//                [0.3 color rgb <0.72, 0.45, 0.20>]
			[0.3 color rgb <0.1, 0.05, 0>]

                [ 2.5 White ]

              }

              scale <1, 0.2, 0.2>

            }

          }

camera {
   location <0.8, 0.95, -0.4>
   look_at  <0, 0.6, 2>
 }
//camera {
//   location <0.7, 1.2, -0.8>
//   look_at  <0, 0.6, 2>
// }

//#declare LN=-1;
//#while (LN<=1)
//light_source {<LN, 4, -1> color 0.5*White
//
//    photons {
//    	
//      reflection on
//      refraction on	
//    }  
//
//}
//#declare LN=LN+1;
//#end

          fog{

            color White

            distance 0.2

          }

light_source {<0.8, 6, 1.2> color White }
light_source {<0.6, 0.3, -0.8> color White spotlight
looks_like{
              sphere {<0,0,0>,0.2 
                      texture {finish {ambient 1} pigment{rgb 1}}
              } 
            }}

//light_source {<2, 0.5, -0.8> color 0.6*White}

object{ 
  Plane_XZ
//  pigment {checker color rgb<0.9,0.3,0.3>*0.8, color rgb<0.2,0.9,0.3>*1.3}
    pigment{color rgbt<0.7, 0.7, 0.7, 0.7>}     
    translate<0,-10,0>
    texture{Phong_Dull}
    finish{reflection 0.3}
}



 
object{ 
  Plane_XY
   	
texture {
  pigment { 
    image_map {
      jpeg "bure.jpeg" 
      once
    }
  }
}  
    translate<-0.7, -0.5,0.50>
    scale 8
}
//object{ 
//  Plane_YZ
//   	
//texture {
//  pigment { 
//    image_map {
//      jpeg "bure.jpeg" 
//      once
//    }
//  }
//}  
//   translate <-1.5,0,0>
//    scale 8
//}


#declare HS = intersection {
  sphere{<0,0,0>, 1 translate<0.5, 0, 0>}	
  sphere{<0,0,0>, 1 translate<-0.5, 0, 0>}
}

#declare R = intersection {
	object {
	  HS	
	}
	object {
	  HS
	  rotate 90*y
	}
}

#declare H = difference {
  object { R }
  box {
    <0,0,0>, <1,1,1>
    translate<-0.5, -1, -0.5>	
  }
  scale 2*y
}

#declare S = superellipsoid{
      <1,0.1>
      rotate 90*y
      rotate 90*z   
    }
    

#declare R = difference {
	cylinder{
        <0,0,0> ,<0,0.1,0>,2
       }
      
      cylinder{
	  <0,-1,0> ,<0,2,0>,0.8
      }    
  }
  

#declare SS = 
union{
#declare N=0;
#while(N<90)
superellipsoid{
      <1,0.1>
      rotate 90*y
      rotate 90*z   
      rotate N*y
    }
#declare N=N+0.1;
#end
}

#declare HH = 
union{
#declare N=0;
#while(N<90)
object {H rotate N*y}

#declare N=N+0.05;
#end
}

#declare Bullet = difference {
union {
  object{S scale 2*y 
       texture { 
//    	 pigment{ rgb <0.72, 0.45, 0.20>}
     pigment {
     	  color rgb <0.65, 0.50, 0.25>}
        finish{
    	     metallic 
    	 
    	     reflection 0.5
    	 
    	      roughness 0.0
    	 
    	       phong 0.8
    	 
    	       specular 0.8
    
//       	 ambient 0.35
            brilliance 1.5
          diffuse 0.3
          crand 0.2
     }
   }
    interior{ ior 1.51 caustics 0.7}
  }
  object{HH scale <1.68, 1.5, 1.68> translate<0, 1.8, 0>
      }}

 object {
 	R translate<0,-1.2,0>
 }

    object {
 	R translate<0,1.7,0>
 	scale <1.2, 0, 1.2>

    }

  
  rotate -90*z
  scale 0.05
  translate<0.6, 0.9, 0>
}

#declare WI = difference{
  object{S scale 2*y 
//       texture { 
////    	 pigment{ rgb <0.72, 0.45, 0.20>}
//     pigment {
//     	  color rgb <0.65, 0.50, 0.25>}
//        finish{
//    	     metallic 
//    	 
//    	     reflection 0.5
//    	 
//    	      roughness 0.0
//    	 
//    	       phong 0.8
//    	 
//    	       specular 0.8
//    
////       	 ambient 0.35
//            brilliance 1.5
//          diffuse 0.3
//          crand 0.2
//     }
//   }
    interior{ ior 1.51 caustics 0.7}
  }

 object {
 	R translate<0,-1.2,0>
 }

    object {
 	R translate<0,1.7,0>
 	scale <1.2, 0, 1.2>

    }

  
  rotate -90*z
  scale 0.05
  translate<0.6, 0.9, 0>
}



#declare Num = 10;
#for (N, 0, Num)
object {WI translate <(-N*N/5000)+0.30, N*N/50000+0.5 , N*N/50000+0.6>  scale 0.8
       texture { 
     pigment {
     	  color rgbt <0.65, 0.50, 0.25, N/Num>}
        finish{
    	     metallic 
    	 
    	     reflection 0.5
    	 
    	      roughness 0.0
    	 
    	       phong 0.8
    	 
    	       specular 0.8
    
//       	 ambient 0.35
            brilliance 1.5
          diffuse 0.3
          crand 0.2
     }
   }
}
#end

object {Bullet translate<0.36, 0.5, 0.6>  scale 0.8 texture { 
//    	 pigment{ rgb <0.72, 0.45, 0.20>}
     pigment {color rgb <0.65, 0.50, 0.25>}
    finish{
    	 metallic 
    	 
    	 reflection 0.4
    	 
    	 roughness 0.0
    	 
    	 phong 0.8
    	 
    	 specular 0.8

    }
    }
  
}

#declare Num = 10;
#for (N, 0, Num)
object {WI translate <(-N*N/5000)-0.4, N*N/50000+0.1 , N*N/50000+0.3> 
       texture { 
     pigment {
     	  color rgbt <0.65, 0.50, 0.25, N/Num>}
        finish{
    	     metallic 
    	 
    	     reflection 0.5
    	 
    	      roughness 0.0
    	 
    	       phong 0.8
    	 
    	       specular 0.8
    
//       	 ambient 0.35
            brilliance 1.5
          diffuse 0.3
          crand 0.2
     }
   }
}
#end

object {Bullet translate<-0.4, 0.1, 0.3>  texture { 
//    	 pigment{ rgb <0.72, 0.45, 0.20>}
     pigment {color rgb <0.65, 0.50, 0.25>}
    finish{
    	 metallic 
    	 
    	 reflection 0.4
    	 
    	 roughness 0.0
    	 
    	 phong 0.8
    	 
    	 specular 0.8

    }
    }
  
}

object {Bullet translate<0, 0, 0>  texture { 
//    	 pigment{ rgb <0.72, 0.45, 0.20>}
     pigment {color rgbt <0.65, 0.50, 0.25,0.5>}
    finish{
    	 metallic 
    	 
    	 reflection 0.4
    	 
    	 roughness 0.0
    	 
    	 phong 0.8
    	 
    	 specular 0.8

    }
    }
  
}

//#declare Num = 10;
//#for (N, 0, Num)
//object {Bullet translate <(-N*N/5000), N*N/10000, N*N/50000> 
//pigment{ rgbt<0.65, 0.50, 0.25, N*N/800>} finish{reflection 0.3} }
//#end


// ========axis=========================

#macro arrow()
  union {
    object{ 
      cylinder{<0,0,0>,<4,0,0>,0.2}
    }
    
    object {
    	cone{<4,0,0> 1,<6, 0,0> 0}
    }
  }
#end

#macro triarrows(dx, dy, dz) 
  union {
    sphere{
      <0,0, 0>, 0.5
      pigment{color White}
    }
  	object {
  	  arrow()
  	  pigment {color Red}
  	}
  	object {
  	  arrow()
  	  pigment {color Green}
  	  rotate 90*z
  	}
  	object {
  	  arrow()
  	  pigment {color Blue}
  	  rotate -90*y
  	}
  	
  	translate<dx, dy, dz>
  }
#end
 

/* object{ //x-axis
   cylinder{<-100,0,0>,<100,0,0>,0.05}
   pigment{color White}
}

object{ //y-axis
   cylinder{<0,-100,0>,<0,100,0>,0.05}
   pigment{color White}
}

object{ //z-axis
   cylinder{<0,0,-100>,<0,0,100>,0.05}
   pigment{color White}
}  */

//triarrows(0,0,0)
// ==========================================