$inlinecom /* */
/*==========================================Excelת��Ϊinc�ļ�===================================*/

$call=xls2gms r=busi!              i=rawdata.xls O=.\formatdata\busi.inc
$call=xls2gms r=bus!B1:M1 s=","   i=rawdata.xls O=.\formatdata\busitem.inc
$call=xls2gms r=bchi!              i=rawdata.xls O=.\formatdata\bchi.inc
$call=xls2gms r=bch!B1:N1 s=","   i=rawdata.xls O=.\formatdata\bchitem.inc
$call=xls2gms r=geni!              i=rawdata.xls O=.\formatdata\geni.inc
$call=xls2gms r=gen!B1:V1 s=","   i=rawdata.xls O=.\formatdata\genitem.inc

$call=xls2gms r=gen!               i=rawdata.xls O=.\formatdata\Dgen.inc
$call=xls2gms r=bus!               i=rawdata.xls O=.\formatdata\Dbus.inc
$call=xls2gms r=bch!            i=rawdata.xls O=.\formatdata\Dbch.inc


/*===============================================���˵��======================================*/
/*call=xls2gms:����xls2gms����,���www.gams.com/25.1/docs/T_XLS2GMS.html*/
/*r=          :������Χ(�����������������)                       */
/*i=          :�����·��                                             */
/*s=          :Ԫ�طָ���(�������gams�﷨),�����һ�еļ���Ҫ�Ӷ��ţ�һ�в���                             */
/*o=          :inc�ļ����·��                                          */



