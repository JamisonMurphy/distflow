***********ieee case33mg.m distflow test
$inlinecom /* */
/*========数据导入==============*/
/*========导入集合元素==========*/
set bus     '节点编号           '/
$include '.\formatdata\busi.inc'
/;
set busitem '节点数据组成       '/
$include '.\formatdata\busitem.inc'
/;
set bch     '支路编号           '/
$include '.\formatdata\bchi.inc'
/;
set bchitem '支路数据组成       '/
$include '.\formatdata\bchitem.inc'
/;
set gen     '发电机编号         '/
$include '.\formatdata\geni.inc'
/;
set genitem '发电机数据组成     '/
$include '.\formatdata\genitem.inc'
/;

alias(i,j,bus)
/*========导入系统参数==========*/
table Dbus(bus,busitem)
$include '.\formatdata\Dbus.inc'
table Dbch(bch,bchitem)
$include '.\formatdata\Dbch.inc'
table Dgen(gen,genitem)
$include '.\formatdata\Dgen.inc'
;



/*===========计算标幺值==========*/
*display Dbus,Dgen,Dbch;
parameter SB '基准功率MVA' /1/,UB '基准电压kV'/12.66/,ZB '基准阻抗ohm';
ZB=UB*UB/SB;
*p.u.
*Dbus(bus,'Pd')=Dbus(bus,'Pd')/SB;
*Dbus(bus,'Qd')=Dbus(bus,'Qd')/SB;

Dgen(gen,'Pmax')=Dgen(gen,'Pmax')/SB;
Dgen(gen,'Pmin')=Dgen(gen,'Pmin')/SB;
Dgen(gen,'Qmax')=Dgen(gen,'Qmax')/SB;
Dgen(gen,'Qmin')=Dgen(gen,'Qmin')/SB;

*Dbch(bch,'r')=Dbch(bch,'r')/ZB;
*Dbch(bch,'x')=Dbch(bch,'x')/ZB;
**Gij,Bij
parameters bchsG(bch),bchsB(bch);

bchsG(bch)=Dbch(bch,"R")/(Dbch(bch,"R")**2+Dbch(bch,"X")**2);
bchsB(bch)=-Dbch(bch,"X")/(Dbch(bch,"R")**2+Dbch(bch,"X")**2);
parameters G0(i,j),B0(i,j);
loop(i,
         loop(j,
         G0(i,j)=-sum(bch$( (Dbch(bch,'fbus') eq ord(i) and Dbch(bch,'tbus') eq ord(j)) or (Dbch(bch,'fbus') eq ord(j) and Dbch(bch,'tbus') eq ord(i))),bchsG(bch));
         B0(i,j)=-sum(bch$( (Dbch(bch,'fbus') eq ord(i) and Dbch(bch,'tbus') eq ord(j)) or (Dbch(bch,'fbus') eq ord(j) and Dbch(bch,'tbus') eq ord(i))),bchsB(bch));

         );


         G0(i,i)=sum(bch$((Dbch(bch,'fbus') eq ord(i)) or (Dbch(bch,'tbus') eq ord(i))),bchsG(bch));
         B0(i,i)=sum(bch$((Dbch(bch,'fbus') eq ord(i)) or (Dbch(bch,'tbus') eq ord(i))),bchsB(bch))+0.5*sum(bch$((Dbch(bch,'fbus') eq ord(i)) or (Dbch(bch,'tbus') eq ord(i))),Dbch(bch,'b'));


)
display G0,B0;
parameter Bij(i,j),Gij(i,j);
Bij(i,j)=B0(i,j);Gij(i,j)=G0(i,j);

display Gij,Bij;




*1 Distflow 最优潮流模型
/*=============定义变量=========*/

variable Seta(bus),Pg(gen),Qg(gen),Pij(bch),Qij(bch),theta(bch),P(i),Q(i);
Pg.up(gen)=Dgen(gen,'Pmax');Pg.lo(gen)=Dgen(gen,'Pmin');
Qg.up(gen)=Dgen(gen,'Qmax');Qg.lo(gen)=Dgen(gen,'Qmin');
Seta.fx('bus1')=0;
*V.l(bus)=1;Seta.l(bus)=1;
*V.up(bus)=1.1;V.lo(bus)=0.9;
variable cost,U(i) 'V^2',lij(bch) 'Iij^2';
U.up(bus)=1.1*1.1;U.lo(bus)=0.9*0.9;
U.l(bus)=1;
*variable V(bus),Iij(bch);
/*=============方程=============*/

**1交流最优潮流
*equations equP(j),equQ(j);
*equP(i)..    sum(gen$(Dgen(gen,'bus') eq ord(i)),Pg(gen))-Dbus(i,"Pd")=E=V(i)*sum(j,V(j)*(Gij(i,j)*cos(Seta(i)-Seta(j))+Bij(i,j)*sin(Seta(i)-Seta(j))));
*equQ(i)..    sum(gen$(Dgen(gen,'bus') eq ord(i)),Qg(gen))-Dbus(i,"Qd")=E=V(i)*sum(j,V(j)*(Gij(i,j)*sin(Seta(i)-Seta(j))-Bij(i,j)*cos(Seta(i)-Seta(j))));

**2orgin distflow
*equation  e1,e2;
*e1(bch).. sum(i$(Dbch(bch,'fbus') eq ord(i)),V(i)*cos(seta(i)))-sum(j$(Dbch(bch,'tbus') eq ord(j)),V(j)*cos(seta(j))) =E= Dbch(bch,'r')*Iij(bch)*cos(theta(bch))-Dbch(bch,'x')*Iij(bch)*sin(theta(bch));
*e2(bch).. sum(i$(Dbch(bch,'fbus') eq ord(i)),V(i)*sin(seta(i)))-sum(j$(Dbch(bch,'tbus') eq ord(j)),V(j)*sin(seta(j))) =E= Dbch(bch,'r')*Iij(bch)*sin(theta(bch))+Dbch(bch,'x')*Iij(bch)*cos(theta(bch));

*equation  e3,e4;
*e3(bch).. Pij(bch)=e= sum(i$(Dbch(bch,'fbus') eq ord(i)),V(i)*cos(seta(i)))*Iij(bch)*cos(theta(bch))+sum(i$(Dbch(bch,'fbus') eq ord(i)),V(i)*sin(seta(i)))*Iij(bch)*sin(theta(bch));
*e4(bch).. Qij(bch)=e= sum(i$(Dbch(bch,'fbus') eq ord(i)),V(i)*sin(seta(i)))*Iij(bch)*cos(theta(bch))-sum(i$(Dbch(bch,'fbus') eq ord(i)),V(i)*cos(seta(i)))*Iij(bch)*sin(theta(bch));

*equation e5,e6;
*e5(j).. sum(gen$(Dgen(gen,'bus') eq ord(j)),Pg(gen))-Dbus(j,'Pd') =e= sum(bch$(Dbch(bch,'fbus') eq ord(j)),Pij(bch))-sum(bch$(Dbch(bch,'tbus') eq ord(j)),Pij(bch)-Dbch(bch,'r')*sqr(Iij(bch)));
*e6(j).. sum(gen$(Dgen(gen,'bus') eq ord(j)),Qg(gen))-Dbus(j,'Qd') =e= sum(bch$(Dbch(bch,'fbus') eq ord(j)),Qij(bch))-sum(bch$(Dbch(bch,'tbus') eq ord(j)),Qij(bch)-Dbch(bch,'x')*sqr(Iij(bch)));

**3 distflow optimized
equation  e1;
e1(bch)..  sum(j$(Dbch(bch,'tbus') eq ord(j)),U(j)) =E= sum(i$(Dbch(bch,'fbus') eq ord(i)),U(i))-2*(Dbch(bch,'r')*Pij(bch)+Dbch(bch,'x')*Qij(bch))+(sqr(Dbch(bch,'r'))+sqr(Dbch(bch,'x')))*lij(bch);

equation  e3;
e3(bch)..  sqr(2*Pij(bch))+sqr(2*Qij(bch))+sqr[lij(bch)-sum[i$(Dbch(bch,'fbus') eq ord(i)),U(i)]] =L= sqr(lij(bch)+sum[i$(Dbch(bch,'fbus') eq ord(i)),U(i)]);
*e3(bch).. sqr(Pij(bch))+sqr(Qij(bch)) =l= lij(bch)*sum(i$(Dbch(bch,'fbus') eq ord(i)),U(i));

equation e5,e6;
e5(j).. sum(gen$(Dgen(gen,'bus') eq ord(j)),Pg(gen))-Dbus(j,'Pd') =e= sum(bch$(Dbch(bch,'fbus') eq ord(j)),Pij(bch))-sum(bch$(Dbch(bch,'tbus') eq ord(j)),Pij(bch)-Dbch(bch,'r')*lij(bch));
e6(j).. sum(gen$(Dgen(gen,'bus') eq ord(j)),Qg(gen))-Dbus(j,'Qd') =e= sum(bch$(Dbch(bch,'fbus') eq ord(j)),Qij(bch))-sum(bch$(Dbch(bch,'tbus') eq ord(j)),Qij(bch)-Dbch(bch,'x')*lij(bch));



equation e99;
e99.. cost =e= 20*sum(gen,Pg(gen));

model     OPF41 /all/;
solve     OPF41 use QCP min cost;
*execute_unload "B.gdx" Bij;
*execute 'gdxxrw.exe B.gdx Par=Bij';
parameter voltage(bus);
voltage(i)=sqrt(U.l(i));
display voltage;







