//----------------------------------------------------------------------------------------------------------------------
// Customization Parameters:
 
//----------------------------------------------------------------------------------------------------------------------
 
min_wt = 3.0;
$fn=300;
 
t_dia = 42.0;
epc_dia = 25.4 * 1.25;
c_dia = 25.4;
filter_dia = 36.0;
filter_t = 2.0;
 
em_inner_dia = 41.4; // of the lens
emb_upper_dia = 47.2;
emb_lower_dia = 46.0;
 
emh_dia = 59.0 + 2 * 2.0;
emh_h = 6.0;
 
em_bf = 18.0;
zw_bf = 12.5;
bf_tol = 0.5;
 
asi_dia = 62.0;
asi_h = 28.0;
asi_t_h = 7.4;
asi_t_dia = 50.7;
 
zw_h = asi_t_h;
zw_sh = 5.0; // left/right side screw hole diameter
em_sh = zw_sh / 2;

ovl_h = 9.0;
ffd_tolerance = 1.5;

jh = em_bf - emh_h - ovl_h - ffd_tolerance;
echo(jh);

epch_h = asi_t_h - 0.5;

echo(ovl_h);
epch_dia = emh_dia;
fs_dia = 4.0; // knurled fixation screws M4
 
module e2t()
{
	h1=1.4;
	h2=2.3;
	t1=1.3;
	dist1=1.6;
	a1=43; // angles
	a2=64;
	a3=57;
	a4=62;
	a5=80;
	//a6=54;
	a7=6; // orientation marker
	b1=2.5;
	
	ah1 = atan((h2 - h1)/(a1 / 360 * (emb_upper_dia - t1) * 3.142)); // wedge angle
	ah2 = b1 * 360 / ((emb_upper_dia - t1) * 3.142);
	
	d1=3.0;
 
	union()
		{
			translate([0,0,(emh_h)/2])
			difference()
				{
					cylinder(d=emh_dia, h=emh_h, center=true);
					translate([0,0,0]) cylinder(d1=emb_lower_dia, d2=emb_upper_dia, h=emh_h+0.1, center=true);
				}
		}
 
	rotate([0,0,0])
	union()
		{
			translate([0, 0, emh_h-h2/2-dist1])
			difference()
				{
					rotate_extrude(angle=a1, convexity = 10) translate([emb_upper_dia/2-t1/2+1.0/2, 0, 0]) square([t1+1.0,h2], center=true);
					rotate([ah1,0,0]) translate([0, 0, -h2/2-5.0/2]) cylinder(d=emb_upper_dia, h=5.0, center=true);
				}
			translate([0, 0, (emh_h-h2-dist1+0.5)/2]) rotate_extrude(angle=ah2, convexity = 10) translate([emb_upper_dia/2-t1/2+1.0/2, 0, 0]) square([t1+1.0,emh_h-h2-dist1+0.5], center=true);
		}
	rotate([0,0,a1+a2])
	union()
		{
			translate([0, 0, emh_h-h2/2-dist1])
			difference()
				{
					rotate_extrude(angle=a3, convexity = 10) translate([emb_upper_dia/2-t1/2+1.0/2, 0, 0]) square([t1+1.0,h2], center=true);
					rotate([ah1,0,0]) translate([0, 0, -h2/2-5.0/2]) cylinder(d=emb_upper_dia, h=5.0, center=true);
				}
			rotate([0,0,0]) translate([0, 0, (emh_h-h2-dist1+0.5)/2]) rotate_extrude(angle=ah2, convexity = 10) translate([emb_upper_dia/2-t1/2+1.0/2, 0, 0]) square([t1+1.0,emh_h-h2-dist1+0.5], center=true);
		}
	rotate([0,0,a1+a2+a3+a4])
	union()
		{
			translate([0, 0, emh_h-h2/2-dist1])
			difference()
				{
					rotate_extrude(angle=a5, convexity = 10) translate([emb_upper_dia/2-t1/2+1.0/2, 0, 0]) square([t1+1.0,h2], center=true);
					rotate([ah1,0,0]) translate([0, 0, -h2/2-5.0/2]) cylinder(d=emb_upper_dia, h=5.0, center=true);
				}
			rotate([0,0,0]) translate([0, 0, (emh_h-h2-dist1+0.5)/2]) rotate_extrude(angle=ah2, convexity = 10) translate([emb_upper_dia/2-t1/2+1.0/2, 0, 0]) square([t1+1.0,emh_h-h2-dist1+0.5], center=true);
		}
 
	rotate([0,0,a1-a7]) translate([emh_dia/2,0,emh_h-d1/2-1]) rotate([0,90,0]) cylinder(d=d1, h=2, center=true); // orientation marker
	
	translate([0,0,-jh/2])
	difference() // overlap
		{
			cylinder(d2=epch_dia,d1=epc_dia + 2*4.0,h=jh, center=true);
			cylinder(d=epc_dia, h=jh+0.1, center=true);
		}

	translate([0,0,-((ovl_h))/2-jh])
	difference() // overlap
		{
			cylinder(d=epc_dia + 2*4.0, h=(ovl_h), center=true);
			cylinder(d=epc_dia, h=(ovl_h)+0.1, center=true);
			translate([0,0,-ovl_h/2+fs_dia/2+1.5])
			for (i=[0:2]) // eyepiece fixation screws
				{
					rotate([0,0,i*120])
					translate([0,((epc_dia)/2+(emh_dia)/2)/2,0])
					rotate([90,0,0])
					cylinder(d=fs_dia*0.8, h=(emh_dia)/2-(epc_dia)/2+1, center=true);
				}
		}
}
 
 
difference()
{
	union()
		{
			translate([0,0,0]) e2t();
		}
	*translate([0,0,-50]) cube([100,100,100]);
}
