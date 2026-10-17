v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -160 -220 -160 -180 {lab=VDD}
N 340 220 340 230 {lab=GND}
N 150 100 180 100 {lab=0}
N 150 -220 150 -180 {lab=VDD}
N 0 -220 150 -220 {lab=VDD}
N -160 -220 0 -220 {lab=VDD}
N 340 140 340 160 {lab=VDD}
N -160 60 -160 70 {lab=#net1}
N 60 -70 60 -60 {lab=#net2}
N 60 -140 60 -110 {lab=VDD}
N -50 -140 0 -140 {lab=VDD}
N -50 -140 -50 -110 {lab=VDD}
N 0 -220 0 -140 {lab=VDD}
N 0 -140 60 -140 {lab=VDD}
N -10 -110 10 -110 {lab=#net2}
N -50 -80 -50 -70 {lab=vb}
N -50 -70 -50 -60 {lab=vb}
N -50 -30 -50 0 {lab=0}
N -50 0 10 0 {lab=0}
N 60 -30 60 0 {lab=0}
N 10 0 10 10 {lab=0}
N 10 0 60 0 {lab=0}
N -80 -70 -50 -70 {lab=vb}
N 50 -180 110 -180 {lab=vb}
N 90 -30 150 -30 {lab=#net3}
N -60 100 110 100 {lab=#net1}
N 10 -110 10 -70 {lab=#net2}
N 10 -110 20 -110 {lab=#net2}
N 10 -70 60 -70 {lab=#net2}
N 60 -80 60 -70 {lab=#net2}
N -60 60 -60 100 {lab=#net1}
N -160 60 -60 60 {lab=#net1}
N -120 100 -60 100 {lab=#net1}
N 150 -30 150 70 {lab=#net3}
N -190 100 -160 100 {lab=0}
N 50 -200 50 -180 {lab=vb}
N -80 -180 50 -180 {lab=vb}
N 0 -270 0 -220 {lab=VDD}
N -160 130 -160 180 {lab=0}
N -160 -30 -160 60 {lab=#net1}
N -160 -30 -90 -30 {lab=#net1}
N -160 -150 -160 -30 {lab=#net1}
N 150 -150 150 -30 {lab=#net3}
N -80 -180 -80 -70 {lab=vb}
N -120 -180 -80 -180 {lab=vb}
N 150 200 150 210 {lab=0}
N 150 130 150 140 {lab=#net4}
C {gnd.sym} -160 180 0 0 {name=l1 lab=0}
C {vsource.sym} 340 190 0 1 {name=VDD value=3.3 savecurrent=false}
C {gnd.sym} 340 230 0 1 {name=l2 lab=GND}
C {lab_pin.sym} 340 140 0 1 {name=p1 sig_type=std_logic lab=VDD}
C {sg13g2_pr/annotate_fet_params.sym} 230 -20 0 0 {name=annot1 ref=M1}
C {sg13g2_pr/annotate_fet_params.sym} 230 -230 0 0 {name=annot4 ref=M4}
C {sg13g2_pr/annotate_fet_params.sym} -350 -10 0 0 {name=annot2 ref=M2}
C {sg13g2_pr/sg13_hv_nmos.sym} 130 100 0 0 {name=M1
l=4u
w=8.6u
ng=1
m=10
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -140 100 0 1 {name=M2
l=4u
w=4.3u
ng=1
m=5
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -140 -180 0 1 {name=M3
l=4u
w=5.13u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 130 -180 0 0 {name=M4
l=4u
w=5.13u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/annotate_fet_params.sym} -350 -230 0 0 {name=annot5 ref=M3}
C {gnd.sym} 180 100 0 0 {name=l5 lab=0}
C {devices/launcher.sym} -20 150 0 0 {name=h1
descr="simulate" 
tclcommand="xschem netlist; xschem simulate"
}
C {devices/launcher.sym} -20 210 0 0 {name=h3
descr="annotate OP" 
tclcommand="xschem raw_read $netlist_dir/[file tail [file rootname [xschem get current_name]]].raw; set show_hidden_texts 1; xschem annotate_op"
}
C {code.sym} 350 -110 0 0 {name=s1 only_toplevel=false value="
.include BMR2U.save
.control
* ---------- Operating point ----------
op
write BMR2U.raw
let id1_uA = abs(@n.xm1.nsg13_hv_nmos[ids])*1e6
let id2_uA = abs(@n.xm2.nsg13_hv_nmos[ids])*1e6
let gm1_uS = @n.xm1.nsg13_hv_nmos[gm]*1e6
let gm2_uS = @n.xm2.nsg13_hv_nmos[gm]*1e6
let vgs_M1 = v(net1)-v(net4)
let vgs_M2 = v(net1)
let vdsat_M1 = @n.xm1.nsg13_hv_nmos[vdss]
let vdsat_M2 = @n.xm2.nsg13_hv_nmos[vdss]
let vdsat_M3 = abs(@n.xm3.nsg13_hv_pmos[vdss])
let vdsat_M4 = abs(@n.xm4.nsg13_hv_pmos[vdss])
print v(vb) vgs_M1 vgs_M2
print id1_uA id2_uA gm1_uS gm2_uS
print vdsat_M1 vdsat_M2 vdsat_M3 vdsat_M4

* ---------- Line regulation (VDD sweep) ----------
dc vdd 0 4 10m
let id1_uA = @n.xm1.nsg13_hv_nmos[ids]*1e6
let id2_uA = @n.xm2.nsg13_hv_nmos[ids]*1e6
plot id1_uA id2_uA
meas dc id1_3p0 find id1_uA at=3.0
meas dc id1_3p6 find id1_uA at=3.6
let line_reg = (id1_3p6-id1_3p0)/id1_3p0/0.6*100
echo Line regulation [%/V] = $&line_reg

* ---------- Temperature coefficient (VDD = 3.3 V) ----------
dc temp -40 125 1
let id1_uA = abs(@n.xm1.nsg13_hv_nmos[ids])*1e6
let id2_uA = abs(@n.xm2.nsg13_hv_nmos[ids])*1e6
plot id1_uA id2_uA
meas dc id1_max max id1_uA
meas dc id1_min min id1_uA
meas dc id1_27 find id1_uA at=27
let tc = (id1_max-id1_min)/id1_27/165*1e6
echo TC [ppm/C] = $&tc
.endc
"}
C {code_shown.sym} 510 10 0 0 {name=s2 only_toplevel=false value="
.save all
.save @n.xm1.nsg13_hv_nmos[ids]
.save @n.xm2.nsg13_hv_nmos[ids]

"}
C {simulator_commands_shown.sym} 510 -310 0 0 {
        name=Libs_Ngspice
        simulator=ngspice
        only_toplevel=false
        value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"
      }
C {sg13g2_pr/sg13_hv_nmos.sym} 80 -30 0 1 {name=M5
l=4u
w=3u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -70 -30 0 0 {name=M6
l=4u
w=3u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 40 -110 0 0 {name=M7
l=4u
w=15.1u
ng=2
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -30 -110 0 1 {name=M8
l=4u
w=15.1u
ng=2
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {gnd.sym} 10 10 0 1 {name=l3 lab=0}
C {sg13g2_pr/annotate_fet_params.sym} -510 -120 0 0 {name=annot3 ref=M8}
C {gnd.sym} 150 210 0 0 {name=l6 lab=0}
C {gnd.sym} -190 100 0 0 {name=l7 lab=0}
C {lab_pin.sym} 0 -270 0 1 {name=p3 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 50 -200 0 1 {name=p4 sig_type=std_logic lab=vb}
C {sg13g2_pr/rppd.sym} 150 170 0 0 {name=R1
w=0.5e-6
l=56.4e-6
model=rppd
body=gnd
spiceprefix=X
b=0
 m=1
  mm_ok=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*@w + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
