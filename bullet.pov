#include "include/colors.inc"
#include "include/shapes.inc"
#include "include/textures.inc"

// カメラの定義
camera {
   location <0.8, 0.95, -0.4>
   look_at  <0, 0.6, 2>
}

// 光源の定義
light_source { <0.8, 6, 1.2> color White }
light_source { <0.6, 0.3, -0.8> color White spotlight }

// 天球を設定
sky_sphere {
    pigment {
        wrinkles
        color_map {
            [0.3 color rgb <0.1, 0.05, 0>]
            [2.5 White]
        }
        scale <1, 0.2, 0.2>
    }
}

          fog{

            color White

            distance 0.2

          }

// 反射用に床を定義
object{
    Plane_XZ
    pigment{color rgbt<0.7, 0.7, 0.7, 0.7>}
    translate<0,-10,0>
    texture{Phong_Dull}
    finish{reflection 0.3}
}

// 背景の設定 (background.jpeg) を貼り付ける
object{
    Plane_XY
    texture {
        pigment {
            image_map {
                jpeg "background.jpeg"
                once
            }
        }
    }
    translate<-0.7, -0.5,0.50>
    scale 8
}

// 2つの球の積をつくる
#declare InterSection_Sphere =
    intersection {
        sphere{ <0,0,0>, 1 translate<0.5, 0, 0> }
        sphere{ <0,0,0>, 1 translate<-0.5, 0, 0> }
    }

// ラグビーボール状のオブジェクト
#declare Rugby_Ball =
    intersection {
	    object {
            InterSection_Sphere
	    }
	    object {
            InterSection_Sphere
	        rotate 90*y
	    }
    }

// Rugby_Ballを半分にした形 (銃弾の先のベース部分だが角ばっている)
#declare Head_Base =
    difference {
        object { Rugby_Ball }
        box {
            <0,0,0>, <1,1,1>
            translate<-0.5, -1, -0.5>
        }
        scale 2*y
    }

// 超楕円体を用いた角丸の円柱
#declare Superellipsoid =
    superellipsoid{
        <1,0.1>
        rotate 90*y
        rotate 90*z
    }

// リング
#declare Ring =
    difference {
	    cylinder{
            <0,0,0> ,<0,0.1,0>,2
        }
        cylinder{
	        <0,-1,0> ,<0,2,0>,0.8
        }
    }

// 銃弾の先端 (Head_Baseの回転体)
#declare Head =
    union{
        #declare N=0;
        #while(N<90)
        object {Head_Base rotate N*y}
        #declare N=N+0.05;
        #end
    }

// 銃弾の本体部分
#macro Body(Color)
    difference {
        object{
            Superellipsoid scale 2*y
            texture {
                pigment {
                    color Color
                }
                finish{
                    metallic
                    reflection 0.5
                    roughness 0.0
                    phong 0.8
                    specular 0.8
                    brilliance 1.5
                    diffuse 0.3
                    crand 0.2
                }
            }
            interior{ ior 1.51 caustics 0.7}
        }

        object {
            Ring translate<0,-1.2,0>
        }

        object {
            Ring translate<0,1.7,0>
            scale <1.2, 0, 1.2>
        }

        rotate -90*z
        scale 0.05
        translate<0.6, 0.9, 0>
    }
#end

// 銃弾本体
#macro Bullet(Color)
    union {
        object{
            Body(Color)
        }
        object{
            Head
            scale <1.68, 1.5, 1.68>
            translate<0, 1.8, 0>
            rotate -90*z
            scale 0.05
            translate<0.6, 0.9, 0>
        }
    }
    texture {
        pigment { color Color }
        finish{
            metallic
            reflection 0.4
            roughness 0.0
            phong 0.8
            specular 0.8
        }
    }
#end

#macro Moving_Body(dx, dy, dz, Scale, num, R, G, B)
    union {
        #for (N, 0, num)
        object {
            Body(rgbt <R, G, B, N/num>)
            translate <(-N*N/3500)+dx, N*N/25000+dy , N*N/50000+dz>
            scale Scale
        }
        #end
    }
#end

union {
    object {
        Bullet(rgb <0.65, 0.50, 0.25>)
        translate<0.33, 0.5, 0.6>
        scale 0.8
    }
    object {Moving_Body(0.3, 0.5, 0.6, 0.8, 10, 0.65, 0.50, 0.25)}
}
object {Bullet(rgbt <0.65, 0.50, 0.25, 0.1>)}