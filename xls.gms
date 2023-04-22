$inlinecom /* */
/*==========================================Excel转化为inc文件===================================*/

$call=xls2gms r=busi!              i=rawdata.xls O=.\formatdata\busi.inc
$call=xls2gms r=bus!B1:M1 s=","   i=rawdata.xls O=.\formatdata\busitem.inc
$call=xls2gms r=bchi!              i=rawdata.xls O=.\formatdata\bchi.inc
$call=xls2gms r=bch!B1:N1 s=","   i=rawdata.xls O=.\formatdata\bchitem.inc
$call=xls2gms r=geni!              i=rawdata.xls O=.\formatdata\geni.inc
$call=xls2gms r=gen!B1:V1 s=","   i=rawdata.xls O=.\formatdata\genitem.inc

$call=xls2gms r=gen!               i=rawdata.xls O=.\formatdata\Dgen.inc
$call=xls2gms r=bus!               i=rawdata.xls O=.\formatdata\Dbus.inc
$call=xls2gms r=bch!            i=rawdata.xls O=.\formatdata\Dbch.inc


/*===============================================语句说明======================================*/
/*call=xls2gms:调用xls2gms工具,详见www.gams.com/25.1/docs/T_XLS2GMS.html*/
/*r=          :读入表格范围(这里读入的是整个表格)                       */
/*i=          :表格存放路径                                             */
/*s=          :元素分隔符(必须符合gams语法),如果是一行的集合要加逗号，一列不用                             */
/*o=          :inc文件输出路径                                          */



