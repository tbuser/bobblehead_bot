/*
  BOB The Bobblehead Bot
  by Tony Buser <tbuser@gmail.com>
  http://creativecommons.org/licenses/by-nc-sa/3.0/
  
  20 models
  40 total parts
  
  BOM:
  
  1 base
  1 feet
  2 leg
  6 pintack_large
  2 pintack_small
  7 pinpeg_large
  2 pinpeg_small
  1 body
  1 dial
  1 logo
  2 arm_upper
  2 arm_lower
  2 hand
  1 head
  2 eye
  1 mouth
  1 antenna_top
  2 antenna_side_bottom
  2 antenna_side_top
  1 key
  
  not to be printed:
  
  assembly - just to show you how the parts go together
  head_cavity_negative - you just need it if you want to cut the shape in the bottom of a model to make your own bobblehead
*/


include <../pin_connectors/pins.scad> // Pin Connectors V2 http://www.thingiverse.com/thing:10541
include <../bitmap/bitmap.scad> // Bitmap Fonts http://www.thingiverse.com/thing:2054

// change these if needed
spring_inner_diameter = 9; // possible spring to use http://www.mcmaster.com/#9657k36/=dg66jt
tolerance = 0.3;
part = "assembly";

// don't change these
// $fn = 20;
spring_inner_radius = spring_inner_diameter/2;

white = [255/255, 250/255, 240/255];
black = [100/255, 100/255, 100/255];
red = [200/255, 0/255, 0/255];
yellow = [255/255, 255/255, 102/255];
orange = [255/255, 140/255, 0/255];

// stupid openscad recursion limitations...
// TODO: plates
if (part == "plate1") {
  print_plate("1");
} else if (part == "plate2") {
  print_plate("2");
} else {
  print_part(part);
}

module print_part(part) {
  echo(str("Printing part: ", part));
  
  if (part == "assembly") {
    assembly();
  } else if (part == "base") {
    base();
  } else if (part == "feet") {
    feet();
  } else if (part == "leg") {
    leg();
  } else if (part == "pintack_small") {
    pintack_small();
  } else if (part == "pintack_large") {
    pintack_large();
  } else if (part == "pinpeg_small") {
    pinpeg_small();
  } else if (part == "pinpeg_large") {
    pinpeg_large();
  } else if (part == "body") {
    body();
  } else if (part == "dial") {
    dial();
  } else if (part == "logo") {
    logo();
  } else if (part == "arm_upper") {
    arm_upper();
  } else if (part == "arm_lower") {
    arm_lower();
  } else if (part == "hand") {
    hand();
  } else if (part == "head") {
    head();
  } else if (part == "eye") {
    eye();
  } else if (part == "mouth") {
    mouth();
  } else if (part == "antenna_top") {
    antenna_top();
  } else if (part == "antenna_side_top") {
    antenna_side_top();
  } else if (part == "antenna_side_bottom") {
    antenna_side_bottom();
  } else if (part == "key") {
    key();
  } else if (part == "head_cavity_negative") {
    head_cavity_negative();
  } else {
    echo(str("I'm sorry Dave, I'm afraid I can't print: ", part));
  }
}

// damnit, have to render a lot of it or else openscad's opencsg rendering fails :(
module assembly() {
  union() {
    render() color(white) base();

    color(red) translate([0, 0, 15]) feet();

    render() color(yellow) translate([-10, 0, 35]) rotate([0, 0, -15]) leg();
    render() color(yellow) translate([10, 0, 35]) rotate([0, 0, 180+15]) leg();
    render() color(red) translate([-10, 0, 35+15]) rotate([0, 0, -15]) translate([-6, 0, 0]) rotate([0, 90, 0]) translate([0, 0, -3-1]) pintack_large();
    render() color(red) translate([10, 0, 35+15]) rotate([0, 0, 15]) translate([-6, 0, 0]) rotate([0, -90, 0]) translate([0, 0, -3-12-1]) pintack_large();

    render() color(yellow) translate([0, 0, 65]) body();    
    translate([0, -2.5-18.5, 65+50-17]) rotate([90, 0, 180]) logo();
    render() color(yellow) translate([0, -19, 65+9]) rotate([-90, 0, 0]) dial();
    render() color(red) translate([-2.5, 5+11+1, 65+25-2]) rotate([0, 45, 0]) key();
    
    render() translate([-6-20-6-2, 0, 115-10]) rotate([90, 0, 0]) rotate([0, 90, 0]) arm_assembly("bent");
    mirror() translate([-6-20-6-2, 0, 115-10]) rotate([90, 0, 0]) rotate([0, 90, 0]) arm_assembly("straight");
    
    translate([0, 0, 115+5]) head_assembly();
  }
}

module arm_assembly(position) {
  if (position == "bent") {
    union() {
      color(yellow) translate([0, -25/2, 12]) rotate([0, 180, 0]) arm_upper();
      color(yellow) translate([-25/2, -25/2-25+12, 0]) rotate([0, 0, -90]) arm_lower();

      color(red) translate([0, 0, -3]) pintack_small();
      color(red) translate([0, -25, -3]) pintack_large();
      color(red) translate([-25, -25, -3]) pintack_large();

      color(yellow) translate([-17/2-25, -25, 12]) rotate([0, 0, -90]) rotate([0, 180, 0]) hand();
    }    
  } else if (position == "straight") {
    union() {
      color(yellow) translate([0, -25/2, 12]) rotate([0, 180, 0]) arm_upper();
      color(yellow) translate([0, -25/2-25, 0]) arm_lower();

      color(red) translate([0, 0, -3]) pintack_small();
      color(red) translate([0, -25, -3]) pintack_large();
      color(red) translate([0, -50, -3]) pintack_large();

      color(yellow) translate([0, -17/2-50, 12]) rotate([0, 180, 0]) hand();
    }
  } else {
    echo("I'm sorry Dave, I'm afraid I can't do that.");
  }
}

module head_assembly() {
  union() {
    color(yellow) head();
    color(yellow) translate([-30+19, -30-3, 50-15]) rotate([-90, 0, 0]) eye();
    color(yellow) translate([30-19, -30-3, 50-15]) rotate([-90, 0, 0]) eye();
    color(yellow) translate([0, -30-3, 13]) rotate([-90, 0, 0]) mouth();
    color(red) translate([33+15/2-8, 2.5, 25]) rotate([90, 90, 0]) antenna_side_assembly("bent");
    mirror() color(red) translate([33+15/2-8, 2.5, 25]) rotate([90, 90, 0]) antenna_side_assembly("bent");
    color(red) translate([0, 0, 52]) antenna_top();
  }
}

module antenna_side_assembly(position) {
  union() {
    antenna_side_bottom();
    if (position == "straight") {
      translate([0, 15+10, 10]) rotate([0, 180, 0]) antenna_side_top();
    } else if (position == "bent") {
      translate([-15, 10, 10]) rotate([0, 180, 0]) rotate([0, 0, -90]) antenna_side_top();
    } else {
      echo("I'm sorry Dave, I'm afraid I can't do that.");
    }
  }
}

// use to cut out a cavity in the bottom of the head with cutaway sections to attach a spring inside to a small nub with some glue
module head_cavity_negative() {
  difference() {
    // main cavity
    union() {
      cylinder(h=35/2, r=spring_inner_radius*4);
      translate([0, 0, 35/2]) cylinder(h=35/2, r1=spring_inner_radius*4, r2=spring_inner_radius*2);
    }
    // cutaway/support sections that you remove
    cylinder(h=35, r=2);
    cylinder(h=10, r1=3, r2=2);
    translate([0, 0, 1]) cube([2, spring_inner_radius*4*2, 2], center=true);
    rotate([0, 0, 90]) translate([0, 0, 1]) cube([2, spring_inner_radius*4*2, 2], center=true);
    // spring mount shaft nub that remains inside after you cut away the supports
    // translate([0, 0, 15]) cylinder(h=15, r1=1.5, r2=spring_inner_radius);
    // translate([0, 0, 30]) cylinder(h=5, r=spring_inner_radius);
    translate([0, 0, 15]) cylinder(h=10, r1=2, r2=spring_inner_radius);
    translate([0, 0, 25]) cylinder(h=10, r=spring_inner_radius);
    // %translate([0, 0, 35]) rotate([0, 180, 0]) spring_mount();
  }
}

module key() {
  difference() {
    union() {
      translate([0, -3, 0]) pin(h=6, side=true);
      translate([0, 15, 3.5]) cube([7, 30, 7], center=true);
      translate([-10, 30, 0]) cylinder(h=7, r=7*2);
      translate([10, 30, 0]) cylinder(h=7, r=7*2);
    }
    
    translate([-10, 30, -1]) cylinder(h=9, r=7*0.75);
    translate([10, 30, -1]) cylinder(h=9, r=7*0.75);
  }
}

module antenna_top() {
  // Fezzes are cool.
  difference() {
    cylinder(h=15, r1=12, r2=10);
    pinhole(h=10, t=tolerance);
  }
}

module antenna_side_top() {
  difference() {
    union() {
      translate([0, 0, 2.5]) cube([5, 25, 5], center=true);
      translate([0, 25/2, 0]) cylinder(h=5, r=7/2*2);
      translate([0, -15, 0]) cylinder(h=5, r=7/2*2);

      translate([0, -15, 5]) pin(h=6);
    }
    
    translate([0, 25/2, 0]) pinhole(h=6, t=tolerance);
  }
}

module antenna_side_bottom() {
  difference() {
    union() {
      translate([0, -3, 0]) pin(h=6, side=true);
      translate([0, 5-0.1, 3.5]) cube([7, 10, 7], center=true);
      translate([0, 10, 0]) cylinder(h=7, r=7/2*2);
    }
    
    translate([0, 10, 0]) pinhole(h=6, t=tolerance);
  }
}

module mouth() {
  difference() {
    union() {
      translate([0, 0, 1.5]) cube([25, 10, 3], center=true);
      translate([-25/2, 0, 0]) cylinder(h=3, r=5);
      translate([25/2, 0, 0]) cylinder(h=3, r=5);
      translate([0, 0, 3]) pin(h=6);
    }
    
    color(black) {
      // translate([0, 1.5-1.5, -1+1.5]) cube([15, 2, 2], center=true);

      // line
      // translate([0, 1.5, -1+1.5]) cube([25, 2, 2], center=true);
      // translate([-25/2, 0, 0]) cylinder(h=1.5, r=1);
      // translate([25/2, 0, 0]) cylinder(h=1.5, r=1);

      // __o__
      translate([0, 0, -2+1.5]) cylinder(h=2, r=4);
    
      // o___o
      // translate([-25/2, 0, -2+1.5]) cylinder(h=2, r=3);
      // translate([25/2, 0, -2+1.5]) cylinder(h=2, r=3);
    }
  }
}

module eye() {
  difference() {
    union() {
      cylinder(h=3, r=10);
      translate([0, 0, 3]) pin(h=6);
    }

    color(black) {
      // outline
      difference() {
        translate([0, 0, -1]) cylinder(h=1.5+1, r=10-2);
        translate([0, 0, -1]) cylinder(h=1.5+1, r=10-3);
      }

      // iris
      difference() {
        translate([0, 0, -1]) cylinder(h=1.5+1, r=3);
        // translate([0, -5, 0]) cube([6, 6, 4], center=true);
        translate([0, 4, 0]) cube([6, 6, 4], center=true);
      }
    }
  }
}

module head() {
  difference() {
    difference() {
      union() {
        intersection() {
          translate([0, 0, 25]) cube([60, 60, 50], center=true);
          // corner bevels
          rotate([0, 0, 45]) translate([0, 0, 30]) cube([70, 70, 60], center=true);
        }
        
        // ear bumps
        translate([0, 0, 25]) rotate([0, 90, 0]) translate([0, 0, -32]) cylinder(h=64, r=7.5*2);
        // top bump
        cylinder(h=52, r=7.5*2);
      }

      // top hole
      translate([0, 0, 52]) rotate([0, 180, 0]) pinhole(h=10, t=tolerance);
    
      // ear holes
      translate([32, 0, 25]) rotate([0, -90, 0]) pinhole(h=6, t=tolerance);
      translate([-32, 0, 25]) rotate([0, 90, 0]) pinhole(h=6, t=tolerance);
      
      // eye holes
      translate([-30+19, -30, 50-15]) rotate([-90, 0, 0]) pinhole(h=6, t=tolerance);
      translate([30-19, -30, 50-15]) rotate([-90, 0, 0]) pinhole(h=6, t=tolerance);
          
      // mouth hole
      translate([0, -30, 13]) rotate([-90, 0, 0]) pinhole(h=6, t=tolerance);
    }
    
    // spring mount
    render() head_cavity_negative();
  }
}

module hand() {
  difference() {
    union() {
      translate([0, 0, 6]) cube([12, 17, 12], center=true);
      translate([0, 17/2, 0]) cylinder(h=12, r=7.5);
      translate([0, -17/2, 0]) cylinder(h=12, r=7.5+3);
    }

    // top cut
    translate([0, 17/2, 6]) cylinder(h=12, r=7.5+2);

    // hole
    translate([0, 17/2, 6]) rotate([0, 180, 0]) pinhole(h=6, t=tolerance);
    
    // bottom cut
    translate([0, -17/2, -1]) cylinder(h=14, r=7.5-2);
    
    // claw cut
    translate([0, -17, 7-1]) cube([4, 15, 14], center=true);
  }
}

module arm_upper() {
  difference() {
    union() {
      translate([0, 0, 6]) cube([12, 25, 12], center=true);
      translate([0, 25/2, 0]) cylinder(h=12, r=7.5);
      translate([0, -25/2, 0]) cylinder(h=12, r=7.5);
    }

    // top cut
    // translate([0, 25/2, 6]) cylinder(h=12, r=7.5+2);
    
    // bevel both sides
    translate([0, 25/2, 18-6]) rotate([0, 180, 0]) pinhole(h=6, t=tolerance);
    translate([0, 25/2, 0]) pinhole(h=6, t=tolerance);
    
    // bottom cut
    translate([0, -25/2, 6]) cylinder(h=12, r=7.5+2);

    // hole
    translate([0, -25/2, 6]) rotate([0, 180, 0]) pinhole(h=6, t=tolerance);
  }
}

module arm_lower() {
  difference() {
    union() {
      translate([0, 0, 6]) cube([12, 25, 12], center=true);
      translate([0, 25/2, 0]) cylinder(h=12, r=7.5);
      translate([0, -25/2, 0]) cylinder(h=12, r=7.5);
    }

    // top cut
    translate([0, 25/2, 6]) cylinder(h=12, r=7.5+2);
    
    // hole
    translate([0, 25/2, 0]) pinhole(h=12, t=tolerance);
    
    // bottom cut
    translate([0, -25/2, 6]) cylinder(h=12, r=7.5+2);

    // hole
    translate([0, -25/2, 0]) pinhole(h=12, t=tolerance);
  }
}

module logo() {
  // logo diameter = 38
  // bonus points for switching filament half way through... TODO: split up somehow to print a red and a black part and combine?
  union() {
    scale([0.75, 0.75, 0.75]) color(yellow) rotate([0, 0, -90]) import_stl("makerbot_logo.stl", convexity=30);
    difference() {
      translate([0, 0, 0]) cylinder(h=5, r=28.5/2+0.1);
      color(red) translate([0, 0, -2.5]) cylinder(h=5, r=28.5/2-1.9);
    }
    translate([0, 0, 5]) pin(h=6);
  }
}

module dial() {
  difference() {
    pintack(h=6);
    difference() {
      translate([0, 0, -1]) cylinder(r=6, h=2);
      cylinder(r=2, h=5);
      translate([0, 8, 0]) cube([16, 16, 3], center=true);
      rotate([0, 0, 42]) cube([1, 10, 3], center=true);
    }
  }
}

module body() {
  difference() {
    union() {
      translate([0, 0, 25]) cube([40, 30, 50], center=true);
      
      // front panel
      translate([0, -15, 23+2]) cube([34, 2, 44], center=true);
      translate([-20+7, -17+1, 7]) sphere(1, $fn=10);
      translate([20-7, -17+1, 7]) sphere(1, $fn=10);
      translate([-20+7, -17+1, 50-7]) sphere(1, $fn=10);
      translate([20-7, -17+1, 50-7]) sphere(1, $fn=10);

      // back panel
      translate([0, 15, 23+2]) cube([34, 2, 44], center=true);      
      translate([-20+7, 17-1, 7]) sphere(1, $fn=10);
      translate([20-7, 17-1, 7]) sphere(1, $fn=10);
      translate([-20+7, 17-1, 50-7]) sphere(1, $fn=10);
      translate([20-7, 17-1, 50-7]) sphere(1, $fn=10);

      // back bump
      translate([0, 16, 25]) rotate([90, 0, 0]) cylinder(h=2, r=7.5, center=true);
      
      // neck
      translate([0, 0, 50]) spring_mount();
      
      // arm bumps
      translate([-20-0.5, 0, 50-10]) rotate([0, 90, 0]) cylinder(h=2, r=7.5, center=true);
      mirror() translate([-20-0.5, 0, 50-10]) rotate([0, 90, 0]) cylinder(h=2, r=7.5, center=true);
    }
    
    // bottom holes
    translate([-10, 0, 0]) pinhole(h=10, t=tolerance);
    translate([10, 0, 0]) pinhole(h=10, t=tolerance);

    // arm holes
    translate([-20-1.5, 0, 50-10]) rotate([0, 90, 0]) translate([0, 0, 0]) pinhole(h=6, t=tolerance);
    translate([20+1.5, 0, 50-10]) rotate([0, -90, 0]) translate([0, 0, 0]) pinhole(h=6, t=tolerance);
  
    // back hole
    translate([0, 17, 25]) rotate([0, -90, 90]) translate([0, 0, 0]) pinhole(h=6, t=tolerance);

    // front top hole
    translate([0, -16, 50-17]) rotate([0, 90, 90]) translate([0, 0, 0]) pinhole(h=6, t=tolerance);

    // front bottom holes
    translate([0, -16, 9]) rotate([0, 90, 90]) translate([0, 0, 0]) pinhole(h=6, t=tolerance);
    // translate([-8, -16, 10]) rotate([0, 90, 90]) translate([0, 0, 0]) pinhole(h=6);
    // translate([8, -16, 10]) rotate([0, 90, 90]) translate([0, 0, 0]) pinhole(h=6);
  }
}

module spring_mount() {
  // neck
  cylinder(h=10, r=spring_inner_radius*1.25);
  
  // spring mount
  translate([0, 0, 10]) cylinder(h=10, r1=spring_inner_radius, r2=spring_inner_radius/1.3);
}


module leg() {
  difference() {
    union() {
      translate([0, 0, 15]) cube([14, 12, 30], center=true);
    }

    // top hole
    translate([0, 0, 30]) rotate([0, 180, 0]) pinhole(h=10, t=tolerance);
    
    // bottom hole
    pinhole(h=10, t=tolerance);
    
    // knee joint hole
    translate([0, 0, 15]) rotate([0, 90, 0]) translate([0, 0, -7]) pinhole(h=12, t=tolerance);
  }
}

module feet() {
  union() {
    translate([-10, 0, 0]) rotate([0, 0, -15]) foot();
    translate([10, 0, 0]) rotate([0, 0, 15]) foot();
  }
}

module foot() {
  difference() {
    union() {
      difference() {
        // half circle
        rotate([0, 0, 90]) translate([0, 9, 6]) rotate([90, 0, 0]) cylinder(r=15, h=18);
        // bottom cut
        translate([0, 0, -10.5+6]) cube([20, 32, 21], center=true);
        // top cut
        translate([0, 0, 5+20]) cube([20, 32, 10], center=true);
      }
    
      // bottom block
      translate([0, 0, 3]) cube([20, 32, 6], center=true);
    }

    // top hole
    translate([0, 0, 20]) rotate([0, 180, 0]) pinhole(h=10, t=tolerance);
    
    // bottom hole
    pinhole(h=10, t=tolerance);
  }
}

module base() {
  difference() {
    union() {
      cylinder(h=10, r=40);
      cylinder(h=15, r=28);
      translate([0, -40+5, 7.5]) cube([50, 10, 15], center=true);
    }

    translate([-10, 0, 15]) rotate([0, 180, 0]) pinhole(h=10, t=tolerance);
    translate([10, 0, 15]) rotate([0, 180, 0]) pinhole(h=10, t=tolerance);
    
    translate([0, 0, -1]) rotate([0, 0, 90]) import_stl("makerbot_logo.stl", convexity=30);
    
    // name
    translate([-12, -40+5-2.5, 7.3]) rotate([0, 0, -90]) rotate([0, 90, 0]) 8bit_str(["B","O","B"], 3, 1.5, 5);
  }
}

module pintack_small() {
  pintack(h=6, br=7.5);
}

module pintack_large() {
  pintack(h=12, br=7.5);
}

module pinpeg_small() {
  pinpeg(h=12);
}

module pinpeg_large() {
  pinpeg(h=20);
}
