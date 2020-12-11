#!/usr/bin/perl
#/*======================================================================*/
#/*	                         鏁版嵁鍙戦�佷綔涓氭ā鏉�                            */
#/*======================================================================*/
#/*  璇存槑: 1銆佹妯℃澘鐢ㄤ簬鍒涘缓鍙戦�佷綔涓�                                     */
#/*        2銆佹鏂囦欢鑷韩閲囩敤UTF8缂栫爜,杩愯鏃堕渶瑕佷娇鐢� etlbase.pm鍖�         */
#/*        3銆佷负渚夸簬寮�鍙戙�佹祴璇曪紝浣跨敤姝ゆā鏉挎椂椤诲厛璁剧疆宸ヤ綔鐜             */
#/*20140428 鍒濆鍒涘缓  By Pony xie, 褰撳墠浠呮敮鎸丆D鏂瑰紡                      */
#/*                                                                      */
#/*======================================================================*/
use strict;  
use Encode;    
my $AUTO_HOME = $ENV{"AUTO_HOME"};
my $BASEPM_PATH = $ENV{'AUTO_BASEPM_PATH'} || "${AUTO_HOME}/bin";
$BASEPM_PATH = '.' unless(-d $BASEPM_PATH);
require "${BASEPM_PATH}/etlbase.pm";


my $TX_DATE   = $BASE::TX_DATE;
#*******************  Main Program *********************
#01. setup job frequence 
BASE::setJobFrequency('d',''); #D,M,Q,Y,W,E

#02. 璁剧疆鏁版嵁鏂囦欢鍒楄〃
#    璁剧疆鏂规硶:  2.1 姣忎釜鏁版嵁鏂囦欢涓�琛�
#               2.2 鏁版嵁鏂囦欢鍩烘湰鐩綍$AUTO_EXPDATA_DIR/SYS/TXDATE/NationCD
#                   a. 榛樿鎯呭喌锛屼笉鐢ㄥ～鍐欏熀鏈洰褰�
#                   b. 濡傛灉瀵煎嚭鏃惰缃簡鐩稿鐩綍锛屽垯闇�濉啓鐩稿鐩綍
#                   c. 鑻ュ墠涓ょ鎯呭喌閮戒笉婊¤冻锛屽彲閫氳繃缁濆璺緞鎸囧畾鏁版嵁鏂囦欢
my $DataFileList =<<EOF;
#==============================================================
123
#==============================================================
EOF

#03. set file infomation
BASE::setSendFileAttrib(
	1,                                    #Param1: 鏄惁鐢熸垚list鏂囦欢  1:鐢熸垚  0:涓嶇敓鎴�
	"list",    #Param2: list鏂囦欢鍚嶇О
	0,                                    #Param3: list鏂囦欢鏍煎紡  0:鏁版嵁鏂囦欢鍚�+澶у皬  1:鏁版嵁鏂囦欢鍚�  2:绌烘枃浠�
	0,                                    #Param4: 鎴愬姛鍙戦�佸悗鏄惁鍒犻櫎鏁版嵁鏂囦欢  1:鍒犻櫎 0:涓嶅垹闄�
); 


#04. check arguments
exit(1) if ( $#ARGV < 0 );
open(STDERR, ">&STDOUT");

#05. call send command to send data file.
my $ret = BASE::run_send_command($DataFileList);
print BASE::getTime("[HH:MI:SS]")," Program terminated, ExitCode = $ret \n";
exit($ret);

