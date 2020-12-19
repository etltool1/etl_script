#!/usr/bin/perl
#/*************Head Section**************************************************************************/
#/*Script Use:                                                                                      */
#/*Create Date:  2014-08-15                                                                      */
#/*SDM Developed By:                                                                                */
#/*SDM Developed Date:                                                                              */
#/*SDM Checked By:                                                                                  */
#/*SDM Checked Date:                                                                                */
#/*Script Developed By:                                                                        */
#/*Script Checked By:                                                                               */
#/*Source table 1:                                                                   */
#/*Job Type: ETL-PDM                                                                                */
#/*ETL Frequency:           d                                                                       */
#/*ETL Policy:                                                        */
#/*Revision History: Revision Level          Date Revised          Comments          Initiated By   */
#/***************************************************************************************************/
use strict;
use Encode;
my $AUTO_HOME = $ENV{"AUTO_HOME"};
my $BASEPM_PATH = $ENV{'AUTO_BASEPM_PATH'} || "${AUTO_HOME}/bin";
$BASEPM_PATH = '.' unless(-d $BASEPM_PATH);
require "${BASEPM_PATH}/etlbase.pm";

my $RPSDATADB = $ENV{"AUTO_CHN_RPSDATADB"};
my $TX_DATE   = $BASE::TX_DATE;

#濉啓鍙栨暟SQL
#============================================================
sub getSQL{
		#鐢ㄦ硶: 灏嗗彇鏁癝QL璇彞宓屽湪涓や釜EOF_SQL鏍囪涔嬮棿
		#娉ㄦ剰锛�1銆佸彧鑳芥槸涓�涓畬鏁寸殑SELECT璇彞
		#      2銆佸鏋滃瓧娈典笂鏈夎绠楁搷浣滐紝鍒欏繀椤绘寚瀹氬埆鍚�
		#      3銆佸鏋滄湁Order By璇彞锛屽垯蹇呴』鍐欏湪SQL鏈�鍚�
#============================================================
my $SQL=<<EOF_SQL;
--瀵煎嚭鏁版嵁
select * from table_300;
EOF_SQL
return \$SQL;
}

#*******************  Main Program *********************
#01. setup job frequence
BASE::setJobFrequency('d',''); #D,M,Q,Y,W,E

#02. set data file format info
BASE::setExportFileAttrib(
	"dataFileName",   #Param1 鏁版嵁鏂囦欢鏂囦欢鍚�
	0, 			             #Param2 鏁版嵁鏂囦欢鏄惁鍘嬬缉 0:涓嶅帇缂� 1锛氫娇鐢╣zip鍘嬬缉 2锛氫娇鐢╟ompress鍘嬬缉
	1, 			             #Param3 鏁版嵁鏂囦欢鍒嗛殧鏍煎紡 1锛氬彉闀� 2锛氬畾闀�
	0,                       #Param4 鏁版嵁鏂囦欢缂栫爜鏍煎紡 0:榛樿(鍥藉唴GBK銆佹捣澶栬UTF8) 1:GBK  2:UTF8
	0,                       #Param5 鏁版嵁搴撹〃瀛楃缂栫爜鏍煎紡 0:榛樿(鍥藉唴GBK銆佹捣澶栬UTF8) 1:GBK  2:UTF8
	chr(15),   	             #Param6 鍒嗛殧绗︼紝鍙互鏄涓瓧绗�
	''						 #Param7 鏁版嵁鏂囦欢鐩稿鐩綍(榛樿:DATAEXP/绯荤粺XXX/浼氳鏃ユ湡YYYYMMDD)
);


#03. check arguments
exit(1) if ( $#ARGV < 0 );
open(STDERR, ">&STDOUT");

#04. call export command to export data file.
my $ret = BASE::run_export_command(getSQL());
print BASE::getTime("[HH:MI:SS]")," Program terminated, ExitCode = $ret \n";
exit($ret);

